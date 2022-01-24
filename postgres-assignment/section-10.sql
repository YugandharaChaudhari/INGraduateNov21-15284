--SECTION 10

--union

--get list of all customers and suppliers company

SELECT companyname 
FROM customers
UNION
SELECT companyname
FROM suppliers;

--find all cities of all our customers and suppliers with one record for each compnies city 

SELECT city
FROM customers
UNION ALL
SELECT city
FROM suppliers;

--distinct contries of all our customers and suppliers in alphabetic order

SELECT country
FROM customers
UNION
SELECT country
FROM suppliers
ORDER BY country ASC;

--all countries of our suppliers and customers with records for each one

SELECT country
FROM customers
UNION
SELECT country
FROM suppliers

--intersect

--find all countries which are both in customers and in suppliers

SELECT country FROM customers
INTERSECT
SELECT country FROM suppliers

--find the number of customers and suppliers pairs that are in same country
SELECT COUNT(*)FROM
(SELECT country FROM customers
 INTERSECT ALL
SELECT country FROM suppliers)
AS together

--distinct cities that we have a supplier and customer located

SELECT city
FROM suppliers
INTERSECT
SELECT city 
FROM customers

--count the number of customers and suppliers pairs that are in the same city 
SELECT COUNT(*)FROM(
SELECT city FROM customers
INTERSECT ALL
SELECT city FROM suppliers
)AS together

--EXCEPT

--find al countries that we customers in but no suppliers

SELECT country FROM customers
EXCEPT
SELECT country FROM suppliers

--find the number that are in a country without suppliers
SELECT COUNT(*)FROM(
SELECT country from customers
EXCEPT ALL
SELECT country FROM suppliers) AS lonely_customers

--cities we have a suppliuer with no customer

SELECT city FROM suppliers
EXCEPT
SELECT city FROM customers

--how many customers do we have in cities without suppliers
SELECT COUNT(*)FROM
(SELECT city FROM customers
EXCEPT ALL
SELECT city FROM suppliers)AS lonely_customers