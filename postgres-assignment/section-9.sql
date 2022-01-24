SECTION 9

--how many customer do we have in each country

SELECT country ,COUNT(*)
FROM customers
GROUP BY country
ORDER BY COUNT(*) DESC;

--what is the number of products for each category

SELECT categoryname ,COUNT(*)
FROM categories
JOIN products ON products.categoryid=categories.categoryid
GROUP BY categoryname
ORDER BY COUNT(*) DESC;

--what is the avg number of items ordered for product ordered by the avg amount

SELECT productname , AVG(quantity)
FROM products
JOIN order_details ON products.productid=order_details.productid
GROUP BY productname
ORDER BY AVG(quantity) DESC;



--how many suppliers in each country

SELECT country ,COUNT(*)
FROM suppliers
GROUP BY country
ORDER BY COUNT(*) DESC;

--total value of each product sold for year of 1997

SELECT productname ,SUM(order_details.unitprice*quantity)
FROM products
JOIN order_details ON products.productid=order_details.productid
JOIN orders ON orders.orderid=order_details.orderid
WHERE orderdate BETWEEN '1997-01-01' AND '1997-12-31'
GROUP BY productname
ORDER BY SUM(order_details.unitprice*quantity) DESC;

--having

--find products less than 200

SELECT productname ,SUM(quantity*order_details.unitprice) AS AmountBought
FROM products
JOIN order_details USING (productid)
GROUP BY productname
HAVING SUM(quantity*order_details.unitprice)<2000
ORDER BY AmountBought DESC;

--find customers have brought more than 5000 products

SELECT companyname ,SUM(quantity*order_details.unitprice )AS Amountbought
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details
GROUP BY companyname
HAVING SUM(quantity*order_details.unitprice ) >5000

--find customers have brought more than 5000 products WITH ORDER DATE IN first six month of the year 1997

SELECT companyname ,SUM(quantity*order_details.unitprice )AS Amountbought
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details
WHERE orderdate BETWEEN '1997-01-01' AND '1997-06-30'
GROUP BY companyname
HAVING SUM(quantity*order_details.unitprice ) >5000

--gouping set

--total sales grouped by product and category
SELECT categoryname ,productname , SUM(od.unitprice*quantity)
FROM categories
NATURAL JOIN products
NATURAL JOIN order_details as od
GROUP BY GROUPING SETS ((categoryname),(categoryname,productname ))

--find total sales by both customer companyname renamed as buyerand suppliers company name 
--renamed as suppliers and order by buyer and supplier

SELECT c.companyname AS buyer,s.companyname AS supplier ,SUM (od.unitprice*quantity)
FROM customers AS C
NATURAL JOIN orders
NATURAL JOIN order_details as od
JOIN products USING (productid)
JOIN suppliers AS s USING (supplierid)
GROUP BY GROUPING SETS ((buyer),(buyer,supplier))

--find total sales grouped y customer companyname and categoryname order by company name categoryname with null first

SELECT companyname ,categoryname ,SUM(od.unitprice*quantity)
FROM customers AS c
NATURAL JOIN orders
NATURAL JOIN order_details AS od
JOIN products USING(productid)
JOIN categories AS s using (categoryid)
GROUP BY GROUPING SETS ((companyname),(companyname,categoryname))
ORDER BY companyname ,categoryname NULLS FIRST;

--do rollup with customer category and products
SELECT c.companyname ,categoryname,productname,SUM(od.unitprice*quantity)
FROM customers AS c
NATURAL JOIN orders
NATURAL JOIN order_details AS od
JOIN products USING(productid)
JOIN categories USING (categoryid)
GROUP BY ROLLUP (companyname,categoryname,productname);

--do a rollup with suppliers, products and customers

SELECT s.companyname AS supplier,c.companyname AS buyers ,productname,SUm(od.unitprice*quantity)
FROM suppliers AS s
JOIN products USING (supplierid)
JOIN order_details AS USING (productid)
JOIN orders USING (orderid)
JOIN customers AS c USING (customerid)
GROUP BY ROLLUP (supplier,buyer,producname)
ORDER BY supplier,buyer,productname

--cubes

SELECT companyname,categoryname,productname,SUM(od.unitprice*quantity)
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details as od
JOIN products USING(productid)
JOIN categories USING (categoryid)
GROUP BY CUBE (companyname,categoryname,productname)

SELECT s.companyname AS supplier,c.companyname as buyer, productname,SUM(od.unitprice*quantity)
FROM suppliers AS s
JOIN products USING (supplierid)
JOIN order_details AS od USING (productid)
JOIN orders USING (orderid)
JOIN customers  AS c USING (customerid)
GROUP BY CUBE (supplier,buyer,productname)
ORDER BY supplier NULLS FIRST ,buyer NULLS FIRST,productname NULLS FIRST;