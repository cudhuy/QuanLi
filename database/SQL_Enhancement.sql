-- This script applies enhancements for PostgreSQL.
-- Run this after creating the base tables.

-- ================================
-- ENHANCEMENT FOR QR ORDERING SYSTEM
-- ================================

-- 1. Bổ sung parent-child relationship cho orders
ALTER TABLE orders ADD COLUMN parent_order_id BIGINT NULL;

CREATE TYPE order_type_enum AS ENUM ('MAIN', 'ADDITIONAL');

ALTER TABLE orders ADD COLUMN order_type order_type_enum DEFAULT 'MAIN';
ALTER TABLE orders ADD CONSTRAINT fk_parent_order FOREIGN KEY (parent_order_id) REFERENCES orders(id) ON DELETE CASCADE;

-- 2. Cập nhật order status để phù hợp yêu cầu
ALTER TABLE orders ALTER COLUMN status DROP DEFAULT;
ALTER TABLE orders ALTER COLUMN status TYPE TEXT USING (status::TEXT);
UPDATE orders SET status = 'PENDING' WHERE status = 'NEW';
DROP TYPE IF EXISTS order_status_enum;
CREATE TYPE order_status_enum AS ENUM ('PENDING', 'CONFIRMED', 'IN_PROGRESS', 'DONE', 'PAID', 'CANCELLED');
ALTER TABLE orders ALTER COLUMN status TYPE order_status_enum USING (status::order_status_enum);
ALTER TABLE orders ALTER COLUMN status SET DEFAULT 'PENDING';

-- 3. Thêm bảng call staff requests
CREATE TYPE call_request_type_enum AS ENUM ('HELP', 'PAYMENT', 'COMPLAINT', 'OTHER');
CREATE TYPE call_status_enum AS ENUM ('PENDING', 'RESPONDED', 'RESOLVED');

CREATE TABLE call_staff_requests (
    id BIGSERIAL PRIMARY KEY,
    qr_session_id BIGINT NOT NULL,
    request_type call_request_type_enum DEFAULT 'HELP',
    message TEXT,
    status call_status_enum DEFAULT 'PENDING',
    admin_id BIGINT,
    created_at TIMESTAMP DEFAULT NOW(),
    responded_at TIMESTAMP NULL,
    FOREIGN KEY (qr_session_id) REFERENCES qr_sessions(id) ON DELETE CASCADE,
    FOREIGN KEY (admin_id) REFERENCES admins(id) ON DELETE SET NULL
);

-- 4. Thêm audit trail cho order changes
CREATE TABLE order_audit (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT NOT NULL,
    old_status VARCHAR(50),
    new_status VARCHAR(50),
    changed_by BIGINT,
    change_reason TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by) REFERENCES admins(id) ON DELETE SET NULL
);

-- 5. Thêm real-time notifications
-- (Skipped creation of types and table as they already exist from CreateTable script)

-- 6. Index optimization cho performance
CREATE INDEX idx_orders_qr_session_status ON orders(qr_session_id, status);
CREATE INDEX idx_orders_parent ON orders(parent_order_id);
CREATE INDEX idx_qr_sessions_table_status ON qr_sessions(table_id, status);
CREATE INDEX idx_cart_items_cart_status ON cart_items(cart_id, status);

-- 7. Triggers để tự động cập nhật timestamps và audit
CREATE OR REPLACE FUNCTION order_status_audit_function()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO order_audit (order_id, old_status, new_status, changed_by, change_reason)
        VALUES (NEW.id, OLD.status::VARCHAR, NEW.status::VARCHAR, NEW.admin_id, 'Status updated');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER order_status_audit_trigger
AFTER UPDATE ON orders
FOR EACH ROW EXECUTE FUNCTION order_status_audit_function();

CREATE OR REPLACE FUNCTION notification_order_update_function()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO notifications (target_type, target_id, title, message, type)
        VALUES ('CUSTOMER', NEW.qr_session_id, 
                CONCAT('Đơn hàng #', NEW.id, ' đã được cập nhật'),
                CONCAT('Trạng thái: ', NEW.status::VARCHAR),
                'ORDER_UPDATE');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER notification_order_update_trigger
AFTER UPDATE ON orders
FOR EACH ROW EXECUTE FUNCTION notification_order_update_function();

-- Trigger auto-update updated_at on orders
CREATE OR REPLACE FUNCTION trg_orders_updated_at() RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at := NOW();
  RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER trg_orders_updated_at
BEFORE UPDATE ON orders
FOR EACH ROW EXECUTE FUNCTION trg_orders_updated_at();
