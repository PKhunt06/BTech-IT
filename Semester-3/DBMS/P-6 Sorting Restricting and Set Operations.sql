/* P-6 Sorting, Restricting, and Set Operations (DRL)
i. Display all employee details sorted chronologically by their hiredate.
ii. Sort the products table in descending order of listprice and then by category.
iii. List countries belonging specifically to Africa, Asia, or America, arranged in that exact
regional order.
iv. Display name of products belongs to category 3, 1, 5 as per following.
v. 3 P1, P2, P3
1 P7, P9
5 P5, P6
vi. List out products with minimum price from each category. */


-- =========================================================
-- P-6 SORTING, RESTRICTING, AND SET OPERATIONS (DRL)
-- =========================================================

USE Practical1;


-- =========================================================
-- i. Display all employee details sorted
--    chronologically by their hiredate
-- =========================================================

SELECT *
FROM employees
ORDER BY hiredate ASC;


-- =========================================================
-- ii. Sort products in descending order of listprice
--     and then by category
-- =========================================================

SELECT *
FROM products
ORDER BY listprice DESC, category_id ASC;


-- =========================================================
-- iii. List countries belonging to Africa, Asia,
--      or America in that regional order
-- =========================================================

SELECT *
FROM countries
WHERE region_id IN (1, 2, 3)
ORDER BY FIELD(region_id, 1, 2, 3);


-- =========================================================
-- iv. Display product names belonging to categories
--     3, 1, and 5 in the specified order
-- =========================================================

SELECT product_id, productname, category_id
FROM products
WHERE category_id IN (3, 1, 5)
ORDER BY FIELD(category_id, 3, 1, 5);


-- =========================================================
-- v. Display products in the following order:
--
--     Category 3 -> P1, P2, P3
--     Category 1 -> P7, P9
--     Category 5 -> P5, P6
-- =========================================================

SELECT product_id, productname, category_id
FROM products
WHERE product_id IN (1, 2, 3, 7, 9, 5, 6)
ORDER BY FIELD(category_id, 3, 1, 5),
         FIELD(product_id, 1, 2, 3, 7, 9, 5, 6);


-- =========================================================
-- vi. List products with minimum price from each category
-- =========================================================

SELECT category_id, MIN(listprice) AS minimum_price
FROM products
GROUP BY category_id;
