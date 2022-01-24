--section 32

--basic import export with copy

psql -p 5433 -h localhost -d northwind -U postgres

\COPY customers TO 'customers.txt';

\h COPY

\COPY customers TO 'customers.csv'
WITH (HEADER, QUOTE '"');

\COPY customers TO 'customers.csv'
WITH (FORMAT CSV, HEADER, QUOTE '"',
FORCE_QUOTE (companyname, contactname,contacttitle, address, city, region, country));


\COPY (SELECT * FROM orders WHERE orderdate BETWEEN '01-01-1996' AND '12-31-1996')
TO 'orders1996.csv' WITH (FORMAT CSV, HEADER);

\COPY (SELECT * FROM order_details WHERE productid=11)
TO 'queso_order_details.csv' WITH (FORMAT CSV, HEADER);

--basic pg dump and store

pg_dump northwind -p 5432 -h localhost  -U postgres > northwind.sql

createdb northwind_bak -p 5432 -h localhost  -U postgres

psql northwind_bak -p 5432 -h localhost  -U postgres <  northwind.sql


pg_dump usda -p 5432 -h localhost  -U postgres > usda.sql

createdb usda_bak -p 5432 -h localhost  -U postgres

psql usda_bak -p 5432 -h localhost  -U postgres <  usda_bak.sql


--custome format dumps

pg_dump -Fc northwind -p 5432 -h localhost  -U postgres > northwind.fc

ls -l northwind.*

pg_restore -j 4  -p 5432 -h localhost  -U postgres -d northwind_bak northwind.fc

pg_restore -j 4  -p 5432 -h localhost  -U postgres -d northwind_bak -t usstates northwind.fc


pg_dump -Fc usda -p 5432 -h localhost  -U postgres > usda.fc

pg_restore -j 4  -p 5432 -h localhost  -U postgres -d usda -t weight  usda.fc


