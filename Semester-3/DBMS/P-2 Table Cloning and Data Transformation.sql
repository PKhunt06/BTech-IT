/* P-2 Table Cloning and Data Transformation 
i. Create warehouse1 from the warehouses table without copying any existing data. 
ii. Create a full replica of the warehouses table, including all existing records. 
iii. Create table employee_m from employee using select clause having selected number of columns as employee_id, full_name. 
full_name column will be merging of first name and last name in columns. Apply constraint to last_column as NOT NULL.  */


USE Practical1;

-- =========================================================
-- P-2 TABLE CLONING AND DATA TRANSFORMATION
-- =========================================================


-- =========================================================
-- 1. Create warehouse1 from warehouses
--    WITHOUT copying existing data
-- =========================================================

CREATE TABLE warehouse1 AS
SELECT *
FROM warehouses
WHERE 1 = 0;

SELECT * FROM warehouse1;


-- =========================================================
-- 2. Create a full replica of warehouses table
--    INCLUDING all existing records
-- =========================================================

CREATE TABLE warehouse2 AS
SELECT *
FROM warehouses;

SELECT * FROM warehouse2;


-- =========================================================
-- 3. Create employee_m with employee_id and full_name
--    full_name = firstname + lastname
-- =========================================================

CREATE TABLE employee_m AS
SELECT
    employee_id,
    CONCAT(firstname, ' ', lastname) AS full_name
FROM employees;

-- Apply NOT NULL constraint to full_name
ALTER TABLE employee_m
MODIFY full_name VARCHAR(511) NOT NULL;

SELECT * FROM employee_m;
