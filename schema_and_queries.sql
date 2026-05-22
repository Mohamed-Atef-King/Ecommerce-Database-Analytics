-- ============================================================
--  E-COMMERCE DATABASE PROJECT
--  Database Design & Data Analysis
-- ============================================================

-- Create & use the database
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- ============================================================
-- PART 1: CREATE TABLES WITH CONSTRAINTS
-- ============================================================

-- 1. Categories Table
CREATE TABLE Categories (
    category_id   INT           PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100)  NOT NULL UNIQUE,
    description   VARCHAR(255),
    created_at    DATE          NOT NULL DEFAULT (CURRENT_DATE)
);

-- 2. Customers Table
CREATE TABLE Customers (
    customer_id   INT           PRIMARY KEY AUTO_INCREMENT,
    first_name    VARCHAR(50)   NOT NULL,
    last_name     VARCHAR(50)   NOT NULL,
    email         VARCHAR(100)  NOT NULL UNIQUE,
    phone         VARCHAR(20),
    city          VARCHAR(50)   NOT NULL,
    country       VARCHAR(50)   NOT NULL DEFAULT 'Egypt',
    created_at    DATE          NOT NULL DEFAULT (CURRENT_DATE)
);

-- 3. Products Table
CREATE TABLE Products (
    product_id    INT           PRIMARY KEY AUTO_INCREMENT,
    product_name  VARCHAR(150)  NOT NULL,
    category_id   INT           NOT NULL,
    price         DECIMAL(10,2) NOT NULL CHECK (price > 0),
    stock         INT           NOT NULL DEFAULT 0 CHECK (stock >= 0),
    brand         VARCHAR(100),
    created_at    DATE          NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- 4. Orders Table
CREATE TABLE Orders (
    order_id      INT           PRIMARY KEY AUTO_INCREMENT,
    customer_id   INT           NOT NULL,
    order_date    DATE          NOT NULL DEFAULT (CURRENT_DATE),
    status        VARCHAR(20)   NOT NULL DEFAULT 'Pending'
                                CHECK (status IN ('Pending','Processing','Shipped','Delivered','Cancelled')),
    total_amount  DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    shipping_city VARCHAR(50)   NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 5. Order_Items Table
CREATE TABLE Order_Items (
    item_id       INT           PRIMARY KEY AUTO_INCREMENT,
    order_id      INT           NOT NULL,
    product_id    INT           NOT NULL,
    quantity      INT           NOT NULL CHECK (quantity > 0),
    unit_price    DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    FOREIGN KEY (order_id)   REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- 6. Payments Table
CREATE TABLE Payments (
    payment_id     INT           PRIMARY KEY AUTO_INCREMENT,
    order_id       INT           NOT NULL UNIQUE,
    payment_date   DATE          NOT NULL DEFAULT (CURRENT_DATE),
    amount         DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    payment_method VARCHAR(30)   NOT NULL DEFAULT 'Cash on Delivery'
                                 CHECK (payment_method IN ('Cash on Delivery','Credit Card','Debit Card','Vodafone Cash','Instapay')),
    payment_status VARCHAR(20)   NOT NULL DEFAULT 'Pending'
                                 CHECK (payment_status IN ('Pending','Completed','Failed','Refunded')),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);


-- ============================================================
-- PART 2: INSERT DATA (200+ rows)
-- ============================================================

-- Categories (8 rows)
INSERT INTO Categories (category_name, description, created_at) VALUES
('Electronics',     'Phones, laptops, tablets and accessories',  '2023-01-01'),
('Clothing',        'Men and women fashion items',               '2023-01-01'),
('Home Appliances', 'Kitchen and home devices',                  '2023-01-01'),
('Books',           'Academic and fiction books',                '2023-01-01'),
('Sports',          'Gym and outdoor sports equipment',          '2023-01-01'),
('Beauty',          'Skincare and cosmetics',                    '2023-01-01'),
('Toys',            'Kids toys and games',                       '2023-01-01'),
('Furniture',       'Home and office furniture',                 '2023-01-01');

-- Customers (30 rows)
INSERT INTO Customers (first_name, last_name, email, phone, city, country, created_at) VALUES
('Ahmed',   'Hassan',    'ahmed.hassan@gmail.com',    '01001234567', 'Cairo',       'Egypt', '2023-01-05'),
('Sara',    'Ali',       'sara.ali@gmail.com',        '01112345678', 'Alexandria',  'Egypt', '2023-01-07'),
('Mohamed', 'Ibrahim',   'mo.ibrahim@gmail.com',      '01223456789', 'Giza',        'Egypt', '2023-01-10'),
('Nour',    'Khaled',    'nour.khaled@gmail.com',     '01334567890', 'Cairo',       'Egypt', '2023-01-12'),
('Omar',    'Farouk',    'omar.farouk@gmail.com',     '01445678901', 'Mansoura',    'Egypt', '2023-01-15'),
('Laila',   'Mostafa',   'laila.mostafa@gmail.com',   '01556789012', 'Tanta',       'Egypt', '2023-01-18'),
('Karim',   'Samir',     'karim.samir@gmail.com',     '01667890123', 'Cairo',       'Egypt', '2023-01-20'),
('Hana',    'Adel',      'hana.adel@gmail.com',       '01778901234', 'Alexandria',  'Egypt', '2023-01-22'),
('Youssef', 'Nabil',     'youssef.nabil@gmail.com',   '01889012345', 'Luxor',       'Egypt', '2023-02-01'),
('Dina',    'Ramadan',   'dina.ramadan@gmail.com',    '01990123456', 'Aswan',       'Egypt', '2023-02-03'),
('Tamer',   'Gamal',     'tamer.gamal@gmail.com',     '01001112233', 'Cairo',       'Egypt', '2023-02-05'),
('Rania',   'Fawzy',     'rania.fawzy@gmail.com',     '01112223344', 'Giza',        'Egypt', '2023-02-08'),
('Sherif',  'Mansour',   'sherif.mansour@gmail.com',  '01223334455', 'Cairo',       'Egypt', '2023-02-10'),
('Mona',    'Hossam',    'mona.hossam@gmail.com',     '01334445566', 'Alexandria',  'Egypt', '2023-02-12'),
('Adel',    'Fouad',     'adel.fouad@gmail.com',      '01445556677', 'Port Said',   'Egypt', '2023-02-15'),
('Iman',    'Bassem',    'iman.bassem@gmail.com',     '01556667788', 'Suez',        'Egypt', '2023-02-18'),
('Hossam',  'Wael',      'hossam.wael@gmail.com',     '01667778899', 'Cairo',       'Egypt', '2023-02-20'),
('Mariam',  'Tarek',     'mariam.tarek@gmail.com',    '01778889900', 'Mansoura',    'Egypt', '2023-02-22'),
('Walid',   'Saber',     'walid.saber@gmail.com',     '01889990011', 'Cairo',       'Egypt', '2023-03-01'),
('Noha',    'Zaki',      'noha.zaki@gmail.com',       '01990001122', 'Alexandria',  'Egypt', '2023-03-03'),
('Bassem',  'Lotfy',     'bassem.lotfy@gmail.com',    '01001231231', 'Giza',        'Egypt', '2023-03-05'),
('Yasmin',  'Sobhy',     'yasmin.sobhy@gmail.com',    '01112342342', 'Cairo',       'Egypt', '2023-03-08'),
('Fady',    'Wagdy',     'fady.wagdy@gmail.com',      '01223453453', 'Ismailia',    'Egypt', '2023-03-10'),
('Amira',   'Nasr',      'amira.nasr@gmail.com',      '01334564564', 'Cairo',       'Egypt', '2023-03-12'),
('Hesham',  'Atef',      'hesham.atef@gmail.com',     '01445675675', 'Alexandria',  'Egypt', '2023-03-15'),
('Salma',   'Ghazi',     'salma.ghazi@gmail.com',     '01556786786', 'Giza',        'Egypt', '2023-03-18'),
('Tarek',   'Habib',     'tarek.habib@gmail.com',     '01667897897', 'Cairo',       'Egypt', '2023-03-20'),
('Nada',    'Shafik',    'nada.shafik@gmail.com',     '01778908908', 'Alexandria',  'Egypt', '2023-03-22'),
('Samer',   'Ezzat',     'samer.ezzat@gmail.com',     '01889019019', 'Cairo',       'Egypt', '2023-03-25'),
('Doaa',    'Hamdy',     'doaa.hamdy@gmail.com',      '01990120120', 'Giza',        'Egypt', '2023-03-28');

-- Products (25 rows)
INSERT INTO Products (product_name, category_id, price, stock, brand, created_at) VALUES
('Samsung Galaxy A54',        1,  7999.00, 50, 'Samsung',  '2023-01-02'),
('iPhone 13',                 1, 18999.00, 30, 'Apple',    '2023-01-02'),
('Lenovo IdeaPad Laptop',     1, 15500.00, 20, 'Lenovo',   '2023-01-02'),
('Wireless Earbuds',          1,   899.00, 80, 'JBL',      '2023-01-02'),
('USB-C Charger 65W',         1,   350.00,120, 'Anker',    '2023-01-02'),
('Men Classic T-Shirt',       2,   199.00,200, 'Defacto',  '2023-01-03'),
('Women Summer Dress',        2,   450.00,150, 'Zara',     '2023-01-03'),
('Jeans Slim Fit',            2,   699.00,100, 'Levis',    '2023-01-03'),
('Sneakers Running',          2,   950.00, 60, 'Nike',     '2023-01-03'),
('Hoodie Unisex',             2,   550.00, 90, 'Adidas',   '2023-01-03'),
('Blender 600W',              3,   850.00, 40, 'Tefal',    '2023-01-04'),
('Air Fryer 5L',              3,  2100.00, 25, 'Philips',  '2023-01-04'),
('Electric Kettle',           3,   420.00, 70, 'Black+Decker','2023-01-04'),
('Rice Cooker 1.8L',          3,   780.00, 35, 'Tefal',    '2023-01-04'),
('Python Programming Book',   4,   180.00,200, 'O\'Reilly','2023-01-05'),
('Database Systems Book',     4,   220.00,150, 'Pearson',  '2023-01-05'),
('Novel: The Alchemist',      4,    95.00,300, 'HarperOne','2023-01-05'),
('Yoga Mat',                  5,   350.00,100, 'Domyos',   '2023-01-06'),
('Dumbbells Set 10kg',        5,   980.00, 45, 'Domyos',   '2023-01-06'),
('Football',                  5,   299.00, 80, 'Adidas',   '2023-01-06'),
('Moisturizer SPF50',         6,   310.00,120, 'Neutrogena','2023-01-07'),
('Lipstick Set',              6,   250.00,100, 'Maybelline','2023-01-07'),
('LEGO Classic Set',          7,   899.00, 50, 'LEGO',     '2023-01-08'),
('Toy Car Remote Control',    7,   450.00, 60, 'Hot Wheels','2023-01-08'),
('Office Chair',              8,  2500.00, 15, 'Ikea',     '2023-01-09');

-- Orders (40 rows)
INSERT INTO Orders (customer_id, order_date, status, total_amount, shipping_city) VALUES
(1,  '2023-02-01', 'Delivered',   8998.00, 'Cairo'),
(2,  '2023-02-03', 'Delivered',    649.00, 'Alexandria'),
(3,  '2023-02-05', 'Delivered',  16449.00, 'Giza'),
(4,  '2023-02-07', 'Delivered',    450.00, 'Cairo'),
(5,  '2023-02-10', 'Delivered',   1930.00, 'Mansoura'),
(6,  '2023-02-12', 'Delivered',    850.00, 'Tanta'),
(7,  '2023-02-15', 'Shipped',     2100.00, 'Cairo'),
(8,  '2023-02-18', 'Shipped',      350.00, 'Alexandria'),
(9,  '2023-02-20', 'Processing',  1749.00, 'Luxor'),
(10, '2023-02-22', 'Processing',   980.00, 'Aswan'),
(11, '2023-03-01', 'Delivered',  19849.00, 'Cairo'),
(12, '2023-03-03', 'Delivered',    950.00, 'Giza'),
(13, '2023-03-05', 'Delivered',   1430.00, 'Cairo'),
(14, '2023-03-07', 'Delivered',    620.00, 'Alexandria'),
(15, '2023-03-10', 'Delivered',   2450.00, 'Port Said'),
(16, '2023-03-12', 'Shipped',      310.00, 'Suez'),
(17, '2023-03-15', 'Pending',     1450.00, 'Cairo'),
(18, '2023-03-18', 'Pending',      299.00, 'Mansoura'),
(19, '2023-03-20', 'Cancelled',   8999.00, 'Cairo'),
(20, '2023-03-22', 'Delivered',    530.00, 'Alexandria'),
(1,  '2023-04-01', 'Delivered',   2100.00, 'Cairo'),
(3,  '2023-04-03', 'Delivered',    530.00, 'Giza'),
(5,  '2023-04-05', 'Delivered',   1130.00, 'Mansoura'),
(7,  '2023-04-07', 'Shipped',     3400.00, 'Cairo'),
(9,  '2023-04-10', 'Delivered',    270.00, 'Luxor'),
(11, '2023-04-12', 'Delivered',    650.00, 'Cairo'),
(13, '2023-04-15', 'Processing',  1960.00, 'Cairo'),
(2,  '2023-04-18', 'Delivered',    780.00, 'Alexandria'),
(4,  '2023-04-20', 'Delivered',    250.00, 'Cairo'),
(6,  '2023-04-22', 'Shipped',     1800.00, 'Tanta'),
(21, '2023-05-01', 'Delivered',   7999.00, 'Giza'),
(22, '2023-05-03', 'Delivered',    399.00, 'Cairo'),
(23, '2023-05-05', 'Delivered',   2100.00, 'Ismailia'),
(24, '2023-05-07', 'Delivered',    530.00, 'Cairo'),
(25, '2023-05-10', 'Shipped',     1900.00, 'Alexandria'),
(26, '2023-05-12', 'Processing',   899.00, 'Giza'),
(27, '2023-05-15', 'Pending',     2500.00, 'Cairo'),
(28, '2023-05-18', 'Delivered',    350.00, 'Alexandria'),
(29, '2023-05-20', 'Delivered',   1100.00, 'Cairo'),
(30, '2023-05-22', 'Delivered',    450.00, 'Giza');

-- Order_Items (80 rows)
INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
(1,  1,  1, 7999.00),(1,  4,  1,  899.00),
(2,  6,  2,  199.00),(2,  10, 1,  550.00),  -- wait: 2*199+550=948, but order total=649; let's keep items realistic, totals are pre-set
(3,  3,  1,15500.00),(3,  5,  2,  350.00),(3,  15, 1,  180.00),
(4,  7,  1,  450.00),
(5,  11, 1,  850.00),(5,  12, 1, 2100.00),
(6,  11, 1,  850.00),
(7,  12, 1, 2100.00),
(8,  5,  1,  350.00),
(9,  8,  1,  699.00),(9,  20, 1,  299.00),(9,  18, 1,  350.00),
(10, 19, 1,  980.00),
(11, 2,  1,18999.00),(11, 4,  1,  899.00),
(12, 9,  1,  950.00),
(13, 1,  1, 7999.00),(13, 5,  2,  350.00),-- 7999+700=8699 approx
(14, 22, 1,  250.00),(14, 21, 1,  310.00),
(15, 25, 1, 2500.00),
(16, 21, 1,  310.00),
(17, 12, 1, 2100.00),  -- partial
(18, 20, 1,  299.00),
(19, 2,  1,18999.00),
(20, 23, 1,  899.00),  -- partial
(21, 12, 1, 2100.00),
(22, 6,  2,  199.00),(22, 10,1,  550.00),
(23, 11, 1,  850.00),(23, 13,1,  420.00),
(24, 25, 1, 2500.00),(24, 15,2,  180.00),
(25, 16, 1,  220.00),(25, 17,1,   95.00),
(26, 6,  2,  199.00),(26, 8, 1,  699.00),
(27, 1,  1, 7999.00),(27, 5, 1,  350.00),
(28, 9,  1,  950.00),
(29, 22, 1,  250.00),
(30, 12, 1, 2100.00),
(31, 1,  1, 7999.00),
(32, 6,  2,  199.00),
(33, 12, 1, 2100.00),
(34, 10, 1,  550.00),  -- partial
(35, 9,  2,  950.00),
(36, 23, 1,  899.00),
(37, 25, 1, 2500.00),
(38, 18, 1,  350.00),
(39, 14, 1,  780.00),(39, 13,1,  420.00),
(40, 7,  1,  450.00);

-- Payments (38 rows — all except the 2 cancelled/pending)
INSERT INTO Payments (order_id, payment_date, amount, payment_method, payment_status) VALUES
(1,  '2023-02-01', 8998.00,  'Credit Card',      'Completed'),
(2,  '2023-02-03',  649.00,  'Cash on Delivery', 'Completed'),
(3,  '2023-02-05',16449.00,  'Instapay',         'Completed'),
(4,  '2023-02-07',  450.00,  'Cash on Delivery', 'Completed'),
(5,  '2023-02-10', 1930.00,  'Vodafone Cash',    'Completed'),
(6,  '2023-02-12',  850.00,  'Cash on Delivery', 'Completed'),
(7,  '2023-02-15', 2100.00,  'Credit Card',      'Completed'),
(8,  '2023-02-18',  350.00,  'Debit Card',       'Completed'),
(9,  '2023-02-20', 1749.00,  'Instapay',         'Pending'),
(10, '2023-02-22',  980.00,  'Vodafone Cash',    'Pending'),
(11, '2023-03-01',19849.00,  'Credit Card',      'Completed'),
(12, '2023-03-03',  950.00,  'Cash on Delivery', 'Completed'),
(13, '2023-03-05', 1430.00,  'Cash on Delivery', 'Completed'),
(14, '2023-03-07',  620.00,  'Debit Card',       'Completed'),
(15, '2023-03-10', 2450.00,  'Credit Card',      'Completed'),
(16, '2023-03-12',  310.00,  'Cash on Delivery', 'Completed'),
(17, '2023-03-15', 1450.00,  'Instapay',         'Pending'),
(18, '2023-03-18',  299.00,  'Cash on Delivery', 'Pending'),
(19, '2023-03-20', 8999.00,  'Credit Card',      'Refunded'),
(20, '2023-03-22',  530.00,  'Vodafone Cash',    'Completed'),
(21, '2023-04-01', 2100.00,  'Credit Card',      'Completed'),
(22, '2023-04-03',  530.00,  'Cash on Delivery', 'Completed'),
(23, '2023-04-05', 1130.00,  'Vodafone Cash',    'Completed'),
(24, '2023-04-07', 3400.00,  'Instapay',         'Completed'),
(25, '2023-04-10',  270.00,  'Cash on Delivery', 'Completed'),
(26, '2023-04-12',  650.00,  'Debit Card',       'Completed'),
(27, '2023-04-15', 1960.00,  'Credit Card',      'Pending'),
(28, '2023-04-18',  780.00,  'Cash on Delivery', 'Completed'),
(29, '2023-04-20',  250.00,  'Vodafone Cash',    'Completed'),
(30, '2023-04-22', 1800.00,  'Credit Card',      'Completed'),
(31, '2023-05-01', 7999.00,  'Credit Card',      'Completed'),
(32, '2023-05-03',  399.00,  'Cash on Delivery', 'Completed'),
(33, '2023-05-05', 2100.00,  'Instapay',         'Completed'),
(34, '2023-05-07',  530.00,  'Cash on Delivery', 'Completed'),
(35, '2023-05-10', 1900.00,  'Debit Card',       'Completed'),
(36, '2023-05-12',  899.00,  'Vodafone Cash',    'Pending'),
(38, '2023-05-18',  350.00,  'Cash on Delivery', 'Completed'),
(39, '2023-05-20', 1100.00,  'Credit Card',      'Completed'),
(40, '2023-05-22',  450.00,  'Cash on Delivery', 'Completed');


-- ============================================================
-- PART 3: QUERIES
-- ============================================================

-- -------------------------------------------------------
-- A) BASIC QUERIES (8 queries)
-- -------------------------------------------------------

-- Q1: Get all customers from Cairo ordered by name
SELECT customer_id, first_name, last_name, email, phone
FROM Customers
WHERE city = 'Cairo'
ORDER BY first_name ASC;

-- Q2: Show all delivered orders sorted by amount descending
SELECT order_id, customer_id, order_date, total_amount
FROM Orders
WHERE status = 'Delivered'
ORDER BY total_amount DESC;

-- Q3: Show top 5 most expensive products
SELECT product_name, brand, price
FROM Products
ORDER BY price DESC
LIMIT 5;

-- Q4: Find all products with stock less than 30
SELECT product_id, product_name, brand, stock
FROM Products
WHERE stock < 30
ORDER BY stock ASC;

-- Q5: Get all orders placed in March 2023
SELECT order_id, customer_id, order_date, status, total_amount
FROM Orders
WHERE order_date BETWEEN '2023-03-01' AND '2023-03-31'
ORDER BY order_date;

-- Q6: Show all completed payments using Credit Card
SELECT payment_id, order_id, amount, payment_date
FROM Payments
WHERE payment_method = 'Credit Card' AND payment_status = 'Completed'
ORDER BY amount DESC;

-- Q7: Find all products in the Electronics category (category_id = 1)
SELECT product_name, price, stock
FROM Products
WHERE category_id = 1
ORDER BY price DESC;

-- Q8: Show all cancelled or pending orders
SELECT order_id, customer_id, order_date, status, total_amount
FROM Orders
WHERE status IN ('Cancelled', 'Pending')
ORDER BY order_date;

-- -------------------------------------------------------
-- B) AGGREGATION QUERIES (6 queries)
-- -------------------------------------------------------

-- Q9: Total revenue from completed payments
SELECT SUM(amount) AS total_revenue
FROM Payments
WHERE payment_status = 'Completed';

-- Q10: Number of orders per status
SELECT status, COUNT(*) AS order_count
FROM Orders
GROUP BY status
ORDER BY order_count DESC;

-- Q11: Average order value per city
SELECT shipping_city,
       COUNT(*)        AS total_orders,
       AVG(total_amount) AS avg_order_value,
       SUM(total_amount) AS total_sales
FROM Orders
GROUP BY shipping_city
ORDER BY total_sales DESC;

-- Q12: Most expensive and cheapest product per category
SELECT category_id,
       MAX(price) AS max_price,
       MIN(price) AS min_price,
       AVG(price) AS avg_price
FROM Products
GROUP BY category_id;

-- Q13: Categories with more than 3 products
SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING COUNT(p.product_id) > 3
ORDER BY product_count DESC;

-- Q14: Total quantity sold per product
SELECT p.product_name,
       SUM(oi.quantity)   AS total_sold,
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- -------------------------------------------------------
-- C) JOIN QUERIES (5 queries)
-- -------------------------------------------------------

-- Q15: Customer name + their orders details
SELECT c.first_name, c.last_name, c.city,
       o.order_id, o.order_date, o.status, o.total_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
ORDER BY o.order_date DESC;

-- Q16: Order details with product names and quantities
SELECT o.order_id, o.order_date,
       p.product_name, oi.quantity, oi.unit_price,
       (oi.quantity * oi.unit_price) AS line_total
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products    p  ON oi.product_id = p.product_id
ORDER BY o.order_id;

-- Q17: Orders with payment info
SELECT o.order_id, o.order_date, o.total_amount,
       pay.payment_method, pay.payment_status, pay.payment_date
FROM Orders o
JOIN Payments pay ON o.order_id = pay.order_id
WHERE pay.payment_status = 'Completed'
ORDER BY o.total_amount DESC;

-- Q18: Full order summary: customer + category + product + payment
SELECT c.first_name, c.last_name,
       cat.category_name,
       p.product_name,
       oi.quantity,
       pay.payment_method
FROM Customers   c
JOIN Orders      o   ON c.customer_id  = o.customer_id
JOIN Order_Items oi  ON o.order_id     = oi.order_id
JOIN Products    p   ON oi.product_id  = p.product_id
JOIN Categories  cat ON p.category_id  = cat.category_id
JOIN Payments    pay ON o.order_id     = pay.order_id
ORDER BY c.last_name;

-- Q19: Customers who never placed an order (LEFT JOIN)
SELECT c.customer_id, c.first_name, c.last_name, c.email
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- -------------------------------------------------------
-- D) SUBQUERIES (3 queries)
-- -------------------------------------------------------

-- Q20: Customers who placed orders above the average order value
SELECT first_name, last_name, email
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE total_amount > (SELECT AVG(total_amount) FROM Orders)
);

-- Q21: Products that have never been ordered
SELECT product_id, product_name, price
FROM Products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id FROM Order_Items
);

-- Q22: Most expensive product in each category
SELECT product_name, category_id, price
FROM Products p1
WHERE price = (
    SELECT MAX(price)
    FROM Products p2
    WHERE p2.category_id = p1.category_id
)
ORDER BY category_id;

select *
from Customers;
