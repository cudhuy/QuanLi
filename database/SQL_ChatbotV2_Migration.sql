-- ============================================
-- Migration: Chatbot V2 - OpenAI Assistants API (PostgreSQL)
-- Version: 2.0
-- Date: 2025-11-29
-- Description: T?o tables cho h? th?ng chatbot m?i
-- ============================================

DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'chat_thread_status') THEN
        CREATE TYPE chat_thread_status AS ENUM ('ACTIVE', 'ARCHIVED');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'chat_message_role') THEN
        CREATE TYPE chat_message_role AS ENUM ('USER', 'ASSISTANT');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'chat_message_sentiment') THEN
        CREATE TYPE chat_message_sentiment AS ENUM ('POSITIVE', 'NEUTRAL', 'NEGATIVE');
    END IF;
END $$;

-- B?ng chat_threads: L?u mapping gi?a QR session v? OpenAI thread
CREATE TABLE IF NOT EXISTS chat_threads (
    id BIGSERIAL PRIMARY KEY,
    qr_session_id BIGINT NOT NULL,
    openai_thread_id VARCHAR(100) NOT NULL,
    assistant_id VARCHAR(100) NOT NULL,
    status chat_thread_status DEFAULT 'ACTIVE',
    message_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_thread_id ON chat_threads (openai_thread_id);
CREATE INDEX IF NOT EXISTS idx_qr_session ON chat_threads (qr_session_id);
CREATE INDEX IF NOT EXISTS idx_status ON chat_threads (status);
CREATE INDEX IF NOT EXISTS idx_created ON chat_threads (created_at);

-- B?ng chat_messages: L?u l?ch s? messages (optional - ?? analytics)
CREATE TABLE IF NOT EXISTS chat_messages (
    id BIGSERIAL PRIMARY KEY,
    thread_id BIGINT NULL,
    qr_session_id BIGINT NOT NULL,
    role chat_message_role NOT NULL,
    content TEXT NOT NULL,

    -- Analytics fields
    intent VARCHAR(100) NULL,
    sentiment chat_message_sentiment NULL,

    -- Metadata
    tokens_used INT DEFAULT 0,
    response_time_ms INT DEFAULT 0,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_thread ON chat_messages (thread_id);
CREATE INDEX IF NOT EXISTS idx_session ON chat_messages (qr_session_id);
CREATE INDEX IF NOT EXISTS idx_role ON chat_messages (role);
CREATE INDEX IF NOT EXISTS idx_intent ON chat_messages (intent);
CREATE INDEX IF NOT EXISTS idx_msg_created ON chat_messages (created_at);

-- B?ng chat_analytics: Th?ng k? t?ng h?p theo ng?y
CREATE TABLE IF NOT EXISTS chat_analytics (
    id BIGSERIAL PRIMARY KEY,

    -- Time dimension
    date DATE NOT NULL,

    -- Metrics
    total_conversations INT DEFAULT 0,
    total_messages INT DEFAULT 0,

    -- Intent breakdown (JSON)
    intent_counts JSONB NULL,

    -- Sentiment breakdown
    positive_count INT DEFAULT 0,
    neutral_count INT DEFAULT 0,
    negative_count INT DEFAULT 0,

    -- Performance
    avg_response_time_ms INT DEFAULT 0,
    total_tokens_used INT DEFAULT 0,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX IF NOT EXISTS unique_date ON chat_analytics (date);
CREATE INDEX IF NOT EXISTS idx_date ON chat_analytics (date);
