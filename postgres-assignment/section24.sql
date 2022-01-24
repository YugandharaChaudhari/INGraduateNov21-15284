CREATE  OR REPLACE FUNCTION fix_homepage() RETURNS void AS $$
	UPDATE suppliers
	SET homepage='N/A'
	WHERE homepage IS NULL;
$$ LANGUAGE SQL;

SELECT fix_homepage();

CREATE OR REPLACE FUNCTION set_employee_default_photo() RETURNS void AS $$
	UPDATE employees
	SET photopath='http://accweb/emmployees/default.bmp'
	WHERE photopath IS NULL;
$$ LANGUAGE SQL;

SELECT set_employee_default_photo();



--92
CREATE OR REPLACE FUNCTION max_price() RETURNS real AS $$
	SELECT MAX(unitprice)
	FROM products;
$$ LANGUAGE SQL;

SELECT max_price();

CREATE OR REPLACE FUNCTION biggest_order() RETURNS double precision AS $$

	SELECT MAX(amount)
	FROM
	(SELECT SUM(unitprice*quantity) as amount,orderid
	FROM order_details
	GROUP BY orderid) as totals;

$$ LANGUAGE SQL;

SELECT biggest_order();

--93
CREATE OR REPLACE FUNCTION customer_largest_order(cid bpchar) RETURNS double precision AS $$
	SELECT MAX(order_total) FROM
	(SELECT SUM(quantity*unitprice) as order_total,orderid
	FROM order_details
	NATURAL JOIN orders
	WHERE customerid=cid
	GROUP BY orderid) as order_total;
$$ LANGUAGE SQL;

SELECT customer_largest_order('ANATR');

CREATE OR REPLACE FUNCTION most_ordered_product(customerid bpchar) RETURNS varchar(40) AS $$
	SELECT productname
	FROM products
	WHERE productid IN
	(SELECT productid FROM
	(SELECT SUM(quantity) as total_ordered, productid
	FROM order_details
	NATURAL JOIN orders
	WHERE customerid= $1
	GROUP BY productid
	ORDER BY total_ordered DESC
	LIMIT 1) as ordered_products);
$$ LANGUAGE SQL;

SELECT most_ordered_product('CACTU');

--94
CREATE OR REPLACE FUNCTION new_price(products, increase_percent numeric)
RETURNS double precision AS $$
	SELECT $1.unitprice * increase_percent/100
$$ LANGUAGE SQL

SELECT productname,unitprice,new_price(products.*,110)
FROM products;

CREATE OR REPLACE FUNCTION full_name(employees) RETURNS varchar(62) AS $$
	SELECT $1.title || ' ' || $1.firstname || ' ' || $1.lastname
$$ LANGUAGE SQL;

SELECT full_name(employees.*),city,country
FROM employees;

--95 fuction that return a composite
CREATE OR REPLACE FUNCTION newest_hire() RETURNS employees AS $$
	SELECT *
	FROM employees
	ORDER BY hiredate DESC
	LIMIT 1;
$$ LANGUAGE SQL;

SELECT newest_hire();

SELECT (newest_hire()).lastname;

SELECT lastname(newest_hire());

SELECT (newest_hire()).*;

CREATE OR REPLACE FUNCTION highest_inventory() RETURNS products AS $$

	SELECT * FROM products
	ORDER BY (unitprice*unitsinstock) DESC
	LIMIT 1;

$$ LANGUAGE SQL;

SELECT (highest_inventory()).productname;
SELECT productname(highest_inventory());

SELECT (newest_hire()).*;

--96 function with output parameter
CREATE OR REPLACE FUNCTION sum_n_product (x int, y int, OUT sum int, OUT product int) AS $$
	SELECT x + y, x * y
$$ LANGUAGE SQL;

SELECT sum_n_product(5, 20);
SELECT (sum_n_product(5, 20)).*;

CREATE OR REPLACE FUNCTION square_n_cube(IN x int, OUT square int, OUT cube int) AS $$
	SELECT x * x, x*x*x;
$$ LANGUAGE SQL;

SELECT square_n_cube(5);
SELECT (square_n_cube(5)).*;

--97 function with default value
CREATE OR REPLACE FUNCTION new_price(products, increase_percent numeric DEFAULT 105)
RETURNS double precision AS $$
	SELECT $1.unitprice * increase_percent/100
$$ LANGUAGE SQL;

SELECT productname,unitprice,new_price(products.*)
FROM products;

CREATE OR REPLACE FUNCTION square_n_cube(IN x int DEFAULT 10, OUT square int, OUT cube int) AS $$
	SELECT x * x, x*x*x;
$$ LANGUAGE SQL;

SELECT (square_n_cube()).*;

--98 using fuction as table source
SELECT firstname,lastname,hiredate
FROM newest_hire();

SELECT productname,companyname
FROM highest_inventory() AS hi
JOIN suppliers ON hi.supplierid=suppliers.supplierid;

--99 function that return more than one row
CREATE OR REPLACE FUNCTION sold_more_than(total_sales real)
RETURNS SETOF products AS $$
 SELECT * FROM products
 WHERE productid IN (
	 SELECT productid FROM
 	 (SELECT SUM(quantity*unitprice),productid
	 FROM order_details
	 GROUP BY productid
	 HAVING SUM(quantity*unitprice) > total_sales) as qualified_products
 )
$$ LANGUAGE SQL;

SELECT productname, productid, supplierid
FROM sold_more_than(25000);

CREATE OR REPLACE FUNCTION next_birthday()
RETURNS TABLE (birthday date,firstname varchar(10), lastname varchar(20), hiredate date) AS $$
SELECT (birthdate + INTERVAL '1 YEAR'* (EXTRACT(YEAR FROM age(birthdate))+1))::date,
firstname, lastname, hiredate
FROM employees
$$ LANGUAGE SQL;

select * from next_birthday();

CREATE OR REPLACE FUNCTION suppliers_to_reorder_from()
RETURNS SETOF suppliers AS $$
  SELECT * FROM suppliers
  WHERE supplierid IN (
	 SELECT supplierid FROM products
	  WHERE unitsinstock + unitsonorder < reorderlevel
  )
$$ LANGUAGE SQL;

SELECT * FROM suppliers_to_reorder_from();

CREATE OR REPLACE FUNCTION excess_inventory_level(percent numeric)
returns table (excess int, productid smallint, productname varchar(40))as $$
select ceil( (unitsinstock + unitsonorder)- (reorderlevel * percent/100))::int,
productid, productname
from products
where (unitsinstock + unitsonorder)-(reorderlevel* percent/100)>0;
$$ language sql

SELECT * FROM excess_inventory_level(200);

--102 function that don't return anything
CREATE OR REPLACE PROCEDURE add_em(x int, y int) AS $$

	SELECT x + y

$$ LANGUAGE SQL;

CALL add_em(5,3);


CREATE OR REPLACE PROCEDURE change_supplier_prices(supplierid smallint, amount real) AS $$

	UPDATE products
	SET unitprice = unitprice + amount
	WHERE supplierid = $1

$$ LANGUAGE SQL;

CALL change_supplier_prices(20::smallint, 0.50);


