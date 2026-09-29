-- shopdb schema — the course database.
-- Rebuild order: 00-schema.sql, then 10-seed.sql (run via `make seed` / `python dbctl.py seed`).

CREATE TABLE IF NOT EXISTS persons (
  person_id  INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50)  NOT NULL,
  last_name  VARCHAR(50)  NOT NULL,
  dob        DATE         NULL,
  gender     ENUM('M','F','X') NULL,
  email      VARCHAR(120) NOT NULL UNIQUE,
  phone      VARCHAR(30)  NULL,
  created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS addresses (
  address_id  INT AUTO_INCREMENT PRIMARY KEY,
  person_id   INT NOT NULL,
  street      VARCHAR(120) NOT NULL,
  city        VARCHAR(60)  NOT NULL,
  region      VARCHAR(60)  NULL,
  postal_code VARCHAR(20)  NULL,
  country     VARCHAR(60)  NOT NULL DEFAULT 'USA',
  is_primary  BOOLEAN      NOT NULL DEFAULT TRUE,
  CONSTRAINT fk_address_person FOREIGN KEY (person_id) REFERENCES persons(person_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  person_id   INT NOT NULL UNIQUE,
  date_joined DATE NOT NULL,
  is_active   BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT fk_customer_person FOREIGN KEY (person_id) REFERENCES persons(person_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS stores (
  store_id  INT AUTO_INCREMENT PRIMARY KEY,
  name      VARCHAR(80) NOT NULL,
  city      VARCHAR(60) NOT NULL,
  opened_on DATE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS employees (
  employee_id   INT AUTO_INCREMENT PRIMARY KEY,
  person_id     INT NOT NULL UNIQUE,
  store_id      INT NOT NULL,
  supervisor_id INT NULL,
  role          VARCHAR(40) NOT NULL DEFAULT 'associate',
  hired_on      DATE NOT NULL,
  CONSTRAINT fk_employee_person FOREIGN KEY (person_id) REFERENCES persons(person_id),
  CONSTRAINT fk_employee_store  FOREIGN KEY (store_id) REFERENCES stores(store_id),
  CONSTRAINT fk_employee_super  FOREIGN KEY (supervisor_id) REFERENCES employees(employee_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS categories (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(60) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS products (
  product_id  INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  name        VARCHAR(80) NOT NULL,
  sku         VARCHAR(20) NOT NULL UNIQUE,
  unit_price  DECIMAL(10,2) NOT NULL,
  is_active   BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES categories(category_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS orders (
  order_id    INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  store_id    INT NOT NULL,
  order_date  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status      ENUM('pending','paid','shipped','cancelled') NOT NULL DEFAULT 'pending',
  CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  CONSTRAINT fk_order_store    FOREIGN KEY (store_id) REFERENCES stores(store_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS order_items (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id      INT NOT NULL,
  product_id    INT NOT NULL,
  quantity      INT NOT NULL,
  unit_price    DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_item_order   FOREIGN KEY (order_id) REFERENCES orders(order_id),
  CONSTRAINT fk_item_product FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id   INT NOT NULL,
  paid_at    DATETIME NOT NULL,
  amount     DECIMAL(10,2) NOT NULL,
  method     ENUM('card','cash','transfer') NOT NULL DEFAULT 'card',
  CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES orders(order_id)
) ENGINE=InnoDB;
