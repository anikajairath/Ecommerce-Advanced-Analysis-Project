-- Create Revenue column
SET SQL_SAFE_UPDATES = 0;

UPDATE orders
SET revenue = price * quantity * (1 - (discount / 100.0));

SET SQL_SAFE_UPDATES = 1;

-- Top Customers
SELECT Customer_ID, SUM(Revenue) FROM orders GROUP BY Customer_ID ORDER BY SUM(Revenue) DESC;

-- Repeat Customers
SELECT Customer_ID, COUNT(Customer_ID) FROM orders GROUP BY Customer_Id HAVING COUNT(order_id) > 1;

-- Revenue by City
SELECT c.City, SUM(o.Revenue) FROM orders o JOIN customers c ON o.Customer_ID = c.Customer_ID GROUP BY c.City;

-- Revenue by Category
SELECT p.Category, SUM(o.Revenue) FROM orders o JOIN products p ON o.Product_ID = p.Product_ID GROUP BY p.Category ORDER BY SUM(o.Revenue) DESC;

-- Top Sub Categories by Revenue
SELECT p.Sub_Category, SUM(o.Revenue) FROM products p JOIN orders o ON p.Product_ID = o.Product_ID GROUP BY p.Sub_Category ORDER BY SUM(o.Revenue) DESC;

-- High Value Orders
SELECT * FROM orders WHERE Revenue > (SELECT AVG(Revenue) FROM orders);

