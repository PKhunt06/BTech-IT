/* P-4 Data Manipulation and Basic Retrieval (DML & DQL)
i. Retrieve and display all columns and rows from the products table.
ii. Generate a list of unique (distinct) job titles held by employees.
iii. Display the city and postalcode for all entries in the locations table. */


-- =========================================================
-- P-4 DATA MANIPULATION AND BASIC RETRIEVAL (DML & DQL)
-- =========================================================

USE Practical1;

-- 1. Retrieve all columns and rows from products
SELECT *
FROM products;

-- 2. Display unique job titles held by employees
SELECT DISTINCT jobtitle
FROM employees;

-- 3. Display city and postalcode from locations
SELECT city, postalcode
FROM locations;
