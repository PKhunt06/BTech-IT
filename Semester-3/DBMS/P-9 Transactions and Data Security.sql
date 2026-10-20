/* P-9 Transactions and Data Security
i. Perform a series of DML updates and use COMMIT to make them permanent.
ii. Demonstrate the ROLLBACK command by reverting an accidental data deletion.
iii. Create a database View that only shows product names and prices to restrict sensitive cost data.
iv. Test the security of a view by attempting to drop it after creation.
v. Identify the minimum product price within each category to support low-cost analysis. */


USE Practical1;

-- =========================================================
-- Practical 9: Transactions and Data Security
-- =========================================================


-- i. Perform a series of DML updates and use COMMIT
--    to make them permanent.

START TRANSACTION;

UPDATE products
SET listprice = listprice + 100
WHERE product_id = 1;

UPDATE products
SET listprice = listprice + 200
WHERE product_id = 2;

COMMIT;

SELECT product_id, productname, listprice
FROM products
WHERE product_id IN (1, 2);


-- =========================================================


-- ii. Demonstrate the ROLLBACK command by reverting
--     an accidental data deletion.

-- Insert a temporary product for testing.

INSERT INTO products
    (productname, description, standardcost, listprice, category_id)
VALUES
    ('Rollback Test Product', 'Temporary product', 100, 150, 1);

-- Start the transaction.

START TRANSACTION;

-- Accidentally delete the temporary product.

DELETE FROM products
WHERE productname = 'Rollback Test Product';

-- Check the deleted record.

SELECT * FROM products
WHERE productname = 'Rollback Test Product';

-- Undo the deletion.

ROLLBACK;

-- Verify that the deleted product is restored.

SELECT * FROM products
WHERE productname = 'Rollback Test Product';


-- =========================================================


-- iii. Create a database View that only shows product
--      names and prices to restrict sensitive cost data.

CREATE OR REPLACE VIEW product_price_view AS
SELECT
    productname,
    listprice
FROM products;

SELECT * FROM product_price_view;


-- =========================================================


-- iv. Test the security of a view by attempting
--     to drop it after creation.

DROP VIEW product_price_view;

-- Check the remaining views.

SHOW FULL TABLES
WHERE Table_type = 'VIEW';


-- =========================================================


-- v. Identify the minimum product price within each
--    category to support low-cost analysis.

SELECT
    category_id,
    MIN(listprice) AS `Minimum Price`
FROM products
GROUP BY category_id
ORDER BY category_id ASC;


-- =========================================================
-- End of Practical 9
-- =========================================================
