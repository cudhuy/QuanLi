-- This script creates triggers for PostgreSQL.
-- Run this after creating the tables and enhancements.

CREATE OR REPLACE FUNCTION trg_order_items_insert_func()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE orders
  SET total_price = (
    SELECT COALESCE(SUM(quantity * unit_price), 0)
    FROM order_items
    WHERE order_id = NEW.order_id
  )
  WHERE id = NEW.order_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_order_items_insert
AFTER INSERT ON order_items
FOR EACH ROW EXECUTE FUNCTION trg_order_items_insert_func();

CREATE OR REPLACE FUNCTION trg_order_items_update_func()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE orders
  SET total_price = (
    SELECT COALESCE(SUM(quantity * unit_price), 0)
    FROM order_items
    WHERE order_id = NEW.order_id
  )
  WHERE id = NEW.order_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_order_items_update
AFTER UPDATE ON order_items
FOR EACH ROW EXECUTE FUNCTION trg_order_items_update_func();

CREATE OR REPLACE FUNCTION trg_order_items_delete_func()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE orders
  SET total_price = (
    SELECT COALESCE(SUM(quantity * unit_price), 0)
    FROM order_items
    WHERE order_id = OLD.order_id
  )
  WHERE id = OLD.order_id;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_order_items_delete
AFTER DELETE ON order_items
FOR EACH ROW EXECUTE FUNCTION trg_order_items_delete_func();

CREATE OR REPLACE FUNCTION trg_complete_qr_session_func()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE qr_sessions
    SET status = 'COMPLETED'
    WHERE id = NEW.qr_session_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_complete_qr_session
AFTER INSERT ON payments
FOR EACH ROW EXECUTE FUNCTION trg_complete_qr_session_func();