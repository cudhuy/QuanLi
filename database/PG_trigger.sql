-- PostgreSQL trigger conversion
-- Notes:
-- 1) PostgreSQL uses trigger functions (plpgsql) and CREATE TRIGGER ... EXECUTE FUNCTION.
-- 2) Any MySQL-specific DELIMITER directives were removed.

-- Trigger: trg_order_items_insert
CREATE OR REPLACE FUNCTION fn_trg_order_items_insert() RETURNS trigger AS $$
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

DROP TRIGGER IF EXISTS trg_order_items_insert ON order_items;
CREATE TRIGGER trg_order_items_insert
AFTER INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION fn_trg_order_items_insert();

-- Trigger: trg_order_items_update
CREATE OR REPLACE FUNCTION fn_trg_order_items_update() RETURNS trigger AS $$
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

DROP TRIGGER IF EXISTS trg_order_items_update ON order_items;
CREATE TRIGGER trg_order_items_update
AFTER UPDATE ON order_items
FOR EACH ROW
EXECUTE FUNCTION fn_trg_order_items_update();

-- Trigger: trg_order_items_delete
CREATE OR REPLACE FUNCTION fn_trg_order_items_delete() RETURNS trigger AS $$
BEGIN
UPDATE orders
  SET total_price = (
    SELECT COALESCE(SUM(quantity * unit_price), 0)
    FROM order_items
    WHERE order_id = OLD.order_id
  )
  WHERE id = OLD.order_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_order_items_delete ON order_items;
CREATE TRIGGER trg_order_items_delete
AFTER DELETE ON order_items
FOR EACH ROW
EXECUTE FUNCTION fn_trg_order_items_delete();

-- Trigger: trg_complete_qr_session
CREATE OR REPLACE FUNCTION fn_trg_complete_qr_session() RETURNS trigger AS $$
BEGIN
-- Cập nhật trạng thái session thành COMPLETED
    UPDATE qr_sessions
    SET status = 'COMPLETED'
    WHERE id = NEW.qr_session_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_complete_qr_session ON payments;
CREATE TRIGGER trg_complete_qr_session
AFTER INSERT ON payments
FOR EACH ROW
EXECUTE FUNCTION fn_trg_complete_qr_session();
