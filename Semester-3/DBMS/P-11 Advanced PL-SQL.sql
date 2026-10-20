/* P-11 Advanced PL/SQL (Cursors, Procedures, and Triggers)
i. Create a Cursor to iterate through and display employees hired in a specific year.
ii. Develop a Stored Procedure that accepts a customer_id and returns their total order value.
iii. Design a Database Trigger that logs an entry every time a new product is added. */


USE Practical1;

-- =========================================================
-- Practical 11: Advanced PL/SQL
-- (Cursors, Procedures, and Triggers)
-- =========================================================


-- i. Create a Cursor to iterate through and display
--    employees hired in a specific year.

DROP PROCEDURE IF EXISTS employee_cursor;

DELIMITER $$

CREATE PROCEDURE employee_cursor(IN hire_year INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(255);

    DECLARE emp_cursor CURSOR FOR
        SELECT employee_id,
               CONCAT(firstname, ' ', lastname)
        FROM employees
        WHERE YEAR(hiredate) = hire_year;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    DROP TEMPORARY TABLE IF EXISTS temp_employees;

    CREATE TEMPORARY TABLE temp_employees (
        employee_id INT,
        employee_name VARCHAR(255)
    );

    OPEN emp_cursor;

    read_loop: LOOP

        FETCH emp_cursor INTO emp_id, emp_name;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        INSERT INTO temp_employees
        VALUES (emp_id, emp_name);

    END LOOP;

    CLOSE emp_cursor;

    SELECT * FROM temp_employees;

    DROP TEMPORARY TABLE temp_employees;
END $$

DELIMITER ;

-- Execute the procedure.
CALL employee_cursor(2020);


-- =========================================================


-- ii. Develop a Stored Procedure that accepts a
--     customer_id and returns their total order value.

DROP PROCEDURE IF EXISTS customer_order_total;

DELIMITER $$

CREATE PROCEDURE customer_order_total(IN cust_id INT)
BEGIN
    SELECT
        c.customer_id AS `Customer ID`,
        c.name AS `Customer Name`,
        COALESCE(SUM(oi.quantity * p.listprice), 0)
            AS `Total Order Value`
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    LEFT JOIN products p
        ON oi.product_id = p.product_id
    WHERE c.customer_id = cust_id
    GROUP BY c.customer_id, c.name;
END $$

DELIMITER ;

-- Execute the procedure.
CALL customer_order_total(1);


-- =========================================================


-- iii. Design a Database Trigger that logs an entry
--      every time a new product is added.

-- Create a table to store product insertion logs.

CREATE TABLE IF NOT EXISTS product_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    productname VARCHAR(255),
    log_date DATETIME
);

-- Remove the existing trigger if present.

DROP TRIGGER IF EXISTS after_product_insert;

DELIMITER $$

CREATE TRIGGER after_product_insert
AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO product_log
        (product_id, productname, log_date)
    VALUES
        (NEW.product_id, NEW.productname, NOW());
END $$

DELIMITER ;

-- Insert a new product to test the trigger.

INSERT INTO products
    (productname, description, standardcost, listprice, category_id)
VALUES
    ('Test Product', 'Trigger Testing', 500, 700, 1);

-- Display the product insertion logs.

SELECT * FROM product_log;


-- =========================================================
-- End of Practical 11
-- =========================================================
