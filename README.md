# 🍽️ QR Restaurant Ordering System

Hệ thống gọi món & thanh toán nhà hàng bằng QR Code, hỗ trợ realtime, quản trị, báo cáo và chatbot.

## 📌 Công Nghệ Sử Dụng

### Frontend
- React 19 (Create React App)
- Ant Design, TailwindCSS
- Redux Toolkit, React-Redux
- React Router
- Axios
- Socket.IO Client
- Charts: @ant-design/plots, Recharts
- File / Excel utilities (xlsx)

### Backend
- Node.js (ESM)
- Express 5
- PostgreSQL (pg pool, *.sql scripts)
- Sequelize (dependency, pool-based queries)
- Socket.IO
- JWT, bcryptjs
- OpenAI Chatbot
- QRCode generation
- Jest, Supertest
- dotenv, cors

**Khác**
- Server mặc định: `http://localhost:8000`
- Entry: `server.js`
- Static QR images: `public/qr`

## ✨ Tính Năng

### Quản lý QR bàn
- Tạo QR từng bàn hoặc toàn bộ
- Validate, tải, xoá QR
- Tạo/đóng QR session khi khách quét

### Trải nghiệm khách
- Xem menu theo danh mục / tên / chi tiết
- Giỏ hàng, tạo đơn, xem hoá đơn
- Thanh toán
- Chatbot
- Đánh giá nhà hàng & món
- Loyalty page
- Gọi nhân viên
- Thông báo realtime

### Vận hành đơn hàng
- Thêm món, cập nhật trạng thái
- Nhân viên xác nhận / từ chối
- Theo dõi theo bàn hoặc QR session

### Thanh toán
- Tạo giao dịch
- Callback Napas / VietQR
- Hoàn tiền
- Tra cứu giao dịch

### Quản trị
- Login / register admin
- Quản lý menu, bàn, khách, nhân viên
- Audit log
- Realtime notifications

### Báo cáo
- Doanh thu
- Sản phẩm
- Khách hàng
- Chatbot
- Dashboard quản lý

## Cần cải thiện

### Ổn định dữ liệu & DB
- Chuẩn hóa migration + seed (PostgreSQL), có script reset sequence, rollback.
- Rà soát ràng buộc FK, enum, index cho truy vấn báo cáo.
### Kiểm thử & chất lượng
- Thêm test API cốt lõi (orders, payment, QR session, cart).
- Thiết lập CI chạy lint/test.
### Bảo mật & phân quyền
- Rà soát middleware auth/role ở toàn bộ route admin.
- Hạn chế log dữ liệu nhạy cảm, chuẩn hóa error response.
### Observability
- Thêm logging cấu trúc (request id, user id, response time).
- Theo dõi lỗi (Sentry hoặc tương đương).
### UX/Flow khách hàng
- Rõ ràng hoá flow quét QR → tạo session → đặt món.
- Thông báo lỗi thân thiện, trạng thái loading nhất quán.
### Thanh toán
- Hoàn thiện callback & đối soát trạng thái giao dịch.
- Xử lý retry, timeout, và hoàn tiền an toàn.
### Tài liệu & hướng dẫn
- API docs đầy đủ + collection Thunder/Postman.
- Hướng dẫn vận hành (setup env, run, migrate, seed).
### Tối ưu hiệu năng
- Cache menu/chatbot, giới hạn size upload, tối ưu ảnh Cloudinary.
- Tối ưu query dashboard/báo cáo.

## 🔗 API

Base URL:
```
http://localhost:8000/api
```

### Menu (/menu)
- GET /cus/menus/categories
- GET /cus/menus/item/:id
- GET /cus/menus/category/:id
- GET /cus/menus/:name
- GET /admin/categories/:id
- POST /admin/categories
- PUT /admin/categories/:id
- DELETE /admin/categories/:id
- DELETE /admin/categories/:id/permanent
- GET /admin/categories/export/excel
- GET /admin/categories/template/excel
- POST /admin/categories/import/excel
- GET /admin/menus/export/excel
- GET /admin/menus/template/excel
- POST /admin/menus/import/excel
- POST /admin/menus
- PUT /admin/menus/:id
- DELETE /admin/menus/:id
- DELETE /admin/menus/:id/permanent

### Menu Item Admin (/menu-item)
- PUT /:id
- DELETE /:id

### Cart (/cart)
- GET /cus/cart
- POST /cus/cart
- DELETE /
- PUT /items/:id
- DELETE /items/:id
- PUT /:id/status

### Orders (/orders)
- POST /admin/create
- GET /
- GET /session/:qr_session_id
- GET /table/:table_id
- GET /:id
- POST /
- POST /:id/items
- PUT /:id/status
- PUT /:orderId/cancel
- DELETE /:orderId/items/:itemId
- PUT /:orderId/items/:itemId

### Staff Orders (/staff/orders)
- PUT /:id/confirm
- PUT /:id/reject
- PUT /item/:itemId

### Payment (/payment)
- POST /admin
- POST /session
- POST /generate-qr
- POST /refund
- POST /callback
- POST /noti
- POST /
- GET /
- GET /:id
- PUT /session/:sessionId/cancel

### Customers (/customers)
- POST /
- GET /me/:identifier
- POST /calculate-points
- GET /
- GET /:id
- PUT /:id
- PUT /:id/points
- GET /:id/history
- DELETE /:id

### Call Staff (/call-staff)
- POST /

### Chatbot (/chatbot)
- POST /

### Chatbot V2 (/chatbot-v2)
- POST /chat
- GET /history/:session_id
- DELETE /conversation/:session_id
- POST /thread
- GET /rate-limit-status
- GET /cache-stats
- DELETE /cache/:thread_id
- GET /health

### Review (/review)
Restaurant:
- POST /
- GET /restaurant/:qr_session_id
- GET /restaurant
- DELETE /restaurant/:id

Menu:
- POST /menu
- GET /menu/item/:item_id
- DELETE /menu/:id

### Admin (/admin)
- POST /login
- GET /validate
- POST /register-admin
- GET /man/logins
- GET /stats
- GET /search
- GET /
- GET /:id
- GET /:id/employee
- PUT /:id
- PUT /:id/password
- PUT /:id/reset-password
- PUT /:id/deactivate
- PUT /:id/activate
- POST /:id/restore
- DELETE /:id
- DELETE /:id/permanent

### QR Sessions (/qr-sessions)
- POST /scan
- GET /:id/validate
- PUT /:id/end
- PUT /:sessionId/customer
- GET /:id

### QR Codes (/qr)
- POST /generate/:tableId
- POST /generate-all
- POST /validate
- GET /scan
- GET /info/:tableId
- GET /download/:tableId
- DELETE /:tableId

### Tables (/tables)
- POST /
- GET /
- PUT /:id
- DELETE /:id
- GET /:id

### Audit (/audit)
- POST /
- GET /
- GET /:id

### Notifications (/notifications)
- GET /
- GET /unread-count
- GET /:id
- POST /
- PATCH /:id/read
- PATCH /read-all
- DELETE /:id
- DELETE /clear-all

### Employees (/employees)
- GET /stats
- GET /search
- GET /
- GET /:id
- POST /
- PUT /:id
- POST /:id/restore
- DELETE /:id
- DELETE /:id/permanent

### Dashboard (/dashboard)
- GET /stats
- GET /revenue
- GET /top-dishes
- GET /order-status
- GET /table-status
- GET /recent-orders
- GET /performance

### Dashboard Sales (/dashboard/sales)
- GET /trend
- GET /dishes
- GET /categories

### Dashboard Customers (/dashboard/customers)
- GET /loyalty-trend
- GET /top
- GET /point-distribution

### Dashboard Reviews (/dashboard/reviews)
- GET /restaurant/stats
- GET /restaurant/trend
- GET /restaurant/recent
- GET /restaurant/detail
- GET /menu/stats
- GET /menu/trend
- GET /menu/top-rated
- GET /menu/lowest-rated
- GET /menu/recent
- GET /menu/detail
- GET /distribution

### Points (/points)
- GET /customer/:customerId

### Static Files
```
GET /qr/<file>
GET /uploads/<file>
```
(not prefixed by /api)
