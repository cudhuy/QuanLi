CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(150),
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(30),
    password_hash VARCHAR(255) NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_roles (
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role_id INTEGER NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    active BOOLEAN DEFAULT TRUE
);

CREATE TABLE dining_tables (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    seats INTEGER NOT NULL,
    status VARCHAR(50) DEFAULT 'available'
);

CREATE TABLE menu_items (
    id SERIAL PRIMARY KEY,
    category_id INTEGER REFERENCES categories(id),
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price NUMERIC(12,2) NOT NULL,
    image_url TEXT,
    active BOOLEAN DEFAULT TRUE,
    sold_count INTEGER DEFAULT 0
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    table_id INTEGER REFERENCES dining_tables(id),
    status VARCHAR(50) DEFAULT 'pending',
    total_amount NUMERIC(12,2) DEFAULT 0,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50) DEFAULT 'unpaid',
    note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    menu_item_id INTEGER NOT NULL REFERENCES menu_items(id),
    quantity INTEGER NOT NULL,
    price NUMERIC(12,2) NOT NULL
);

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    customer_name VARCHAR(150) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    booking_time TIMESTAMP NOT NULL,
    guests INTEGER NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    note TEXT
);

CREATE TABLE ratings (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
    rating INTEGER NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO roles (name) VALUES ('ADMIN'), ('STAFF'), ('USER');

INSERT INTO users (username, full_name, email, phone, password_hash, active)
VALUES ('admin', 'Administrator', 'admin@example.com', '0000000000',
        '$2a$10$YLiNSO07hby2QlvO4lHduO0ZhdYvCEOP.y8b7uE8ja.8nEhT7/p9S', TRUE);

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u CROSS JOIN roles r WHERE u.username = 'admin' AND r.name = 'ADMIN';

INSERT INTO categories (name, description) VALUES ('Mon chinh', 'Danh sach mon chinh');
INSERT INTO dining_tables (name, seats, status) VALUES ('Ban 1', 4, 'available');
INSERT INTO menu_items (category_id, name, description, price, active, sold_count)
VALUES (1, 'Com chien', 'Com chien thap cam', 45000, TRUE, 0);
