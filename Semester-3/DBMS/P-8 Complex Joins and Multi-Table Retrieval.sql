/* P-8 Complex Joins and Multi-Table Retrieval
i. List every product name alongside its category name, sorted alphabetically by category.
ii. Display customer names and the total count of items they have ordered, highest volume first.
iii. Find the names of customers who placed orders delivered from the "New Jersey" warehouse.
iv. For every order, identify the single most expensive product and list it first.
v. List the total number of products sold by each warehouse located in India, ordered alphabetically by warehouse. */

USE Practical1;


-- =========================================================
-- Practical 8: Complex Joins and Multi-Table Retrieval
-- =========================================================


-- i. List every product name alongside its category name,
--    sorted alphabetically by category.

SELECT
    p.productname AS `Product Name`,
    pc.categoryname AS `Category Name`
FROM products p
INNER JOIN product_categories pc
    ON p.category_id = pc.category_id
ORDER BY pc.categoryname ASC;


-- =========================================================


-- ii. Display customer names and the total count of items
--     they have ordered, highest volume first.

SELECT
    c.name AS `Customer Name`,
    SUM(oi.quantity) AS `Total Items Ordered`
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.name
ORDER BY `Total Items Ordered` DESC;


-- =========================================================


-- iii. Find names of customers who placed orders delivered
--      from the "New Jersey" warehouse.

SELECT DISTINCT
    c.name AS `Customer Name`
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN inventories i
    ON oi.product_id = i.product_id
INNER JOIN warehouses w
    ON i.warehouse_id = w.warehouse_id
INNER JOIN locations l
    ON w.location_id = l.location_id
WHERE l.city = 'New Jersey';


-- =========================================================


-- iv. For every order, identify the single most expensive
--     product and list it first.

SELECT
    oi.order_id AS `Order ID`,
    p.productname AS `Product Name`,
    p.listprice AS `Price`
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
WHERE p.listprice = (
    SELECT MAX(p2.listprice)
    FROM order_items oi2
    INNER JOIN products p2
        ON oi2.product_id = p2.product_id
    WHERE oi2.order_id = oi.order_id
)
ORDER BY oi.order_id ASC;


-- =========================================================


-- v. List the total number of products sold by each
--    warehouse located in India, ordered alphabetically
--    by warehouse.

SELECT
    w.warehousename AS `Warehouse`,
    SUM(oi.quantity) AS `Total Products Sold`
FROM warehouses w
INNER JOIN inventories i
    ON w.warehouse_id = i.warehouse_id
INNER JOIN order_items oi
    ON i.product_id = oi.product_id
WHERE w.warehousename LIKE '%India%'
GROUP BY w.warehouse_id, w.warehousename
ORDER BY w.warehousename ASC;


-- =========================================================
-- End of Practical 8
-- =========================================================
