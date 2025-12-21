# Backend Migration Task (Laravel -> Spring Boot + PostgreSQL)

Tai lieu nay la task cho agent AI de **migration backend Laravel** sang **Spring Boot + PostgreSQL** va **giu nguyen contract cho Frontend** (khong phai sua FE). Ket qua mong muon: Spring Boot build/serve duoc toan bo API ma FE dang goi va san sang chay production.
- Yeu cau cong cu: Maven Spring Boot (Java 21), du an co `mvnw`, `mvnw.cmd`, `pom.xml`; database PostgreSQL `jdbc:postgresql://localhost:5432/quan_ly_nh` (user `postgres`, pass `123456`).

## Muc tieu
- Chuyen tat ca endpoints Laravel sang Spring Boot, bao gom auth, public API va admin/staff API.
- Thay database sang PostgreSQL, giu data model tuong duong.
- Dam bao FE (dang goi `http://localhost:8000/api` hoac `http://192.168.10.96:8000/api`) chi can doi baseURL la chay duoc.
- Hop dong API: path/query/body/response/error/pagination giong Laravel, khong lam vo UI.

## Nguyen tac
- Giup FE khong doi: giu nguyen route, ten param, header, status code, JSON wrapper, field naming/casing. Tra ve 401/403/422/500 giong Laravel dang dung.
- Uu tien mapping data va tinh nang 1-1 truoc khi refactor.
- Moi nhom API xong phai test Postman/curl va update checklist.
- Ghi ro config can thiet (.env, secret payment, storage).

## Khao sat Laravel hien tai
- Doc `routes/api.php`, cac middleware (auth:sanctum), policy, form request/validation.
- Doc cac controller chinh (CheckoutController, Booking, Menu, Table, Auth, Admin*).
- Doc model va migration de biet bang/cot/quan he.
- Doc cau hinh VNPay/QR/payment, file upload/storage/public URL.
- Ghi nhan format response chung (co wrapper `data`, `message`, `errors`?).

## Ke hoach Spring Boot
1) Thiet ke DB PostgreSQL
   - Tao schema theo migrations Laravel (bang + khoa ngoai + enum/status).
   - Viet Flyway/Liquibase migration. Neu can seed: roles, admin, sample menu/table.

2) Khoi tao project
   - Spring Boot 3.x + Java 21, Maven/Gradle.
   - Dependencies: Web, Security, Data JPA, Validation, PostgreSQL, Lombok, JWT, (tuy chon) MapStruct, Flyway, DevTools.
   - Dependencies cho phép thêm Dependencies mới nếu cần thiết.

3) Core mapping
   - Entity + repository tuong ung cac bang Laravel.
   - DTO + mapper + validation.
   - Service/business logic (order, payment, booking, rating, chatbox neu co, voucher neu co).

4) Auth & RBAC
   - Login/logout, refresh token neu can; BCrypt password.
   - Role admin/staff/user giong Laravel (header Authorization: Bearer token; FE co gui `X-User-Role` khi co).
   - CORS, CSRF (neu dung cookie) cau hinh de FE goi duoc.

5) API migration (giu nguyen path)
   - Public:
     - `/cate`, `/table`, `/list-menu`, `/order`, `/order-item/{id}`
     - `/popular-dishes`, `/booking`, `/chatbox`, `/rating/form/{order_id}`, `/rating/submit`
     - `/payment`, `/vnpay_payment`, `/vnpay_callback`, `/internal_payment`
   - Auth/admin/staff:
     - `/login`, `/logout`
     - `/admin/list-user`, `/admin/add-user`, `/admin/update-user/{id}`, `/admin/user/{id}`
     - `/admin/add-table`, `/admin/update-table/{id}`, `/admin/table/{id}`
     - `/admin/add-cate`, `/admin/update-cate/{id}`, `/admin/delete-cate/{id}`, `/admin/cate/{id}`
     - `/admin/add-menu`, `/admin/update-menu/{id}`
     - `/admin/list-booking`, `/admin/update-booking/{id}`
     - `/admin/update-order/{id}`, `/admin/dashboard`
   - Neu Laravel co them endpoints khac, bo sung vao danh sach tren va giu path.

6) Tich hop payment & ben ngoai
   - VNPay: giu tham so request, chu ky, callback `/vnpay_callback`, kiem tra checksum, update order/payment status.
   - Internal payment: tra ve `review_url` va `qr_code_base64` neu Laravel tra; method cash/card/VNPay; dong bo hoa don.
   - File upload/storage: neu co anh/QR, cau hinh path cong khai giong Laravel (public URL).

7) Ket noi frontend
   - FE su dung axios baseURL `http://localhost:8000/api` (hoac `http://192.168.10.96:8000/api`); dam bao Spring Boot expose cung base path `/api` hoac cau hinh reverse proxy.
   - Header: Authorization Bearer <token>, co the kem `X-User-Role`; Content-Type application/json.
   - Response: giu wrapper/fields y het (vi du `{ data: ..., message: ... }`), ma loi 401 -> redirect login.
   - Pagination/filter: giu tham so page/limit/sort giong Laravel neu co.
   - Datetime/number format: ISO8601 UTC hoac format Laravel dang dung (kiem tra truoc).
   - Neu chay chung tren một máy (chắc chắn sẽ trên 1 máy): cau hinh Spring Boot `server.port=8000` (hoac reverse proxy ve 8000) va cap nhat FE axios baseURL tu IP 192.168.* ve `http://localhost:8000/api`; CORS cho phep origin `http://localhost:3000` (hoac port FE dang chay).

8) Test & validation
   - Postman/curl cho tung endpoint (happy path + validation 422 + auth 401/403).
   - Smoke FE: doi baseURL sang Spring Boot, test cac man hinh quan trong (order, booking, payment, admin CRUD).
   - Log ra de debug, nhung tra ve response giong Laravel.

## Done Definition
- Tat ca endpoints tren chay dung format (path, query, body, response, error) voi FE, khong co 404/500.
- Auth/RBAC hoat dong: login/logout, role admin/staff/user, CORS ok.
- VNPay/internal payment hoat dong: callback nhan va cap nhat order/payment status.
- Flyway/Liquibase chay sach tren PostgreSQL moi; seed toi thieu (roles, admin, menu/table mau) neu FE can.
- OpenAPI/Postman collection duoc cap nhat (hoac ghi chu file huong dan), FE co the trieu hoi.
- Test Postman/curl pass; FE smoke test khong gap loi hop dong.

## Checklist tien do (theo 8 danh muc ke hoach Spring Boot)
- [ ] 1) Thiet ke DB PostgreSQL: schema Flyway/Liquibase hoan tat, seed toi thieu (roles/admin/menu/table)
- [ ] 2) Khoi tao project: Maven/Java21, dependency Web/Security/JPA/Validation/PostgreSQL/Lombok/JWT/MapStruct, config DB + port 8000
- [ ] 3) Core mapping: Entity + Repository, DTO/mapper/validation, Service/business logic (order, payment, booking, rating, chatbox/voucher neu co)
- [ ] 4) Auth & RBAC: login/logout/refresh, BCrypt password, role admin/staff/user, CORS/CSRF phu hop
- [ ] 5) API migration: Public (`/cate`, `/table`, `/list-menu`, `/order`, `/order-item/{id}`, `/popular-dishes`, `/booking`, `/chatbox`, `/rating/form/{order_id}`, `/rating/submit`, `/payment`, `/vnpay_payment`, `/vnpay_callback`, `/internal_payment`) va Auth/Admin/Staff (`/login`, `/logout`, `/admin/...`) giu nguyen path/format
- [ ] 6) Payment & ben ngoai: VNPay (request + checksum + callback cap nhat trang thai), internal payment (review_url/qr_code_base64), upload/storage public URL
- [ ] 7) Ket noi frontend: baseURL `/api` localhost:8000, headers/response wrapper/pagination/datetime format khop Laravel, CORS cho FE
- [ ] 8) Test & validation: Postman/curl pass, Smoke FE doi baseURL sang Spring Boot, cap nhat OpenAPI/Postman, log/error thong nhat, ghi ro config/env/secret
