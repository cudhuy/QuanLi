-- Seed data (PostgreSQL)

-- Customers
INSERT INTO customers (id, name, phone, points)
VALUES (1, 'Khach demo', '0900000000', 0);

-- Menu categories
INSERT INTO menu_categories (id, name, description, is_available) VALUES
(1,'M?n ??c tr?ng','C?c m?n ??c s?n n?i b?t, mang h??ng v? ??c tr?ng c?a nh? h?ng.', TRUE),
(2,'Set menu','Th?c ??n tr?n g?i, k?t h?p nhi?u m?n ?n h?i h?a cho b?a ?n ??y ??.', TRUE),
(3,'Cu?n Ph??ng Nam','C?c m?n cu?n ??c tr?ng Nam B?, t??i ngon, d? ?n.', TRUE),
(4,'N?m thanh m?t','C?c m?n n?m, g?i v?i h??ng v? thanh m?t, k?ch th?ch v? gi?c.', TRUE),
(5,'M?n ?n ch?i','C?c m?n ?n nh?, d? th??ng th?c khi tr? chuy?n ho?c khai v?.', TRUE),
(6,'M?n rau xanh','C?c m?n rau t??i, ch? bi?n ?a d?ng, t?t cho s?c kh?e.', TRUE),
(7,'M?n ngon v??n nh?','C?c m?n d?n d?, g?n g?i, mang h??ng v? v??n nh?.', TRUE),
(8,'M?n ngon ??ng qu?','M?n ?n ??c tr?ng t? nguy?n li?u v?ng ??ng qu?.', TRUE),
(9,'M?n ngon s?ng n??c','M?n ?n ch? bi?n t? th?y s?n, mang h??ng v? mi?n s?ng n??c.', TRUE),
(10,'L?u l? giang t??i','M?n l?u chua thanh, n?u c?ng l? giang t??i ??c tr?ng.', TRUE),
(11,'B?nh tr?ng Tr?ng B?ng','??c s?n Tr?ng B?ng v?i b?nh tr?ng ph?i s??ng, ?n k?m rau v? th?t.', TRUE),
(12,'C?m nh? Ph??ng Nam','C?c m?n c?m gia ??nh ??m ?? h??ng v? mi?n Nam.', TRUE),
(13,'C?m chi?n, m?, ch?o','C?c m?n c?m chi?n, m? v? ch?o ?a d?ng, h?p kh?u v? nhi?u th?c kh?ch.', TRUE);

-- Menu items
INSERT INTO menu_items (id, name, price, description, image_url, is_available) VALUES
(1,'C? k?o mu?i ?t', 128000, 'M?n c? k?o mu?i ?t l? m?n ngon s?ng n??c, m?n ??c s?n, m?n ??c tr?ng.', NULL, TRUE),
(2,'C? ??c s?n Ph??ng Nam mu?i ?t', 58000, 'C? th?i l?i C? Mau (ph?c v? t?i thi?u t? 4 con), lo?i c? ??c l? nh?t.', NULL, TRUE),
(3,'B?nh tr?ng ph?i s??ng cu?n ba ch? quay (ch?nh hi?u)', 158000, 'B?nh tr?ng ph?i s??ng Tr?ng B?ng, th?t ba ch? quay, rau r?ng.', NULL, TRUE),
(4,'N?m c? h? d?a t?m th?t', 138000, 'C? h? d?a, t?m, th?t ba ch? quay, rau gia v?, n??c s?t ??c bi?t.', NULL, TRUE),
(5,'L?u k?o ??c bi?t Ph??ng Nam 16 con', 498000, 'C? k?o ??ng b? 16 con, n??c d?ng k?m rau, qu?, gia v?.', NULL, TRUE),
(6,'B?nh x?o cu?n l? c?i nh?n t?m ??ng b?ng ?i?n ?i?n', 138000, 'B?t b?nh x?o, n??c c?t d?a, tr?ng g?, t?m ??ng, b?ng ?i?n ?i?n, gi?.', NULL, TRUE),
(7,'C? l?c h?p b?u', 448000, 'C? l?c h?p b?u m?n ?n l? mi?ng, xu?t x? t? mi?n s?ng n??c.', NULL, TRUE),
(8,'B?nh tr?ng ph?i s??ng cu?n c? l?c n??ng (ch?nh hi?u)', 448000, 'C? l?c 1000-1200gr, b?nh tr?ng 10 l?, rau r?ng c?c lo?i.', NULL, TRUE),
(9,'B?nh tr?ng Tr?ng B?ng ph?i s??ng cu?n b?p b? (ch?nh hi?u)', 158000, 'B?p b?, b?nh tr?ng Tr?ng B?ng, rau r?ng, m?m n?m.', NULL, TRUE),
(10,'L?u b? l? giang', 398000, 'Th?t b? 0.4kg (b? b?p), l? giang, rau ng?, m?ng t?y v? c?c gia v? kh?c.', NULL, TRUE),
(11,'L?u g? l? giang (L)', 498000, 'G? ta ng?m gia v?, n??c l?u chua thanh t? l? giang mi?n Nam.', NULL, TRUE),
(12,'L?u g? l? giang (N)', 398000, 'G? ta ng?m gia v?, n??c l?u chua thanh t? l? giang mi?n Nam.', NULL, TRUE);

-- Menu item categories
INSERT INTO menu_item_categories (item_id, category_id) VALUES
(1, 1), (1, 9),
(2, 1), (2, 9),
(3, 1), (3, 3), (3, 11),
(4, 1), (4, 4),
(5, 1), (5, 10),
(6, 1), (6, 3),
(7, 1), (7, 9),
(8, 1), (8, 3), (8, 11),
(9, 1), (9, 3), (9, 11),
(10, 1), (10, 10),
(11, 1), (11, 10),
(12, 1), (12, 10);

-- Tables
INSERT INTO tables (id, table_number, qr_code_url, is_active) VALUES
(1,'T1', NULL, TRUE),
(2,'T2', NULL, TRUE),
(3,'T3', NULL, TRUE),
(4,'T4', NULL, TRUE),
(5,'T5', NULL, TRUE),
(6,'T6', NULL, TRUE),
(7,'T7', NULL, TRUE),
(8,'T8', NULL, TRUE),
(9,'T9', NULL, TRUE),
(10,'T10', NULL, TRUE);

-- QR sessions
INSERT INTO qr_sessions (id, table_id, customer_id, status) VALUES
(1, 1, 1, 'ACTIVE'),
(2, 2, NULL, 'COMPLETED'),
(3, 3, NULL, 'ACTIVE');

-- Carts
INSERT INTO carts (id, qr_session_id, status) VALUES
(1, 1, 'ACTIVE');

-- Cart items
INSERT INTO cart_items (id, cart_id, menu_item_id, quantity, note, unit_price) VALUES
(1, 1, 1, 2, '?t cay', 128000),
(2, 1, 2, 1, NULL, 58000);

-- Orders
INSERT INTO orders (id, qr_session_id, status) VALUES
(1, 1, 'NEW');

-- Order items
INSERT INTO order_items (id, order_id, menu_item_id, quantity, unit_price, note) VALUES
(1, 1, 1, 2, 128000, '?t cay'),
(2, 1, 2, 1, 58000, NULL);

-- Payments
INSERT INTO payments (id, order_id, method, payment_status, printed_bill) VALUES
(1, 1, 'CASH', 'PAID', TRUE);

-- Reset sequences after explicit inserts
SELECT setval(pg_get_serial_sequence('customers','id'), (SELECT MAX(id) FROM customers));
SELECT setval(pg_get_serial_sequence('menu_categories','id'), (SELECT MAX(id) FROM menu_categories));
SELECT setval(pg_get_serial_sequence('menu_items','id'), (SELECT MAX(id) FROM menu_items));
SELECT setval(pg_get_serial_sequence('tables','id'), (SELECT MAX(id) FROM tables));
SELECT setval(pg_get_serial_sequence('qr_sessions','id'), (SELECT MAX(id) FROM qr_sessions));
SELECT setval(pg_get_serial_sequence('carts','id'), (SELECT MAX(id) FROM carts));
SELECT setval(pg_get_serial_sequence('cart_items','id'), (SELECT MAX(id) FROM cart_items));
SELECT setval(pg_get_serial_sequence('orders','id'), (SELECT MAX(id) FROM orders));
SELECT setval(pg_get_serial_sequence('order_items','id'), (SELECT MAX(id) FROM order_items));
SELECT setval(pg_get_serial_sequence('payments','id'), (SELECT MAX(id) FROM payments));
