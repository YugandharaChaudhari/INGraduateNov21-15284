--grab info from two tables
--inner join
select companyname,orderdate,shipcountry
from orders
join customers on customers.customerid=orders.customerid;

select firstname, lastname, orderdate
from orders
join employees on employees.employeeid=orders.employeeid;

select companyname, unitprice, unitsinstock
from products
join suppliers on products.supplierid=suppliers.supplierid;

--info from multi tables
select companyname, unitprice, orderdate ,quantity
from orders
join order_details on orders.orderid=order_details.orderid
join customers on customers.customerid=orders.customerid;

select companyname, order_details.unitprice, orderdate ,quantity, productname
from orders
join order_details on orders.orderid=order_details.orderid
join customers on customers.customerid=orders.customerid
join products on products.productid=order_details.productid;

select companyname, order_details.unitprice, orderdate ,quantity, productname,categoryname
from orders
join order_details on orders.orderid=order_details.orderid
join customers on customers.customerid=orders.customerid
join products on products.productid=order_details.productid
join categories on categories.categoryid= products.categoryid;

select companyname, order_details.unitprice, orderdate ,quantity, productname,categoryname
from orders
join order_details on orders.orderid=order_details.orderid
join customers on customers.customerid=orders.customerid
join products on products.productid=order_details.productid
join categories on categories.categoryid= products.categoryid
where categoryname='seafood'and
		order_details.unitprice*quantity >= 500;

--left join
select companyname, orderid
from customers
left join orders on orders.customerid=customers.customerid;

select companyname, orderid
from customers
left join orders on orders.customerid=customers.customerid
where orderid is null;

select productname, orderid
from products
left join order_details on order_details.productid=products.productid;

--right join
select companyname,orderid
from orders
right join customers on customers.customerid=orders.customerid;

select companyname,orderid
from orders
right join customers on customers.customerid=orders.customerid
where orderid is null;

select companyname,customercustomerdemo.customerid
from customercustomerdemo
right join customers on customers.customerid=customercustomerdemo.customerid;

--full join
select companyname, orderid
from customers
full join orders on customers.customerid=orders.customerid;

select productname, categoryname
from products
full join categories on categories.categoryid=products.categoryid;

--self join
select c1.companyname as customerName1, c2.companyname as customerName2, c1.city
from customers as c1
join customers as c2 on c1.city=c2.city
where c1.customerid<>c2.customerid
order by c1.city;

select s1.companyname as supplierName1, s2.companyname as supplierName2, s1.country
from suppliers as s1
join suppliers as s2 on s1.country=s2.country
where s1.supplierid<>s2.supplierid
order by s1.country;

select *
from orders
join order_details using (orderid);

select *
from orders
join order_details using (orderid)
join products using (productid);

--natural join
select *
from orders
natural join order_details;

select *
from customers
natural join orders
natural join order_details;

select count(*)
from products
natural join order_details;




SELECT firstname,middlename,lastname,phonenumber,name
FROM person.personphone AS ph
JOIN person.businessentity AS be ON be.businessentityid=ph.businessentityid
JOIN person.person AS pe ON pe.businessentityid=be.businessentityid
JOIN person.phonenumbertype AS pnt ON pnt.phonenumbertypeid=ph.phonenumbertypeid
ORDER BY ph.businessentityid DESC;


SELECT firstname,middlename,lastname,phonenumber,name
FROM person.personphone AS ph
JOIN person.businessentity USING (businessentityid)
JOIN person.person USING (businessentityid)
JOIN person.phonenumbertype USING (phonenumbertypeid)
ORDER BY ph.businessentityid DESC;



SELECT pm.name,c.name,description
FROM production.productdescription
JOIN production.productmodelproductdescriptionculture USING (productdescriptionid)
JOIN production.culture AS c USING (cultureid)
JOIN production.productmodel AS pm USING (productmodelid)
ORDER BY pm.name ASC;


SELECT p.name,pm.name,c.name,description
FROM production.productdescription
JOIN production.productmodelproductdescriptionculture USING (productdescriptionid)
JOIN production.culture AS c USING (cultureid)
JOIN production.productmodel AS pm USING (productmodelid)
JOIN production.product AS p USING (productmodelid)
ORDER BY pm.name ASC;


SELECT name, rating, comments
FROM production.product
LEFT JOIN production.productreview USING (productid)
ORDER BY rating ASC;

SELECT p.name,orderqty,scrappedqty
FROM production.workorder
RIGHT JOIN production.product AS p USING (productid)
ORDER BY p.productid ASC;
