-- PostgreSQL schema for DATN_NH

-- Enum types
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'qr_session_status') THEN
        CREATE TYPE qr_session_status AS ENUM ('ACTIVE', 'COMPLETED');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'cart_status') THEN
        CREATE TYPE cart_status AS ENUM ('ACTIVE', 'ORDERED', 'CANCELLED');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'cart_item_status') THEN
        CREATE TYPE cart_item_status AS ENUM ('IN_CART', 'ORDERED');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'order_status') THEN
        CREATE TYPE order_status AS ENUM ('NEW', 'IN_PROGRESS', 'DONE', 'PAID', 'CANCELLED');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_method') THEN
        CREATE TYPE payment_method AS ENUM ('BANKING', 'CASH');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_status') THEN
        CREATE TYPE payment_status AS ENUM ('PENDING', 'PAID', 'FAILED', 'REFUNDED');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'chat_sender') THEN
        CREATE TYPE chat_sender AS ENUM ('USER', 'BOT');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'admin_role') THEN
        CREATE TYPE admin_role AS ENUM ('STAFF', 'MANAGER', 'OWNER');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'employee_gender') THEN
        CREATE TYPE employee_gender AS ENUM ('MALE', 'FEMALE', 'OTHER');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'notification_target_type') THEN
        CREATE TYPE notification_target_type AS ENUM ('CUSTOMER', 'STAFF', 'ALL');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'notification_type') THEN
        CREATE TYPE notification_type AS ENUM (
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
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'notification_priority') THEN
        CREATE TYPE notification_priority AS ENUM ('high', 'medium', 'low');
    END IF;
END $$;

-- Employees
CREATE TABLE employees (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    gender employee_gender DEFAULT 'OTHER',
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

-- Admins
CREATE TABLE admins (
    id BIGSERIAL PRIMARY KEY,
    employee_id BIGINT NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role admin_role DEFAULT 'STAFF',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE
);

-- Customers
CREATE TABLE customers (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NULL,
    email VARCHAR(100) UNIQUE NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    points INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL DEFAULT NULL
);

-- Tables
CREATE TABLE tables (
    id BIGSERIAL PRIMARY KEY,
    table_number VARCHAR(10) UNIQUE NOT NULL,
    qr_code_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    deleted_at TIMESTAMP DEFAULT NULL
);

-- QR sessions
CREATE TABLE qr_sessions (
    id BIGSERIAL PRIMARY KEY,
    table_id BIGINT NOT NULL,
    customer_id BIGINT,
    status qr_session_status DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expired_at TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (table_id) REFERENCES tables(id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL
);

CREATE INDEX idx_qr_sessions_status_expired ON qr_sessions(status, expired_at);

-- Menu categories
CREATE TABLE menu_categories (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    is_available BOOLEAN DEFAULT TRUE,
    deleted_at TIMESTAMP DEFAULT NULL
);

-- Menu items
CREATE TABLE menu_items (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP DEFAULT NULL
);

-- Menu item categories
CREATE TABLE menu_item_categories (
    id BIGSERIAL PRIMARY KEY,
    item_id BIGINT,
    category_id BIGINT,
    FOREIGN KEY (item_id) REFERENCES menu_items(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES menu_categories(id) ON DELETE CASCADE
);

-- Menu price history
CREATE TABLE menu_price_history (
    id BIGSERIAL PRIMARY KEY,
    item_id BIGINT,
    old_price DECIMAL(12,2),
    new_price DECIMAL(12,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    changed_by BIGINT,
    FOREIGN KEY (item_id) REFERENCES menu_items(id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by) REFERENCES admins(id) ON DELETE SET NULL
);

-- Carts
CREATE TABLE carts (
    id BIGSERIAL PRIMARY KEY,
    qr_session_id BIGINT,
    status cart_status DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (qr_session_id) REFERENCES qr_sessions(id) ON DELETE CASCADE
);

-- Cart items
CREATE TABLE cart_items (
    id BIGSERIAL PRIMARY KEY,
    cart_id BIGINT NOT NULL,
    menu_item_id BIGINT NOT NULL,
    quantity INT DEFAULT 1,
    note TEXT,
    unit_price DECIMAL(12,2),
    status cart_item_status DEFAULT 'IN_CART',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE
);

-- Orders
CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    qr_session_id BIGINT NOT NULL,
    admin_id BIGINT,
    total_price DECIMAL(12,2) DEFAULT 0,
    status order_status DEFAULT 'NEW',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (qr_session_id) REFERENCES qr_sessions(id) ON DELETE CASCADE,
    FOREIGN KEY (admin_id) REFERENCES admins(id) ON DELETE SET NULL
);

-- Order items
CREATE TABLE order_items (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT NOT NULL,
    cart_item_id BIGINT,
    menu_item_id BIGINT,
    quantity INT DEFAULT 1,
    note TEXT,
    unit_price DECIMAL(12,2),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE,
    FOREIGN KEY (cart_item_id) REFERENCES cart_items(id) ON DELETE SET NULL
);

-- Payments
CREATE TABLE payments (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT,
    admin_id BIGINT,
    method payment_method NOT NULL,
    amount DECIMAL(12,2),
    payment_status payment_status,
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    printed_bill BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (admin_id) REFERENCES admins(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- Reward points
CREATE TABLE reward_points (
    id BIGSERIAL PRIMARY KEY,
    customer_id BIGINT,
    points INT DEFAULT 0,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Reviews
CREATE TABLE reviews (
    id BIGSERIAL PRIMARY KEY,
    qr_session_id BIGINT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (qr_session_id) REFERENCES qr_sessions(id) ON DELETE CASCADE
);

-- Menu reviews
CREATE TABLE menu_reviews (
    id BIGSERIAL PRIMARY KEY,
    item_id BIGINT,
    qr_session_id BIGINT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES menu_items(id) ON DELETE CASCADE,
    FOREIGN KEY (qr_session_id) REFERENCES qr_sessions(id) ON DELETE CASCADE
);

-- Chats
CREATE TABLE chats (
    id BIGSERIAL PRIMARY KEY,
    qr_session_id BIGINT,
    sender chat_sender,
    message TEXT,
    intent VARCHAR(100),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (qr_session_id) REFERENCES qr_sessions(id) ON DELETE CASCADE
);

-- Notifications
CREATE TABLE notifications (
    id BIGSERIAL PRIMARY KEY,
    target_type notification_target_type NOT NULL,
    target_id BIGINT,
    title VARCHAR(255) NOT NULL,
    message TEXT,
    type notification_type DEFAULT 'SYSTEM',
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    priority notification_priority DEFAULT 'medium',
    action_url VARCHAR(500),
    metadata JSONB
);

CREATE INDEX idx_target ON notifications (target_type, target_id);
CREATE INDEX idx_created_at ON notifications (created_at);
CREATE INDEX idx_is_read ON notifications (is_read);
CREATE INDEX idx_type ON notifications (type);
CREATE INDEX idx_priority ON notifications (priority);
