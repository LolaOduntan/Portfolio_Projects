
-- Exploring and cleaning the data in the databases
USE sql_hr;

SELECT *
FROM sql_hr.employees;

-- To determine if there is employee id with two individuals
SELECT employee_id, COUNT(employee_id)
FROM sql_hr.employees
GROUP BY employee_id;

-- To determine number of staff occupying a job title
SELECT job_title, COUNT(job_title)
FROM sql_hr.employees
GROUP BY job_title;

-- To dertermine how many of each position is in the different branches 
USE sql_hr;

SELECT
job_title,
office_id,
COUNT(job_title)
FROM employees
GROUP BY  job_title, office_id;

-- To check for everyone's manager
SELECT
e.employee_id,
e.first_name,
e.job_title,
m.first_name AS manager
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id;

-- EXPLORING SQL_HR.OFFICES
USE sql_hr;

SELECT  *
FROM sql_hr.offices;

-- To determine how many branches is in each city
SELECT city, COUNT(city)
FROM sql_hr.offices
GROUP BY city;

-- To determine number of offices/branches the company has
SELECT COUNT(office_id)
FROM sql_hr.offices;

-- EXPLORING sql_inventory.products
USE sql_inventory;

SELECT *
FROM products;

-- EXPLORING sql_invoicing
USE sql_invoicing;

SELECT * 
FROM clients;

RENAME TABLE clients 
TO suppliers;

ALTER TABLE suppliers
RENAME COLUMN client_id TO suppliers_id;

ALTER TABLE suppliers
RENAME COLUMN name TO suppliers_name;

SELECT * 
FROM invoices;

ALTER TABLE invoices
RENAME COLUMN client_id TO suppliers_id;

SELECT * 
FROM payment_methods;

SELECT * 
FROM payments;

-- EXPLORING sql_store
USE sql_store;

SELECT * 
FROM customers;

SELECT * 
FROM order_item_notes;

SELECT * 
FROM order_items;

SELECT *, quantity * unit_price AS total
FROM order_items;

SELECT * 
FROM order_statuses;

SELECT * 
FROM orders;

SELECT * 
FROM products;

ALTER TABLE products
RENAME COLUMN  name TO product_name;

SELECT * 
FROM shippers;

ALTER TABLE shippers
RENAME COLUMN  name TO shipper_name
