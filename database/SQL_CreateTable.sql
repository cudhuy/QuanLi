-- File: SQL_CreateTable.sql
-- This script creates the database and tables for PostgreSQL.
-- Run this in pgAdmin or psql.
-- CREATE DATABASE quanly_nhahang;

-- Connect to the database first if needed: \c quanly_nhahang
-- 1️⃣ Nhân viên
CREATE TYPE gender_enum AS ENUM ('MALE', 'FEMALE', 'OTHER');

CREATE TABLE employees (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    gender gender_enum DEFAULT 'OTHER',
    address TEXT,
    created_at TIMESTAMP DEFAULT NOW ()
);

-- 2️⃣ Tài khoản nhân viên hệ thống
CREATE TYPE role_enum AS ENUM ('STAFF', 'MANAGER', 'OWNER');

CREATE TABLE admins (
    id BIGSERIAL PRIMARY KEY,
    employee_id BIGINT NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role role_enum DEFAULT 'STAFF',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (employee_id) REFERENCES employees (id) ON DELETE CASCADE
);

-- 3️⃣ Bảng khách hàng
CREATE TABLE customers (
    idcustomers BIGSERIAL PRIMARY KEY,
    phone VARCHAR(20) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW ()
);

-- 4️⃣ Bảng bàn ăn
CREATE TABLE tables (
    id BIGSERIAL PRIMARY KEY,
    table_number VARCHAR(10) UNIQUE NOT NULL,
    qr_code_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE
);

-- 5️⃣ Bảng phiên QR
CREATE TYPE qr_session_status_enum AS ENUM ('ACTIVE', 'COMPLETED');

CREATE TABLE qr_sessions (
    id BIGSERIAL PRIMARY KEY,
    table_id BIGINT NOT NULL,
    customer_id BIGINT,
    status qr_session_status_enum DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (table_id) REFERENCES tables (id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers (idcustomers) ON DELETE SET NULL
);

-- 6️⃣ Bảng danh mục món ăn
CREATE TABLE menu_categories (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    is_available BOOLEAN DEFAULT TRUE
);

-- 7️⃣ Bảng món ăn
CREATE TABLE menu_items (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(12, 2) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    is_available BOOLEAN DEFAULT TRUE
);

-- 8️⃣ Bảng trung gian món ăn - danh mục
CREATE TABLE menu_item_categories (
    id BIGSERIAL PRIMARY KEY,
    item_id BIGINT,
    category_id BIGINT,
    FOREIGN KEY (item_id) REFERENCES menu_items (id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES menu_categories (id) ON DELETE CASCADE
);

-- 9️⃣ Bảng lịch sử giá món ăn
CREATE TABLE menu_price_history (
    id BIGSERIAL PRIMARY KEY,
    item_id BIGINT,
    old_price DECIMAL(12, 2),
    new_price DECIMAL(12, 2),
    changed_at TIMESTAMP DEFAULT NOW (),
    changed_by BIGINT,
    FOREIGN KEY (item_id) REFERENCES menu_items (id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by) REFERENCES admins (id) ON DELETE SET NULL
);

-- 🔟 Bảng giỏ hàng
CREATE TYPE cart_status_enum AS ENUM ('ACTIVE', 'ORDERED', 'CANCELLED');

CREATE TABLE carts (
    id BIGSERIAL PRIMARY KEY,
    qr_session_id BIGINT,
    status cart_status_enum DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (qr_session_id) REFERENCES qr_sessions (id) ON DELETE CASCADE
);

-- 11️⃣ Chi tiết giỏ hàng
CREATE TYPE cart_item_status_enum AS ENUM ('IN_CART', 'ORDERED');

CREATE TABLE cart_items (
    id BIGSERIAL PRIMARY KEY,
    cart_id BIGINT NOT NULL,
    menu_item_id BIGINT NOT NULL,
    quantity INT DEFAULT 1,
    note TEXT,
    unit_price DECIMAL(12, 2),
    status cart_item_status_enum DEFAULT 'IN_CART',
    created_at TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (cart_id) REFERENCES carts (id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items (id) ON DELETE CASCADE
);

-- 12️⃣ Bảng đơn đặt món
CREATE TYPE order_status_enum AS ENUM ('NEW', 'IN_PROGRESS', 'DONE', 'PAID', 'CANCELLED');

CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    qr_session_id BIGINT NOT NULL,
    admin_id BIGINT,
    total_price DECIMAL(12, 2) DEFAULT 0,
    status order_status_enum DEFAULT 'NEW',
    created_at TIMESTAMP DEFAULT NOW (),
    updated_at TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (qr_session_id) REFERENCES qr_sessions (id) ON DELETE CASCADE,
    FOREIGN KEY (admin_id) REFERENCES admins (id) ON DELETE SET NULL
);

-- 13️⃣ Chi tiết món trong đơn hàng
CREATE TABLE order_items (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT NOT NULL,
    cart_item_id BIGINT,
    menu_item_id BIGINT NOT NULL,
    quantity INT DEFAULT 1,
    note TEXT,
    unit_price DECIMAL(12, 2),
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items (id) ON DELETE CASCADE,
    FOREIGN KEY (cart_item_id) REFERENCES cart_items (id) ON DELETE SET NULL
);

-- 14️⃣ Bảng thanh toán
CREATE TYPE payment_method_enum AS ENUM ('BANKING', 'CASH');

CREATE TABLE payments (
    id BIGSERIAL PRIMARY KEY,
    qr_sessions_id BIGINT,
    admin_id BIGINT,
    method payment_method_enum NOT NULL,
    amount DECIMAL(12, 2),
    paid_at TIMESTAMP DEFAULT NOW (),
    printed_bill BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (admin_id) REFERENCES admins (id) ON DELETE CASCADE,
    FOREIGN KEY (qr_sessions_id) REFERENCES qr_sessions (id) ON DELETE CASCADE
);

-- 15️⃣ Tích điểm khách hàng
CREATE TABLE reward_points (
    id BIGSERIAL PRIMARY KEY,
    customer_id BIGINT,
    points INT DEFAULT 0,
    updated_at TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (customer_id) REFERENCES customers (idcustomers) ON DELETE CASCADE
);

-- 16️⃣ Đánh giá tổng thể bữa ăn
CREATE TABLE reviews (
    id BIGSERIAL PRIMARY KEY,
    qr_session_id BIGINT,
    rating INT CHECK (
        rating >= 1
        AND rating <= 5
    ),
    comment TEXT,
    created_at TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (qr_session_id) REFERENCES qr_sessions (id) ON DELETE CASCADE
);

-- 17️⃣ Đánh giá từng món ăn
CREATE TABLE menu_reviews (
    id BIGSERIAL PRIMARY KEY,
    item_id BIGINT,
    qr_session_id BIGINT,
    rating INT CHECK (
        rating >= 1
        AND rating <= 5
    ),
    comment TEXT,
    created_at TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (item_id) REFERENCES menu_items (id) ON DELETE CASCADE,
    FOREIGN KEY (qr_session_id) REFERENCES qr_sessions (id) ON DELETE CASCADE
);

-- 18️⃣ Lịch sử chat
CREATE TYPE chat_sender_enum AS ENUM ('USER', 'BOT');

CREATE TABLE chats (
    id BIGSERIAL PRIMARY KEY,
    qr_session_id BIGINT,
    sender chat_sender_enum,
    message TEXT,
    intent VARCHAR(100),
    timestamp TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (qr_session_id) REFERENCES qr_sessions (id) ON DELETE CASCADE
);

-- 19️⃣ Thông báo
CREATE TYPE notification_target_type_enum AS ENUM ('CUSTOMER', 'STAFF', 'ALL');

CREATE TYPE notification_type_enum AS ENUM (
    'ORDER_UPDATE',
    'CALL_STAFF',
    'PAYMENT',
    'REVIEW',
    'INVENTORY',
    'SYSTEM',
    'SUCCESS',
    'ERROR',
    'WARNING',
    'INFO'
);

CREATE TABLE notifications (
    id BIGSERIAL PRIMARY KEY,
    target_type notification_target_type_enum NOT NULL,
    target_id BIGINT,
    title VARCHAR(255) NOT NULL,
    message TEXT,
    type notification_type_enum DEFAULT 'SYSTEM',
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW (),
    priority ENUM ('high', 'medium', 'low') DEFAULT 'medium',
    action_url VARCHAR(500),
    metadata JSONB
);

CREATE INDEX idx_target ON notifications (target_type, target_id);

CREATE INDEX idx_created_at ON notifications (created_at);

CREATE INDEX idx_is_read ON notifications (is_read);

CREATE INDEX idx_type ON notifications (type);

CREATE INDEX idx_priority ON notifications (priority);