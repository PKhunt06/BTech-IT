/* P-3 practical 3 Schema Evolution and Maintenance 
i. Add a salary column to employee_m with an integer data type and a NOT NULL constraint. 
ii. Modify the salary column to support decimal values using the float(8,2) type. 
iii. Rename the salary column to salary_e and change its type back to integer. 
iv. Add a date_of_joining column specifically positioned after the full_name column. 
v. Perform structural cleanup by dropping the date_of_joining column and renaming the table to employee_r 
vi. Remove the Primary Key constraint and then truncate all data from the employee_r table.  */


-- =========================================================
-- P-3 SCHEMA EVOLUTION AND MAINTENANCE
-- =========================================================

USE Practical1;


-- =========================================================
-- PREPARATION
-- Recreate employee_m for a fresh execution of P-3
-- =========================================================

DROP TABLE IF EXISTS employee_r;
DROP TABLE IF EXISTS employee_m;

CREATE TABLE employee_m AS
SELECT
    employee_id,
    CONCAT(firstname, ' ', lastname) AS full_name
FROM employees;

ALTER TABLE employee_m
MODIFY full_name VARCHAR(511) NOT NULL;

ALTER TABLE employee_m
ADD PRIMARY KEY (employee_id);

SELECT * FROM employee_m;


-- =========================================================
-- 1. Add salary column with INTEGER and NOT NULL
-- =========================================================

ALTER TABLE employee_m
ADD salary INT NOT NULL;

SELECT * FROM employee_m;


-- =========================================================
-- 2. Modify salary to FLOAT(8,2)
-- =========================================================

ALTER TABLE employee_m
MODIFY salary FLOAT(8,2) NOT NULL;

SELECT * FROM employee_m;


-- =========================================================
-- 3. Rename salary to salary_e
--    and change datatype back to INTEGER
-- =========================================================

ALTER TABLE employee_m
CHANGE salary salary_e INT NOT NULL;

SELECT * FROM employee_m;


-- =========================================================
-- 4. Add date_of_joining after full_name
-- =========================================================

ALTER TABLE employee_m
ADD date_of_joining DATE AFTER full_name;

SELECT * FROM employee_m;


-- =========================================================
-- 5. Drop date_of_joining
--    and rename table employee_m to employee_r
-- =========================================================

ALTER TABLE employee_m
DROP COLUMN date_of_joining;

ALTER TABLE employee_m
RENAME TO employee_r;

SELECT * FROM employee_r;


-- =========================================================
-- 6. Remove Primary Key
--    and truncate all data
-- =========================================================

ALTER TABLE employee_r
DROP PRIMARY KEY;

TRUNCATE TABLE employee_r;

SELECT * FROM employee_r;
