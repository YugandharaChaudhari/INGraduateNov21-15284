select distinct country
from suppliers
order by country asc;

select distinct country, city
from suppliers
order by country asc, city desc;

select productname, unitprice
from products
order by productname asc, unitprice desc;

select min(orderdate)
from orders
where shipcountry ='Italy';

select max(orderdate)
from orders
where shipcountry ='Canada';

select max (shippeddate - orderdate)
from orders
where shipcountry='France';

select avg(freight)
from orders
where shipcountry ='Brazil';

select sum(quantity)
from order_details
where productid =14;

select avg(quantity)
from order_details
where productid =35;

--mach patterns
select companyname, contactname
from customers
where contactname like 'D%';

select companyname
from customers
where companyname like '%er';

--renaming column
select unitprice*quantity as totalSpent
from order_details;

select unitprice*unitsinstock as totalInventory
from products
order by totalInventory DESC;

--limit
 select productid, unitprice*quantity as totalCost
 from order_details
 order by totalCost desc
 limit 4;
 
 select productname, unitprice*unitsinstock as totalInventory
 from products
 order by totalInventory asc
 limit 2;
 
 --null values
 select count(*)
 from customers
 where region is null;
 
 select count(*)
 from suppliers
 where region is  not null;
 
 select count(*)
 from orders
 where shipregion is null;

