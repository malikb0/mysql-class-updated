-- shopdb seed — deterministic sample data for the whole course.
-- Safe to re-run: it truncates the course tables first.

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE payments;
TRUNCATE TABLE order_items;
TRUNCATE TABLE orders;
TRUNCATE TABLE products;
TRUNCATE TABLE categories;
TRUNCATE TABLE employees;
TRUNCATE TABLE stores;
TRUNCATE TABLE customers;
TRUNCATE TABLE addresses;
TRUNCATE TABLE persons;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO persons (person_id, first_name, last_name, dob, gender, email, phone) VALUES
  (1,  'Aisha',  'Khan',    '1990-05-14', 'F', 'aisha.khan@example.com',   '503-555-0101'),
  (2,  'Bilal',  'Ahmed',   '1985-11-02', 'M', 'bilal.ahmed@example.com',  '512-555-0102'),
  (3,  'Chen',   'Wei',     '1992-03-21', 'M', 'chen.wei@example.com',     '303-555-0103'),
  (4,  'Dana',   'Ortiz',   '1996-07-30', 'F', 'dana.ortiz@example.com',   '206-555-0104'),
  (5,  'Emeka',  'Okafor',  '1988-01-19', 'M', 'emeka.okafor@example.com', '305-555-0105'),
  (6,  'Fatima', 'Noor',    '1994-09-09', 'F', 'fatima.noor@example.com',  '617-555-0106'),
  (7,  'Giorgio','Rossi',   '1983-04-27', 'M', 'giorgio.rossi@example.com','312-555-0107'),
  (8,  'Hana',   'Sato',    '1997-12-01', 'F', 'hana.sato@example.com',    '602-555-0108'),
  (9,  'Igor',   'Petrov',  '1979-06-15', 'M', 'igor.petrov@example.com',  '214-555-0109'),
  (10, 'Juana',  'Lopez',   '1991-02-08', 'F', 'juana.lopez@example.com',  '404-555-0110'),
  (11, 'Kwame',  'Mensah',  '1986-10-23', 'M', 'kwame.mensah@example.com', '713-555-0111'),
  (12, 'Lena',   'Fischer', '1993-08-05', 'F', 'lena.fischer@example.com', '619-555-0112');

INSERT INTO addresses (person_id, street, city, region, postal_code, country, is_primary) VALUES
  (1,  '12 Maple St',   'Portland', 'OR', '97201', 'USA', TRUE),
  (2,  '88 Oak Ave',    'Austin',   'TX', '73301', 'USA', TRUE),
  (3,  '5 Pine Rd',     'Denver',   'CO', '80014', 'USA', TRUE),
  (4,  '200 Elm Blvd',  'Seattle',  'WA', '98101', 'USA', TRUE),
  (5,  '14 Cedar Ln',   'Miami',    'FL', '33101', 'USA', TRUE),
  (6,  '9 Birch Way',   'Boston',   'MA', '02108', 'USA', TRUE),
  (7,  '31 Spruce Dr',  'Chicago',  'IL', '60601', 'USA', TRUE),
  (8,  '77 Aspen Ct',   'Phoenix',  'AZ', '85001', 'USA', TRUE),
  (9,  '3 Willow St',   'Dallas',   'TX', '75201', 'USA', TRUE),
  (10, '55 Poplar Ave', 'Atlanta',  'GA', '30301', 'USA', TRUE),
  (11, '6 Magnolia Rd', 'Houston',  'TX', '77001', 'USA', TRUE),
  (12, '19 Juniper Pl', 'San Diego','CA', '92101', 'USA', TRUE);

INSERT INTO customers (customer_id, person_id, date_joined, is_active) VALUES
  (1, 1, '2023-06-01', TRUE),
  (2, 2, '2023-08-14', TRUE),
  (3, 3, '2023-09-30', TRUE),
  (4, 4, '2023-11-11', FALSE),
  (5, 5, '2024-01-02', TRUE),
  (6, 6, '2024-02-20', TRUE);

INSERT INTO stores (store_id, name, city, opened_on) VALUES
  (1, 'Downtown', 'Portland', '2019-03-01'),
  (2, 'Riverside', 'Austin',  '2021-09-15');

INSERT INTO employees (employee_id, person_id, store_id, supervisor_id, role, hired_on) VALUES
  (1, 7,  1, NULL, 'manager',   '2019-03-01'),
  (2, 8,  1, 1,    'associate', '2020-06-15'),
  (3, 9,  2, 1,    'manager',   '2021-01-20'),
  (4, 10, 1, 1,    'associate', '2022-09-05'),
  (5, 11, 2, 3,    'associate', '2023-02-11');

INSERT INTO categories (category_id, name) VALUES
  (1, 'Coffee'), (2, 'Tea'), (3, 'Bakery'), (4, 'Merch');

INSERT INTO products (product_id, category_id, name, sku, unit_price, is_active) VALUES
  (1,  1, 'Espresso Blend', 'COF-001', 12.50, TRUE),
  (2,  1, 'House Roast',    'COF-002', 10.00, TRUE),
  (3,  1, 'Decaf',          'COF-003', 11.25, TRUE),
  (4,  2, 'Green Tea',      'TEA-001',  8.00, TRUE),
  (5,  2, 'Earl Grey',      'TEA-002',  8.50, TRUE),
  (6,  2, 'Chai',           'TEA-003',  9.00, TRUE),
  (7,  3, 'Croissant',      'BAK-001',  3.75, TRUE),
  (8,  3, 'Muffin',         'BAK-002',  3.25, TRUE),
  (9,  4, 'Ceramic Mug',    'MER-001', 14.00, TRUE),
  (10, 4, 'Tote Bag',       'MER-002', 18.00, TRUE);

INSERT INTO orders (order_id, customer_id, store_id, order_date, status) VALUES
  (1, 1, 1, '2024-01-05 09:15:00', 'paid'),
  (2, 2, 1, '2024-01-06 10:05:00', 'paid'),
  (3, 1, 2, '2024-01-07 14:20:00', 'shipped'),
  (4, 3, 1, '2024-01-08 08:45:00', 'pending'),
  (5, 4, 2, '2024-01-09 16:30:00', 'paid'),
  (6, 5, 1, '2024-01-10 11:10:00', 'cancelled'),
  (7, 6, 2, '2024-01-11 13:00:00', 'paid'),
  (8, 2, 2, '2024-01-12 17:40:00', 'shipped');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
  (1, 1,  2, 12.50),
  (1, 7,  1,  3.75),
  (2, 2,  1, 10.00),
  (2, 9,  1, 14.00),
  (3, 3,  1, 11.25),
  (3, 8,  2,  3.25),
  (4, 4,  3,  8.00),
  (5, 5,  1,  8.50),
  (5, 10, 1, 18.00),
  (6, 6,  1,  9.00),
  (7, 1,  1, 12.50),
  (7, 7,  2,  3.75),
  (7, 9,  1, 14.00),
  (8, 2,  2, 10.00);

INSERT INTO payments (order_id, paid_at, amount, method) VALUES
  (1, '2024-01-05 09:16:00', 28.75, 'card'),
  (2, '2024-01-06 10:06:00', 24.00, 'transfer'),
  (3, '2024-01-07 14:21:00', 17.75, 'card'),
  (5, '2024-01-09 16:31:00', 26.50, 'card'),
  (7, '2024-01-11 13:01:00', 33.75, 'cash'),
  (8, '2024-01-12 17:41:00', 20.00, 'card');
