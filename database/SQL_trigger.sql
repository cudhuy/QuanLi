-- PostgreSQL triggers

-- Update order total after changes in order_items
CREATE OR REPLACE FUNCTION trg_set_order_total()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE orders
  SET total_price = (
    SELECT COALESCE(SUM(quantity * unit_price), 0)
    FROM order_items
    WHERE order_id = COALESCE(NEW.order_id, OLD.order_id)
  )
  WHERE id = COALESCE(NEW.order_id, OLD.order_id);

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_order_items_insert ON order_items;
CREATE TRIGGER trg_order_items_insert
AFTER INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION trg_set_order_total();

DROP TRIGGER IF EXISTS trg_order_items_update ON order_items;
CREATE TRIGGER trg_order_items_update
AFTER UPDATE ON order_items
FOR EACH ROW
EXECUTE FUNCTION trg_set_order_total();

DROP TRIGGER IF EXISTS trg_order_items_delete ON order_items;
CREATE TRIGGER trg_order_items_delete
AFTER DELETE ON order_items
FOR EACH ROW
EXECUTE FUNCTION trg_set_order_total();

-- Complete QR session after payment is created and marked PAID
CREATE OR REPLACE FUNCTION trg_complete_qr_session()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.payment_status = 'PAID' THEN
    UPDATE qr_sessions
    SET status = 'COMPLETED'
    WHERE id = (
      SELECT qr_session_id FROM orders WHERE id = NEW.order_id
    );
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_complete_qr_session ON payments;
CREATE TRIGGER trg_complete_qr_session
AFTER INSERT ON payments
FOR EACH ROW
EXECUTE FUNCTION trg_complete_qr_session();

-- Generic updated_at trigger for tables that need auto-update
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_menu_items_updated_at ON menu_items;
CREATE TRIGGER trg_menu_items_updated_at
BEFORE UPDATE ON menu_items
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_orders_updated_at ON orders;
CREATE TRIGGER trg_orders_updated_at
BEFORE UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_employees_updated_at ON employees;
CREATE TRIGGER trg_employees_updated_at
BEFORE UPDATE ON employees
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_admins_updated_at ON admins;
CREATE TRIGGER trg_admins_updated_at
BEFORE UPDATE ON admins
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_reward_points_updated_at ON reward_points;
CREATE TRIGGER trg_reward_points_updated_at
BEFORE UPDATE ON reward_points
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();
