/* P-1 Creation of Database Objects and Integrity Constraints (DDL). 
Create database which consist of following table and insertappropriate data into it.
i. Table: regions
● region_id: int(11), Primary Key, NOT NULL, AUTO_INCREMENT.
● regionname: varchar(50), DEFAULT NULL.
ii. Table: countries
● country_id: char(2), Primary Key, NOT NULL.
● countryname: varchar(40), NOT NULL.
● region_id: int(11), Foreign Key (References regions.region_id).
iii. Table: locations
● location_id: int(11), Primary Key, NOT NULL, AUTO_INCREMENT.
● address: varchar(255), NOT NULL.
● postalcode: varchar(20), DEFAULT NULL.
● city: varchar(50), DEFAULT NULL.
● state: varchar(50), DEFAULT NULL.
● country_id: char(2), Foreign Key (References countries.country_id).
iv. Table: warehouses
● warehouse_id: int(11), Primary Key, NOT NULL, AUTO_INCREMENT.
● warehousename: varchar(255), DEFAULT NULL.
● location_id: int(11), Foreign Key (References locations.location_id).
    v. Table: employees
● employee_id: int(11), Primary Key, NOT NULL, AUTO_INCREMENT.
● firstname: varchar(255), NOT NULL.
● lastname: varchar(255), NOT NULL.
● email: varchar(255), NOT NULL.
● phone: varchar(50), NOT NULL.
● hiredate: date, NOT NULL.
● manager_id: int(11), DEFAULT NULL (Self-referencing Foreign Key).
● jobtitle: varchar(255), NOT NULL.
vi. Table: product_categories
● category_id: int(11), Primary Key, NOT NULL, AUTO_INCREMENT.
● categoryname: varchar(255), NOT NULL.
vii. Table: products
● product_id: int(11), Primary Key, NOT NULL, AUTO_INCREMENT.
● productname: varchar(255), NOT NULL.
● description: varchar(2000), DEFAULT NULL.
● standardcost: int(11), DEFAULT NULL.
● listprice: int(11), DEFAULT NULL.
● category_id: int(11), NOT NULL, Foreign Key (References
product_categories.category_id).
viii. Table: customers
● customer_id: int(11), Primary Key, NOT NULL, AUTO_INCREMENT.
● name: varchar(255), NOT NULL.
● address: varchar(255), DEFAULT NULL.
● website: varchar(255), DEFAULT NULL.
● creditlimit: int(11), DEFAULT NULL.
ix. Table: orders
● order_id: int(11), Primary Key, NOT NULL, AUTO_INCREMENT.
● status: varchar(20), NOT NULL.
● customer_id: int(11), DEFAULT NULL (Foreign Key referencing customers).
● salesman_id: int(11), DEFAULT NULL (Foreign Key referencing employees).
● order_date: date, NOT NULL.
x. Table: order_items
● order_id: int(11), Composite Primary Key, NOT NULL.
● item_id: int(11), Composite Primary Key, NOT NULL.
● product_id: int(11), NOT NULL (Foreign Key referencing products).
● quantity: int(11), NOT NULL.
● unit_price: int(11), NOT NULL.
xi. Table: inventories
● product_id: int(11), Composite Primary Key, NOT NULL.
● warehouse_id: int(11), Composite Primary Key, NOT NULL.
● quantity: int(11), NOT NULL.  */



CREATE DATABASE Practical1;

USE Practical1;

-- =========================================================
-- 1. REGIONS
-- =========================================================

CREATE TABLE regions (
    region_id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    regionname VARCHAR(50) DEFAULT NULL
);

INSERT INTO regions (regionname) VALUES
('Asia'),
('Europe'),
('America'),
('Africa'),
('Australia');

SELECT * FROM regions;


-- =========================================================
-- 2. COUNTRIES
-- =========================================================

CREATE TABLE countries (
    country_id CHAR(2) PRIMARY KEY NOT NULL,
    countryname VARCHAR(40) NOT NULL,
    region_id INT(11),
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

INSERT INTO countries (country_id, countryname, region_id) VALUES
('IN', 'India', 1),
('US', 'United States', 3),
('UK', 'United Kingdom', 2),
('NG', 'Nigeria', 4),
('AU', 'Australia', 5);

SELECT * FROM countries;


-- =========================================================
-- 3. LOCATIONS
-- =========================================================

CREATE TABLE locations (
    location_id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    address VARCHAR(255) NOT NULL,
    postalcode VARCHAR(20) DEFAULT NULL,
    city VARCHAR(50) DEFAULT NULL,
    state VARCHAR(50) DEFAULT NULL,
    country_id CHAR(2),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

INSERT INTO locations
(address, postalcode, city, state, country_id)
VALUES
('MG Road', '395001', 'Surat', 'Gujarat', 'IN'),
('Main Street', '10001', 'New York', 'New York', 'US'),
('Oxford Road', 'OX1', 'Oxford', 'England', 'UK'),
('Lagos Island', '101001', 'Lagos', 'Lagos', 'NG'),
('George Street', '2000', 'Sydney', 'New South Wales', 'AU');

SELECT * FROM locations;


-- =========================================================
-- 4. WAREHOUSES
-- =========================================================

CREATE TABLE warehouses (
    warehouse_id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    warehousename VARCHAR(255) DEFAULT NULL,
    location_id INT(11),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

INSERT INTO warehouses
(warehousename, location_id)
VALUES
('India Warehouse', 1),
('USA Warehouse', 2),
('UK Warehouse', 3),
('Nigeria Warehouse', 4),
('Australia Warehouse', 5);

SELECT * FROM warehouses;


-- =========================================================
-- 5. EMPLOYEES
-- =========================================================

CREATE TABLE employees (
    employee_id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    hiredate DATE NOT NULL,
    manager_id INT(11) DEFAULT NULL,
    jobtitle VARCHAR(255) NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

INSERT INTO employees
(firstname, lastname, email, phone, hiredate, manager_id, jobtitle)
VALUES
('Rahul', 'Patel', 'rahul@gmail.com', '9876543210',
 '2024-01-10', NULL, 'Manager'),

('Amit', 'Shah', 'amit@gmail.com', '9876543211',
 '2024-02-15', 1, 'Salesman'),

('Priya', 'Desai', 'priya@gmail.com', '9876543212',
 '2024-03-20', 1, 'Salesman'),

('Neha', 'Mehta', 'neha@gmail.com', '9876543213',
 '2024-04-10', 1, 'Salesman'),

('Vikram', 'Joshi', 'vikram@gmail.com', '9876543214',
 '2024-05-05', 1, 'Salesman');

SELECT * FROM employees;


-- =========================================================
-- 6. PRODUCT_CATEGORIES
-- =========================================================

CREATE TABLE product_categories (
    category_id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    categoryname VARCHAR(255) NOT NULL
);

INSERT INTO product_categories (categoryname) VALUES
('Electronics'),
('Furniture'),
('Clothing'),
('Accessories'),
('Stationery');

SELECT * FROM product_categories;


-- =========================================================
-- 7. PRODUCTS
-- =========================================================

CREATE TABLE products (
    product_id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    productname VARCHAR(255) NOT NULL,
    description VARCHAR(2000) DEFAULT NULL,
    standardcost INT(11) DEFAULT NULL,
    listprice INT(11) DEFAULT NULL,
    category_id INT(11) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);

INSERT INTO products
(productname, description, standardcost, listprice, category_id)
VALUES
('Laptop', 'HP Laptop', 40000, 50000, 1),
('Chair', 'Office Chair', 2000, 3000, 2),
('T-Shirt', 'Cotton T-Shirt', 400, 700, 3),
('Headphones', 'Wireless Headphones', 1500, 2500, 4),
('Notebook', 'A4 Notebook', 100, 200, 5);

SELECT * FROM products;


-- =========================================================
-- 8. CUSTOMERS
-- =========================================================

CREATE TABLE customers (
    customer_id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) DEFAULT NULL,
    website VARCHAR(255) DEFAULT NULL,
    creditlimit INT(11) DEFAULT NULL
);

INSERT INTO customers
(name, address, website, creditlimit)
VALUES
('ABC Company', 'Surat, Gujarat', 'www.abc.com', 100000),
('XYZ Company', 'Ahmedabad, Gujarat', 'www.xyz.com', 150000),
('Tech Solutions', 'Mumbai, Maharashtra', 'www.tech.com', 200000),
('Global Traders', 'Delhi, India', 'www.globaltraders.com', 120000),
('Smart Enterprises', 'Pune, Maharashtra', 'www.smartenterprises.com', 180000);

SELECT * FROM customers;


-- =========================================================
-- 9. ORDERS
-- =========================================================

CREATE TABLE orders (
    order_id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    status VARCHAR(20) NOT NULL,
    customer_id INT(11) DEFAULT NULL,
    salesman_id INT(11) DEFAULT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES employees(employee_id)
);

INSERT INTO orders
(status, customer_id, salesman_id, order_date)
VALUES
('Pending', 1, 2, '2026-08-01'),
('Completed', 2, 3, '2026-08-05'),
('Pending', 3, 2, '2026-08-10'),
('Completed', 4, 4, '2026-08-12'),
('Pending', 5, 5, '2026-08-15');

SELECT * FROM orders;


-- =========================================================
-- 10. ORDER_ITEMS
-- =========================================================

CREATE TABLE order_items (
    order_id INT(11) NOT NULL,
    item_id INT(11) NOT NULL,
    product_id INT(11) NOT NULL,
    quantity INT(11) NOT NULL,
    unit_price INT(11) NOT NULL,

    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items
(order_id, item_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 2, 50000),
(1, 2, 2, 5, 3000),
(2, 1, 3, 10, 700),
(3, 1, 1, 1, 50000),
(4, 1, 4, 4, 2500),
(5, 1, 5, 20, 200);

SELECT * FROM order_items;


-- =========================================================
-- 11. INVENTORIES
-- =========================================================

CREATE TABLE inventories (
    product_id INT(11) NOT NULL,
    warehouse_id INT(11) NOT NULL,
    quantity INT(11) NOT NULL,

    PRIMARY KEY (product_id, warehouse_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

INSERT INTO inventories
(product_id, warehouse_id, quantity)
VALUES
(1, 1, 20),
(2, 1, 50),
(3, 1, 100),
(1, 2, 10),
(2, 3, 30),
(4, 4, 40),
(5, 5, 200);

SELECT * FROM inventories;
