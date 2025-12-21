import { Pool } from "pg";
import dotenv from "dotenv";

dotenv.config();

// Prefer DATABASE_URL if provided, otherwise fall back to individual fields
const pgPool = new Pool({
  connectionString: process.env.DATABASE_URL,
  host: process.env.DB_HOST || "localhost",
  port: Number(process.env.DB_PORT) || 5432,
  user: process.env.DB_USER || "postgres",
  password: process.env.DB_PASSWORD || "",
  database: process.env.DB_NAME || "postgres",
  max: 10,
});

// Convert MySQL-style "?" placeholders to PostgreSQL "$1, $2..."
function mapPlaceholders(sql) {
  let index = 0;
  return sql.replace(/\?/g, () => {
    index += 1;
    return `$${index}`;
  });
}

// Auto-append RETURNING * for INSERT so we can emulate insertId
function ensureReturning(sql) {
  const trimmed = sql.trim();
  const isInsert = trimmed.toLowerCase().startsWith("insert");
  const hasReturning = /returning\s+/i.test(sql);
  if (isInsert && !hasReturning) {
    return `${sql} RETURNING *`;
  }
  return sql;
}

async function runQuery(client, sql, params = []) {
  const text = ensureReturning(mapPlaceholders(sql));
  const result = await client.query(text, params);

  if (result.command === "SELECT") {
    // Keep mysql2-like shape: [rows]
    return [result.rows];
  }

  if (result.command === "INSERT") {
    const firstRow = result.rows?.[0];
    const insertId = firstRow ? Object.values(firstRow)[0] : null;
    return [
      {
        insertId,
        affectedRows: result.rowCount,
        rows: result.rows,
      },
    ];
  }

  return [
    {
      affectedRows: result.rowCount,
      rows: result.rows,
    },
  ];
}

export const pool = {
  query: (sql, params) => runQuery(pgPool, sql, params),
  execute: (sql, params) => runQuery(pgPool, sql, params),
  getConnection: async () => {
    const client = await pgPool.connect();
    return {
      query: (sql, params) => runQuery(client, sql, params),
      execute: (sql, params) => runQuery(client, sql, params),
      beginTransaction: () => client.query("BEGIN"),
      commit: () => client.query("COMMIT"),
      rollback: () => client.query("ROLLBACK"),
      release: () => client.release(),
    };
  },
};

export async function query(sql, params) {
  const [rows] = await runQuery(pgPool, sql, params);
  return rows;
}
