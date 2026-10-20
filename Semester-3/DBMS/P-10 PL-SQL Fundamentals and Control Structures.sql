/* P-10 PL/SQL Fundamentals and Control Structures
i. Write a basic PL/SQL block to insert a new category into the product_categories table.
ii. Create a block using IF-THEN-ELSE to update a product's price based on its current value.
iii. Implement a loop that prints the names of the top 5 customers by credit limit. */


USE Practical1;

-- =========================================================
-- Practical 10: PL/SQL Fundamentals and Control Structures
-- =========================================================


-- i. Write a basic block to insert a new category
--    into the product_categories table.

DROP PROCEDURE IF EXISTS insert_category;

DELIMITER $$

CREATE PROCEDURE insert_category()
BEGIN
    INSERT INTO product_categories (categoryname)
    VALUES ('New Category');
END $$

DELIMITER ;

CALL insert_category();

SELECT * FROM product_categories;


-- =========================================================


-- ii. Create a block using IF-THEN-ELSE to update
--     a product's price based on its current value.

DROP PROCEDURE IF EXISTS update_product_price;

DELIMITER $$

CREATE PROCEDURE update_product_price()
BEGIN
    DECLARE current_price DECIMAL(10,2);

    SELECT listprice INTO current_price
    FROM products
    WHERE product_id = 1;

    IF current_price < 1000 THEN
        UPDATE products
        SET listprice = listprice + 100
        WHERE product_id = 1;
    ELSE
        UPDATE products
        SET listprice = listprice + 200
        WHERE product_id = 1;
    END IF;
END $$

DELIMITER ;

CALL update_product_price();

SELECT product_id, productname, listprice
FROM products
WHERE product_id = 1;


-- =========================================================


-- iii. Implement a loop that prints the names of
--      the top 5 customers by credit limit.

DROP PROCEDURE IF EXISTS top_five_customers;

DELIMITER $$

CREATE PROCEDURE top_five_customers()
BEGIN
    DECLARE counter INT DEFAULT 0;

    CREATE TEMPORARY TABLE IF NOT EXISTS temp_customers (
        customer_name VARCHAR(255),
        credit_limit DECIMAL(10,2)
    );

    TRUNCATE TABLE temp_customers;

    customer_loop: LOOP

        IF counter >= 5 THEN
            LEAVE customer_loop;
        END IF;

        INSERT INTO temp_customers (customer_name, credit_limit)
        SELECT name, creditlimit
        FROM customers
        ORDER BY creditlimit DESC, customer_id ASC
        LIMIT counter, 1;

        SET counter = counter + 1;

    END LOOP customer_loop;

    SELECT * FROM temp_customers
    ORDER BY credit_limit DESC;

    DROP TEMPORARY TABLE temp_customers;
END $$

DELIMITER ;

CALL top_five_customers();


-- =========================================================
-- End of Practical 10
-- =========================================================
