/* P-7 Scalar and Aggregate Functions
i. Display the current system date with the column label "Date".
ii. Calculate a 15% price increase for all products and display it as a whole number labeled "New Price".
iii. Display capitalized names and their lengths for employees whose names start with J, A, or M.
iv. Calculate the total years of employment for each employee based on their join date.
v. Count the total number of employees for each unique job title. */

-- =========================================================
-- P-7 SCALAR AND AGGREGATE FUNCTIONS
-- =========================================================

USE Practical1;


-- =========================================================
-- i. Display the current system date
--    with column label "Date"
-- =========================================================

SELECT CURDATE() AS `Date`;


-- =========================================================
-- ii. Calculate a 15% price increase for all products
--     and display it as a whole number labeled "New Price"
-- =========================================================

SELECT
    productname,
    listprice,
    ROUND(listprice * 1.15) AS `New Price`
FROM products;


-- =========================================================
-- iii. Display capitalized names and their lengths
--      for employees whose names start with J, A, or M
-- =========================================================

SELECT
    UPPER(CONCAT(firstname, ' ', lastname)) AS `Name`,
    LENGTH(CONCAT(firstname, ' ', lastname)) AS `Length`
FROM employees
WHERE firstname LIKE 'J%'
   OR firstname LIKE 'A%'
   OR firstname LIKE 'M%';


-- =========================================================
-- iv. Calculate the total years of employment
--     for each employee based on their hire date
-- =========================================================

SELECT
    employee_id,
    CONCAT(firstname, ' ', lastname) AS `Name`,
    TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) AS `Years of Employment`
FROM employees;


-- =========================================================
-- v. Count the total number of employees
--    for each unique job title
-- =========================================================

SELECT
    jobtitle,
    COUNT(*) AS `Total Employees`
FROM employees
GROUP BY jobtitle;
