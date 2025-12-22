-- Demo data for PostgreSQL
-- Requires schema created by SQL_CreateTable.sql

-- Employees
INSERT INTO employees (id, name, phone, email, gender, address, created_at)
VALUES (1,'Huy','0913227645','tdhuy141vt@gmail.com','MALE','Phu Tho','2025-11-04 09:35:34');

-- Admins
INSERT INTO admins (id, employee_id, username, password, role, is_active, created_at)
VALUES (2,1,'admin','$2b$10$kJoZV0/utudKs0m/NcyTOeMNmwd16y9O9LdV2zkwyZK2AhhqZ7fWy','STAFF', TRUE,'2025-10-04 09:35:44');

-- Menu categories
INSERT INTO menu_categories (id, name, description, is_available) VALUES
(1,'Món đặc trưng','Các món đặc sản nổi bật, mang hương vị đặc trưng của nhà hàng.', TRUE),
(2,'Set menu','Thực đơn trọn gói, kết hợp nhiều món ăn hài hòa cho bữa ăn đầy đủ.', TRUE),
(3,'Cuốn Phương Nam','Các món cuốn đặc trưng Nam Bộ, tươi ngon, dễ ăn.', TRUE),
(4,'Nộm thanh mát','Các món nộm, gỏi với hương vị thanh mát, kích thích vị giác.', TRUE),
(5,'Món ăn chơi','Các món ăn nhẹ, dễ thưởng thức khi trò chuyện hoặc khai vị.', TRUE),
(6,'Món rau xanh','Các món rau tươi, chế biến đa dạng, tốt cho sức khỏe.', TRUE),
(7,'Món ngon vườn nhà','Các món dân dã, gần gũi, mang hương vị vườn nhà.', TRUE),
(8,'Món ngon đồng quê','Món ăn đặc trưng từ nguyên liệu vùng đồng quê.', TRUE),
(9,'Món ngon sông nước','Món ăn chế biến từ thủy sản, mang hương vị miền sông nước.', TRUE),
(10,'Lẩu lá giang tươi','Món lẩu chua thanh, nấu cùng lá giang tươi đặc trưng.', TRUE),
(11,'Bánh tráng Trảng Bàng','Đặc sản Trảng Bàng với bánh tráng phơi sương, ăn kèm rau và thịt.', TRUE),
(12,'Cơm nhà Phương Nam','Các món cơm gia đình đậm đà hương vị miền Nam.', TRUE),
(13,'Cơm chiên, mì, cháo','Các món cơm chiên, mì và cháo đa dạng, hợp khẩu vị nhiều thực khách.', TRUE);

-- Menu items
INSERT INTO menu_items (id, name, price, description, image_url, is_available) VALUES
(1,'Cá kèo muối ớt',128000.00,'Món cá kèo muối ớt là món ngon đặc trưng của sông nước, được chế biến từ cá kèo tươi sống. Cá được ướp với muối và ớt tạo nên hương vị đậm đà, cay nồng. Đây là món ăn hấp dẫn và thường được phục vụ trong các bữa tiệc hoặc cùng gia đình bạn bè.','https://product.hstatic.net/1000093072/product/ca_keo_nuong_muoi_ot_dd2660b8e14d4456b3ad5469746ce601_master.jpg', TRUE),
(2,'Cá đặc sản Phương Nam muối ớt',58000.00,'Cá thòi lòi Cà Mau (phục vụ tối thiểu từ 4 con), loài cá độc lạ nhất.','https://product.hstatic.net/1000093072/product/ca_keo_nuong_muoi_ot_dd2660b8e14d4456b3ad5469746ce601_master.jpg', TRUE),
(3,'Bánh tráng phơi sương cuốn ba chỉ quay (chính hiệu)',158000.00,'Bánh tráng phơi sương Trảng Bàng, thịt ba chỉ quay, rau rừng.','https://product.hstatic.net/1000093072/product/ca_keo_nuong_muoi_ot_dd2660b8e14d4456b3ad5469746ce601_master.jpg', TRUE),
(4,'Nộm củ hủ dừa tôm thịt',138000.00,'Củ hủ dừa, tôm, thịt ba chỉ quay, rau gia vị, nước sốt đặc biệt.','https://product.hstatic.net/1000093072/product/ca_keo_nuong_muoi_ot_dd2660b8e14d4456b3ad5469746ce601_master.jpg', TRUE),
(5,'Lẩu kèo đệ nhất Phương Nam 16 con',498000.00,'Cá kèo đồng bơi 16 con, nước dùng kèm rau, quả, gia vị.','https://product.hstatic.net/1000093072/product/ca_keo_nuong_muoi_ot_dd2660b8e14d4456b3ad5469746ce601_master.jpg', TRUE),
(6,'Bánh xèo cuốn lá cải nhân tép đồng bông điên điển',138000.00,'Bột bánh xèo, nước cốt dừa, trứng gà, tép đồng, bông điên điển, giá.','https://product.hstatic.net/1000093072/product/ca_keo_nuong_muoi_ot_dd2660b8e14d4456b3ad5469746ce601_master.jpg', TRUE),
(7,'Cá lóc hấp bầu',448000.00,'Cá lóc hấp bầu – món ăn lạ miệng, xuất xứ từ miền sông nước.','https://product.hstatic.net/1000093072/product/ca_keo_nuong_muoi_ot_dd2660b8e14d4456b3ad5469746ce601_master.jpg', TRUE),
(8,'Bánh tráng phơi sương cuốn cá lóc nướng (chính hiệu)',448000.00,'Cá lóc 1000–1200gr, bánh tráng 10 lá, rau rừng các loại.','https://product.hstatic.net/1000093072/product/ca_keo_nuong_muoi_ot_dd2660b8e14d4456b3ad5469746ce601_master.jpg', TRUE),
(9,'Bánh tráng Trảng Bàng phơi sương cuốn bò tơ (chính hiệu)',158000.00,'Bò tơ, bánh tráng Trảng Bàng, rau rừng, mắm nêm.','https://product.hstatic.net/1000093072/product/ca_keo_nuong_muoi_ot_dd2660b8e14d4456b3ad5469746ce601_master.jpg', TRUE),
(10,'Lẩu bò lá giang',398000.00,'Thịt bò 0.4kg (bò bắp), lá giang, rau ngò, mùi tàu và các gia vị khác.','https://product.hstatic.net/1000093072/product/ca_keo_nuong_muoi_ot_dd2660b8e14d4456b3ad5469746ce601_master.jpg', TRUE),
(11,'Lẩu gà lá giang (L)',498000.00,'Gà ta ngấm gia vị, nước lẩu chua thanh từ lá giang miền Nam.','https://product.hstatic.net/1000093072/product/ca_keo_nuong_muoi_ot_dd2660b8e14d4456b3ad5469746ce601_master.jpg', TRUE),
(12,'Lẩu gà lá giang (N)',398000.00,'Gà ta ngấm gia vị, nước lẩu chua thanh từ lá giang miền Nam.','https://product.hstatic.net/1000093072/product/ca_keo_nuong_muoi_ot_dd2660b8e14d4456b3ad5469746ce601_master.jpg', TRUE);

-- Menu item categories
INSERT INTO menu_item_categories (id, item_id, category_id) VALUES
(1,1,1),(2,1,9),(3,2,1),(4,2,9),(5,3,1),(6,3,3),(7,3,11),(8,4,1),(9,4,4),(10,5,1),(11,5,10),(12,6,1),(13,6,3),(14,7,1),(15,7,9),(16,8,1),(17,8,3),(18,8,11),(19,9,1),(20,9,3),(21,9,11),(22,10,1),(23,10,10),(24,11,1),(25,11,10),(26,12,1),(27,12,10);

-- Tables
INSERT INTO tables (id, table_number, qr_code_url, is_active) VALUES
(5,'T5','/qr/table-5.png', TRUE),
(6,'T6','/qr/table-6.png', TRUE),
(11,'T11','/qr/table-11.png', TRUE);

-- QR sessions (must exist before reviews/orders)
INSERT INTO qr_sessions (id, table_id, customer_id, status, created_at) VALUES
(18,5,NULL,'ACTIVE','2025-10-04 07:34:37'),
(19,6,NULL,'ACTIVE','2025-10-05 14:26:21'),
(21,11,NULL,'ACTIVE','2025-10-16 16:16:15');

-- Orders
INSERT INTO orders (id, qr_session_id, admin_id, total_price, status, created_at, updated_at) VALUES
(10,18,NULL,0.00,'PAID','2025-10-05 02:18:38','2025-10-05 03:23:08'),
(11,18,NULL,0.00,'CANCELLED','2025-10-05 03:23:59','2025-10-20 17:40:17'),
(13,21,NULL,326000.00,'NEW','2025-10-16 16:16:31','2025-10-22 17:11:46');

-- Order items
INSERT INTO order_items (id, order_id, cart_item_id, menu_item_id, quantity, note, unit_price) VALUES
(3,10,NULL,4,1,NULL,138000.00),
(4,10,NULL,5,1,NULL,498000.00),
(5,10,NULL,3,1,NULL,158000.00),
(6,10,NULL,1,1,NULL,128000.00),
(7,10,NULL,12,1,NULL,398000.00),
(8,10,NULL,12,1,NULL,398000.00),
(9,11,NULL,3,1,NULL,158000.00),
(14,11,NULL,1,1,NULL,128000.00),
(15,11,NULL,2,1,NULL,58000.00),
(16,11,NULL,1,1,NULL,128000.00),
(17,11,NULL,2,1,NULL,58000.00),
(18,11,NULL,3,1,NULL,158000.00),
(19,13,NULL,1,5,NULL,128000.00);

-- Payments
INSERT INTO payments (id, order_id, admin_id, method, amount, payment_status, paid_at, printed_bill) VALUES
(1,11,NULL,'BANKING',0.00,'PENDING','2025-10-15 15:33:58', FALSE);

-- Menu reviews (requires qr_sessions + menu_items)
INSERT INTO menu_reviews (id, item_id, qr_session_id, rating, comment, created_at) VALUES
(1,1,18,4,'kha ngon','2025-10-05 07:01:10'),
(2,2,18,5,'ok la','2025-10-05 07:01:10');

-- Notifications
INSERT INTO notifications (id, target_type, target_id, title, message, type, is_read, created_at, priority, action_url, metadata) VALUES
(1,'STAFF',NULL,'Bàn T5 - Thêm món vào đơn #11','Khách hàng vừa thêm 1 món: 1x món (giá: 128000.00đ)','ORDER_UPDATE', TRUE,'2025-10-15 15:33:35','medium','/management/orders/11','{"orderId": 11, "tableId": 5, "tableName": "T5", "isNewOrder": false, "totalItems": 1, "qrSessionId": 18}'::jsonb),
(2,'STAFF',NULL,'Bàn T5 đang gọi nhân viên','Khách hàng ở bàn T5 cần hỗ trợ','CALL_STAFF', TRUE,'2025-10-15 16:23:11','high','/management/tables/5','{"tableId": 5, "tableName": "T5", "qrSessionId": 18}'::jsonb),
(3,'STAFF',NULL,'Bàn T5 - Thêm món vào đơn #11','Khách hàng vừa thêm 2 món: 1x món (giá: 58000.00đ), 1x món (giá: 128000.00đ)','ORDER_UPDATE', TRUE,'2025-10-16 16:10:09','medium','/management/orders/11','{"orderId": 11, "tableId": 5, "tableName": "T5", "isNewOrder": false, "totalItems": 2, "qrSessionId": 18}'::jsonb),
(4,'STAFF',NULL,'Bàn T5 - Thêm món vào đơn #11','Khách hàng vừa thêm 2 món: 1x món (giá: 58000.00đ), 1x món (giá: 158000.00đ)','ORDER_UPDATE', TRUE,'2025-10-16 16:14:53','medium','/management/orders/11','{"orderId": 11, "tableId": 5, "tableName": "T5", "isNewOrder": false, "totalItems": 2, "qrSessionId": 18}'::jsonb),
(5,'STAFF',NULL,'Bàn T11 đang gọi nhân viên','Khách hàng ở bàn T11 cần hỗ trợ','CALL_STAFF', TRUE,'2025-10-16 16:17:30','high','/management/tables/11','{"tableId": 11, "tableName": "T11", "qrSessionId": 21}'::jsonb),
(6,'STAFF',NULL,'Bàn T11 - Thêm món vào đơn #13','Khách hàng vừa thêm 1 món: 1x món (giá: 128000.00đ)','ORDER_UPDATE', TRUE,'2025-10-16 16:18:02','medium','/management/orders/13','{"orderId": 13, "tableId": 11, "tableName": "T11", "isNewOrder": false, "totalItems": 1, "qrSessionId": 21}'::jsonb),
(7,'STAFF',NULL,'✏️ Bàn T6 - Cập nhật đơn #12','Khách hàng đã cập nhật số lượng món (số lượng: 3 → 1)','ORDER_UPDATE', TRUE,'2025-10-20 15:01:07','low','/management/orders/12','{"orderId": "12", "tableId": 6, "tableName": "T6", "newQuantity": 1, "oldQuantity": 3, "qrSessionId": 19, "updatedItemId": "10"}'::jsonb),
(8,'STAFF',NULL,'✏️ Bàn T6 - Cập nhật đơn #12','Khách hàng đã cập nhật số lượng món (số lượng: 1 → 2)','ORDER_UPDATE', TRUE,'2025-10-20 15:01:29','low','/management/orders/12','{"orderId": "12", "tableId": 6, "tableName": "T6", "newQuantity": 2, "oldQuantity": 1, "qrSessionId": 19, "updatedItemId": "10"}'::jsonb),
(9,'STAFF',NULL,'❌ Bàn T6 - Xóa món khỏi đơn #12','Khách hàng đã xóa 1 món khỏi đơn hàng','ORDER_UPDATE', TRUE,'2025-10-20 17:34:31','low','/management/orders/12','{"orderId": "12", "tableId": 6, "tableName": "T6", "qrSessionId": 19, "removedItemId": "10", "remainingItems": 3}'::jsonb),
(10,'STAFF',NULL,'❌ Bàn T5 - Hủy đơn #11','Khách hàng đã hủy đơn hàng (Lý do: Hủy từ danh sách đơn hàng)','ORDER_UPDATE', TRUE,'2025-10-20 17:40:17','medium','/management/orders/11','{"orderId": "11", "tableId": 5, "tableName": "T5", "qrSessionId": 18, "cancelReason": "Hủy từ danh sách đơn hàng", "previousStatus": "NEW"}'::jsonb),
(11,'STAFF',NULL,'✏️ Bàn T6 - Cập nhật đơn #12','Khách hàng đã cập nhật số lượng món (số lượng: 2 → 3)','ORDER_UPDATE', TRUE,'2025-10-22 14:12:51','low','/management/orders/12','{"orderId": "12", "tableId": 6, "tableName": "T6", "newQuantity": 3, "oldQuantity": 2, "qrSessionId": 19, "updatedItemId": "13"}'::jsonb),
(12,'STAFF',NULL,'✏️ Bàn T6 - Cập nhật đơn #12','Khách hàng đã cập nhật số lượng món (số lượng: 3 → 2)','ORDER_UPDATE', TRUE,'2025-10-22 14:13:05','low','/management/orders/12','{"orderId": "12", "tableId": 6, "tableName": "T6", "newQuantity": 2, "oldQuantity": 3, "qrSessionId": 19, "updatedItemId": "13"}'::jsonb),
(13,'STAFF',NULL,'✏️ Bàn T6 - Cập nhật đơn #12','Khách hàng đã cập nhật số lượng món (số lượng: 2 → 1)','ORDER_UPDATE', TRUE,'2025-10-22 14:13:19','low','/management/orders/12','{"orderId": "12", "tableId": 6, "tableName": "T6", "newQuantity": 1, "oldQuantity": 2, "qrSessionId": 19, "updatedItemId": "13"}'::jsonb),
(14,'STAFF',NULL,'❌ Bàn T6 - Xóa món khỏi đơn #12','Khách hàng đã xóa 1 món khỏi đơn hàng','ORDER_UPDATE', TRUE,'2025-10-22 14:43:39','low','/management/orders/12','{"orderId": "12", "tableId": 6, "tableName": "T6", "qrSessionId": 19, "removedItemId": "11", "remainingItems": 2}'::jsonb),
(15,'STAFF',NULL,'❌ Bàn T11 - Xóa món khỏi đơn #13','Khách hàng đã xóa 1 món khỏi đơn hàng','ORDER_UPDATE', TRUE,'2025-10-22 16:31:34','low','/management/orders/13','{"orderId": "13", "tableId": 11, "tableName": "T11", "qrSessionId": 21, "removedItemId": "21", "remainingItems": 2}'::jsonb),
(16,'STAFF',NULL,'✏️ Bàn T11 - Cập nhật đơn #13','Khách hàng đã cập nhật số lượng món (số lượng: 1 → 2)','ORDER_UPDATE', TRUE,'2025-10-22 16:33:23','low','/management/orders/13','{"orderId": "13", "tableId": 11, "tableName": "T11", "newQuantity": 2, "oldQuantity": 1, "qrSessionId": 21, "updatedItemId": "20"}'::jsonb),
(17,'STAFF',NULL,'✏️ Bàn T11 - Cập nhật đơn #13','Khách hàng đã cập nhật số lượng món (số lượng: 1 → 2)','ORDER_UPDATE', TRUE,'2025-10-22 16:37:33','low','/management/orders/13','{"orderId": "13", "tableId": 11, "tableName": "T11", "newQuantity": 2, "oldQuantity": 1, "qrSessionId": 21, "updatedItemId": "19"}'::jsonb),
(18,'STAFF',NULL,'❌ Bàn T6 - Xóa món khỏi đơn #12','Khách hàng đã xóa 1 món khỏi đơn hàng','ORDER_UPDATE', TRUE,'2025-10-22 16:38:15','low','/management/orders/12','{"orderId": "12", "tableId": 6, "tableName": "T6", "qrSessionId": 19, "removedItemId": "13", "remainingItems": 1}'::jsonb),
(19,'STAFF',NULL,'❌ Bàn T11 - Xóa món khỏi đơn #13','Khách hàng đã xóa 1 món khỏi đơn hàng','ORDER_UPDATE', TRUE,'2025-10-22 16:38:34','low','/management/orders/13','{"orderId": "13", "tableId": 11, "tableName": "T11", "qrSessionId": 21, "removedItemId": "20", "remainingItems": 1}'::jsonb),
(20,'STAFF',NULL,'✏️ Bàn T11 - Cập nhật đơn #13','Khách hàng đã cập nhật số lượng món (số lượng: 2 → 3)','ORDER_UPDATE', TRUE,'2025-10-22 16:50:06','low','/management/orders/13','{"orderId": "13", "tableId": 11, "tableName": "T11", "newQuantity": 3, "oldQuantity": 2, "qrSessionId": 21, "updatedItemId": "19"}'::jsonb),
(21,'STAFF',NULL,'✏️ Bàn T11 - Cập nhật đơn #13','Khách hàng đã cập nhật số lượng món (số lượng: 3 → 4)','ORDER_UPDATE', TRUE,'2025-10-22 16:52:00','low','/management/orders/13','{"orderId": "13", "tableId": 11, "tableName": "T11", "newQuantity": 4, "oldQuantity": 3, "qrSessionId": 21, "updatedItemId": "19"}'::jsonb),
(22,'STAFF',NULL,'➕ [ADMIN] Bàn T6 - Thêm món #15','Admin đã tạo đơn với 1 món: 1x món (giá: 58000.00đ)','ORDER_UPDATE', FALSE,'2025-10-22 17:24:20','high','/management/orders/15','{"adminId": null, "orderId": 15, "tableId": 6, "tableName": "T6", "totalItems": 1, "qrSessionId": 19, "createdByAdmin": true}'::jsonb),
(23,'STAFF',NULL,'➕ [ADMIN] Bàn T6 - Thêm món #15','Admin đã tạo đơn với 1 món: 1x món (giá: 158000.00đ)','ORDER_UPDATE', FALSE,'2025-10-22 17:24:33','high','/management/orders/15','{"adminId": null, "orderId": 15, "tableId": 6, "tableName": "T6", "totalItems": 1, "qrSessionId": 19, "createdByAdmin": true}'::jsonb),
(24,'STAFF',NULL,'➕ [ADMIN] Bàn T6 - Thêm món #15','Admin đã tạo đơn với 1 món: 1x món (giá: 498000.00đ)','ORDER_UPDATE', FALSE,'2025-10-22 17:24:42','high','/management/orders/15','{"adminId": null, "orderId": 15, "tableId": 6, "tableName": "T6", "totalItems": 1, "qrSessionId": 19, "createdByAdmin": true}'::jsonb),
(25,'STAFF',NULL,'❌ Bàn T6 - Xóa món khỏi đơn #15','Khách hàng đã xóa 1 món khỏi đơn hàng','ORDER_UPDATE', FALSE,'2025-10-22 17:27:00','low','/management/orders/15','{"orderId": "15", "tableId": 6, "tableName": "T6", "qrSessionId": 19, "removedItemId": "26", "remainingItems": 3}'::jsonb),
(26,'STAFF',NULL,'➕ [ADMIN] Bàn T6 - Thêm món #15','Admin đã tạo đơn với 1 món: 1x món (giá: 498000.00đ)','ORDER_UPDATE', FALSE,'2025-10-22 17:31:20','high','/management/orders/15','{"adminId": null, "orderId": 15, "tableId": 6, "tableName": "T6", "totalItems": 1, "qrSessionId": 19, "createdByAdmin": true}'::jsonb),
(27,'STAFF',NULL,'➕ [ADMIN] Bàn T6 - Thêm món #15','Admin đã tạo đơn với 1 món: 1x món (giá: 158000.00đ)','ORDER_UPDATE', FALSE,'2025-10-22 17:34:46','high','/management/orders/15','{"adminId": null, "orderId": 15, "tableId": 6, "tableName": "T6", "totalItems": 1, "qrSessionId": 19, "createdByAdmin": true}'::jsonb),
(28,'STAFF',NULL,'➕ [ADMIN] Bàn T6 - Thêm món #15','Admin đã tạo đơn với 1 món: 1x món (giá: 138000.00đ)','ORDER_UPDATE', FALSE,'2025-10-22 18:14:40','high','/management/orders/15','{"adminId": null, "orderId": 15, "tableId": 6, "tableName": "T6", "totalItems": 1, "qrSessionId": 19, "createdByAdmin": true}'::jsonb),
(29,'STAFF',NULL,'➕ [ADMIN] Bàn T6 - Thêm món #15','Admin đã tạo đơn với 1 món: 1x món (giá: 138000.00đ)','ORDER_UPDATE', FALSE,'2025-10-22 18:14:53','high','/management/orders/15','{"adminId": null, "orderId": 15, "tableId": 6, "tableName": "T6", "totalItems": 1, "qrSessionId": 19, "createdByAdmin": true}'::jsonb),
(30,'STAFF',NULL,'➕ [ADMIN] Bàn T6 - Thêm món #15','Admin đã tạo đơn với 1 món: 1x món (giá: 128000.00đ)','ORDER_UPDATE', FALSE,'2025-10-22 18:15:02','high','/management/orders/15','{"adminId": null, "orderId": 15, "tableId": 6, "tableName": "T6", "totalItems": 1, "qrSessionId": 19, "createdByAdmin": true}'::jsonb),
(31,'STAFF',NULL,'➕ [ADMIN] Bàn T6 - Thêm món #15','Admin đã tạo đơn với 1 món: 1x món (giá: 128000.00đ)','ORDER_UPDATE', FALSE,'2025-10-22 18:17:11','high','/management/orders/15','{"adminId": null, "orderId": 15, "tableId": 6, "tableName": "T6", "totalItems": 1, "qrSessionId": 19, "createdByAdmin": true}'::jsonb),
(32,'STAFF',NULL,'➕ [ADMIN] Bàn T6 - Thêm món #15','Admin đã tạo đơn với 1 món: 1x món (giá: 58000.00đ)','ORDER_UPDATE', FALSE,'2025-10-22 18:17:13','high','/management/orders/15','{"adminId": null, "orderId": 15, "tableId": 6, "tableName": "T6", "totalItems": 1, "qrSessionId": 19, "createdByAdmin": true}'::jsonb);


-- Reset sequences after explicit inserts
SELECT setval(pg_get_serial_sequence('employees','id'), (SELECT MAX(id) FROM employees));
SELECT setval(pg_get_serial_sequence('admins','id'), (SELECT MAX(id) FROM admins));
SELECT setval(pg_get_serial_sequence('menu_categories','id'), (SELECT MAX(id) FROM menu_categories));
SELECT setval(pg_get_serial_sequence('menu_items','id'), (SELECT MAX(id) FROM menu_items));
SELECT setval(pg_get_serial_sequence('menu_item_categories','id'), (SELECT MAX(id) FROM menu_item_categories));
SELECT setval(pg_get_serial_sequence('menu_reviews','id'), (SELECT MAX(id) FROM menu_reviews));
SELECT setval(pg_get_serial_sequence('notifications','id'), (SELECT MAX(id) FROM notifications));
SELECT setval(pg_get_serial_sequence('order_items','id'), (SELECT MAX(id) FROM order_items));
SELECT setval(pg_get_serial_sequence('orders','id'), (SELECT MAX(id) FROM orders));
SELECT setval(pg_get_serial_sequence('payments','id'), (SELECT MAX(id) FROM payments));
SELECT setval(pg_get_serial_sequence('qr_sessions','id'), (SELECT MAX(id) FROM qr_sessions));
SELECT setval(pg_get_serial_sequence('tables','id'), (SELECT MAX(id) FROM tables));
