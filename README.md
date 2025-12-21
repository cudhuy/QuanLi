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

## 🔗 API

Base URL:
```
http://localhost:8000/api
```

### Menu (/menu)
- GET /cus/menus/categories
- GET /cus/menus/item/:id
- GET /cus/menus/:name
- GET /cus/menus/category/:id
- GET /cus/menus/all
- POST /admin/menus

### Menu Item Admin (/menu-item)
- PUT /:id
- DELETE /:id

### Cart (/cart)
- GET /cus/cart
- POST /cus/cart

### Orders (/orders)
- GET /
- GET /session/:qr_session_id
- GET /table/:table_id
- GET /:id
- POST /
- POST /:id/items
- PUT /:id/status

### Staff Orders (/staff/orders)
- PUT /:id/confirm
- PUT /:id/reject
- PUT /item/:itemId

### Payment (/payment)
- POST /
- POST /callback
- POST /refund
- GET /
- GET /:id

### Customers (/customers)
- POST /
- GET /

### Call Staff (/call-staff)
- POST /

### Chatbot (/chatbot)
- POST /

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
- POST /register-admin
- GET /man/logins

### QR Sessions (/qr-sessions)
- POST /scan
- PUT /:id/end

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
- PUT /:id
- DELETE /:id
- GET /

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

### Static QR Images
```
GET /qr/<file>
```
(không có tiền tố /api)
