/* Advanced Filtering and Pattern Matching
i. List all employees whose last name contains the substring "ada".
ii. Find employees whose last names start with "Jan" or end with the letters "na".
iii. Search for employees with a 5-letter last name starting with "D" and having "a" as the third character.
iv. Display customer names with a remark "high" if their credit limit is > 2500, else "low".
v. Retrieve exactly the first 10 rows and then specifically the 4th row from the products table. */

-- =========================================================
-- P-5 ADVANCED FILTERING AND PATTERN MATCHING
-- =========================================================

USE Practical1;


-- =========================================================
-- 1. List all employees whose last name
--    contains the substring "ada"
-- =========================================================

SELECT *
FROM employees
WHERE lastname LIKE '%ada%';


-- =========================================================
-- 2. Find employees whose last names
--    start with "Jan" OR end with "na"
-- =========================================================

SELECT *
FROM employees
WHERE lastname LIKE 'Jan%'
   OR lastname LIKE '%na';


-- =========================================================
-- 3. Find employees with a 5-letter last name
--    starting with "D" and having "a"
--    as the third character
-- =========================================================

SELECT *
FROM employees
WHERE lastname LIKE 'D_a__';


-- =========================================================
-- 4. Display customer names with a remark
--    "high" if credit limit > 2500
--    otherwise "low"
-- =========================================================

SELECT
    name,
    CASE
        WHEN creditlimit > 2500 THEN 'high'
        ELSE 'low'
    END AS remark
FROM customers;


-- =========================================================
-- 5A. Retrieve exactly the first 10 rows
--     from the products table
-- =========================================================

SELECT *
FROM products
LIMIT 10;


-- =========================================================
-- 5B. Retrieve specifically the 4th row
--     from the products table
-- =========================================================

SELECT *
FROM products
LIMIT 3, 1;
