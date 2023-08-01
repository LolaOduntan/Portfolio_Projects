-- Database Manipulation to update, fetch information or discover insights

-- 1a) To give a customer extra 500 points as compensation 
UPDATE sql_store.customers
SET points = points +500
WHERE first_name = 'Romola' AND last_name = 'Rumgay';

-- 1b) To find most loyal customers based on points 
SELECT 
customer_id,
first_name, 
last_name, 
points
FROM customers
ORDER BY points DESC;

-- 1c) To allocate loyalty member group/name based on point
SELECT 
customer_id, 
first_name, 
last_name,
points,
'Bronze' AS loyalty_member_group
FROM customers
WHERE points < 2000
UNION
SELECT 
customer_id, 
first_name, 
last_name,
points,
'Silver' AS loyalty_member_group
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT 
customer_id, 
first_name, 
last_name,
points,
'Gold' AS loyalty_member_group
FROM customers
WHERE points > 3000
ORDER BY customer_id;

-- 2a) To observe the range of bith years of customers
SELECT DISTINCT birth_date
FROM customers;

-- 2b) To group customers based on birthdate/age
SELECT first_name, last_name, birth_date,
CASE
    WHEN birth_date < '1990-01-01' THEN 'Elderly'
    WHEN birth_date BETWEEN '1991-01-01' AND '1999-12-31' THEN 'Adult'
    WHEN birth_date BETWEEN '2000-01-01' AND '2005-12-31' THEN ' Young Adult'
	ELSE 'Minor'
END AS age_group
FROM sql_store.customers
WHERE birth_date is NOT NULL
ORDER BY birth_date;

-- 2c) To find customers who have birthday today as requested by PR team 
SELECT first_name, last_name, birth_date, phone
FROM sql_store.customers
WHERE birth_date LIKE '%-11-07';

-- 2d) To find customers and their adresses who live in a particular area
SELECT *
FROM sql_store.customers
WHERE address LIKE '%DRIVE%' OR 
	  address LIKE '%LAWN%';
      
-- 2e) TO get customers who do not have phonenumbers registered
SELECT * 
FROM customers
WHERE phone IS NULL;

-- 3a) To get orders placed in a particular year
SELECT *
FROM sql_store.orders
WHERE order_date LIKE '2017-%-%'
ORDER BY order_date;

-- 3b) To get orders placed in a particular month
SELECT *
FROM sql_store.orders
WHERE order_date BETWEEN '2018-04-01' AND '2018-04-30'
ORDER BY order_date;

-- 3c) To find a particular order with a given order id and total amount
SELECT *, 
quantity * unit_price AS Total_price
FROM order_items
WHERE order_id = 2 AND quantity * unit_price >5
ORDER BY  total_price DESC;

-- 3d) To get customers whose orders are not registered yet
SELECT c.customer_id,
c.first_name,
o.order_id
FROM customers c
LEFT OUTER JOIN  orders o
	ON c.customer_id = o.customer_id
    ORDER BY c.customer_id;
      
-- 4a) If the product price is to be increased by 15%
SELECT 
product_name, 
unit_price, 
unit_price * 1.15 AS New_price
FROM sql_store.products;

-- 4b) To determine products that have high quantities still available/in stock
SELECT *
FROM products
WHERE quantity_in_stock > 50
ORDER BY quantity_in_stock;

-- 4c) To determine top 10 selling products
SELECT 
p.product_name,
COUNT(product_name)
FROM products p
JOIN order_items oi
	ON p.product_id = oi.product_id
GROUP BY product_name
ORDER BY COUNT(product_name) DESC
LIMIT 10;

-- 4d) To identify products by name and price at the time of order 
SELECT 
oi.order_id, 
oi.product_id, 
p.product_name, 
oi.quantity,
oi.unit_price
FROM order_items oi
INNER JOIN products p
	ON oi.product_id = p.product_id;
    
-- 5a) To identify orders that have not been shipped/ with missing shipped date
SELECT * 
FROM orders
WHERE shipped_date IS NULL;

-- 5b) To identify the customers, their orders and respective shippers
SELECT 
c.customer_id,
c.first_name,
o.order_id,
sh.shipper_name AS Shipper
FROM customers c
LEFT JOIN  orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;

-- 5c) To identify customers, orders and the status of their orders
SELECT o.order_id,
o.order_date,
c.first_name,
c.last_name,
os.name AS Status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
 -- 5d) To determine the status of orders while viewing order data and shipper
SELECT
o.order_id,
o.order_date,
c.first_name,
sh.shipper_name,
os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
-- 5e) To identify the most used shipper/logistics company
SELECT 
s.shipper_name,
COUNT(o.shipper_id)
FROM shippers s
LEFT JOIN orders o
	ON s.shipper_id = o.shipper_id
GROUP BY shipper_name
ORDER BY COUNT(o.shipper_id) DESC

