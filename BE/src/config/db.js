import dotenv from 'dotenv';
import pkg from 'pg';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

dotenv.config();

const { Pool } = pkg;

// Resolve __dirname in ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Base PostgreSQL config (fallback to individual vars when DATABASE_URL is not provided)
const baseConfig = {
    connectionString: process.env.DATABASE_URL || undefined,
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT, 10) || 5432,
    user: process.env.DB_USER || 'postgres',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'postgres',
    max: 10,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 30000,
};

// Optional SSL support (for cloud Postgres)
if (process.env.DB_SSL_MODE === 'REQUIRED') {
    const caCertPath = path.join(__dirname, '../../ca-certificate.pem');
    baseConfig.ssl = {
        rejectUnauthorized: fs.existsSync(caCertPath),
        ca: fs.existsSync(caCertPath) ? fs.readFileSync(caCertPath) : undefined,
    };
    console.log('Database SSL enabled');
}

const pgPool = new Pool(baseConfig);

// Auto-append RETURNING * for INSERT statements (to expose insertId like sql)
function ensureReturning(sql = '') {
    const isInsert = /^\s*insert\s+/i.test(sql);
    const hasReturning = /returning\s+/i.test(sql);
    if (isInsert && !hasReturning) {
        return `${sql} RETURNING *`;
    }
    return sql;
}

// Build parametrized query (handles arrays for IN (?))
function buildQuery(sql = '', params = []) {
    const sqlWithReturning = ensureReturning(sql);
    const segments = sqlWithReturning.split('?');
    let text = segments[0];
    const values = [];
    let placeholderIndex = 0;

    for (let i = 0; i < params.length; i++) {
        const param = params[i];
        if (Array.isArray(param)) {
            const placeholders = param.map(() => `$${++placeholderIndex}`).join(', ');
            text += placeholders;
            values.push(...param);
        } else {
            text += `$${++placeholderIndex}`;
            values.push(param);
        }
        text += segments[i + 1];
    }

    return { text, values };
}

// Execute query and return a sql-like result shape
async function execute(sql, params = [], client = pgPool) {
    const { text, values } = buildQuery(sql, params);
    const result = await client.query(text, values);
    const command = (result.command || '').toUpperCase();

    if (command === 'SELECT') {
        return result.rows;
    }

    const rows = result.rows || [];
    const insertId = rows[0]?.id ?? null;

    return {
        insertId,
        affectedRows: result.rowCount ?? 0,
        rows,
    };
}

// sql-compatible pool shim
export const pool = {
    async query(sql, params = []) {
        const res = await execute(sql, params, pgPool);
        return [res];
    },
    async getConnection() {
        const client = await pgPool.connect();
        return {
            async query(sql, params = []) {
                const res = await execute(sql, params, client);
                return [res];
            },
            async beginTransaction() {
                await client.query('BEGIN');
            },
            async commit() {
                await client.query('COMMIT');
            },
            async rollback() {
                await client.query('ROLLBACK');
            },
            release() {
                client.release();
            },
        };
    },
};

// Test connection on startup
pgPool.connect()
    .then((client) => {
        console.log('PostgreSQL connected successfully!');
        console.log(`Host: ${baseConfig.host || 'from DATABASE_URL'}`);
        console.log(`Database: ${baseConfig.database || 'from DATABASE_URL'}`);
        client.release();
    })
    .catch((err) => {
        console.error('PostgreSQL connection failed:', err.message);
        console.error('Check your .env configuration!');
    });

// Convenience helper mirroring previous export
export async function query(sql, params = []) {
    return execute(sql, params, pgPool);
}
