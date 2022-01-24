




SELECT companyname,country,
CASE WHEN country IN ('Austria','Germany','Poland','France','Sweden','Italy','Spain',
             'UK','Ireland','Belgium','Finland','Norway','Portugal','Switzerland') THEN 'Europe'
             WHEN country IN ('Canada','Mexico','USA') THEN 'North America'
             WHEN country IN ('Argentina','Brazil','Venezuela') THEN 'South America'
             ELSE country
END AS continent
FROM customers;

SELECT productname,unitprice,
CASE WHEN unitprice<10 THEN 'inexpensive'
     WHEN unitprice>=10 AND unitprice<=50 THEN 'mid-range'
	 WHEN unitprice > 50 THEN 'premium'
END AS quality
FROM products;

SELECT companyname,city,
CASE city WHEN 'New Orleans' THEN 'Big Easy'
                   WHEN 'Paris' THEN 'City of Lights'
	         ELSE 'Needs nickname'
END as nickname
FROM suppliers;

SELECT orderid,customerid,
CASE date_part('year', orderdate)
	WHEN 1996 THEN 'year1'
	WHEN 1997 THEN 'year2'
	WHEN 1998 THEN 'year3'
END
FROM orders;


--coalesce
SELECT customerid,COALESCE(shipregion,'N/A') FROM orders;

SELECT companyname,COALESCE(homepage,'Call to find') from suppliers;


--NULLIF
UPDATE suppliers
SET homepage = ''
WHERE homepage IS NULL;

UPDATE customers
SET fax = ''
WHERE fax IS NULL;

SELECT companyname,phone,
COALESCE(NULLIF(homepage,''),'Need to call')
FROM suppliers;

SELECT companyname,
COALESCE(NULLIF(fax,''),phone) AS confirmation
FROM customers;
