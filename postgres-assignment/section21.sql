--date time and timestamp
SHOW DateStyle;

SET DateStyle = 'ISO,DMY';

SET DateStyle = 'ISO,MDY'

SET DateStyle = 'ISO,YMD'


CREATE TABLE test_time (
	startdate DATE,
	startstamp TIMESTAMP,
	starttime TIME
);

Insert INTO test_time (startdate, startstamp,starttime)
VALUES ('epoch' :: abstime, 'infinity' :: abstime, 'allballs');


SELECT * FROM test_time;

Insert INTO test_time (startdate, startstamp)
VALUES ('NOW'::abstime,'today'::abstime);


SELECT * FROM test_time;


--time zones

SELECT * FROM pg_timezone_names;

SELECT * FROM  pg_timezone_abbrevs;

ALTER TABLE test_time
ADD COLUMN endstamp TIMESTAMP WITH TIME ZONE;

ALTER TABLE test_time
ADD COLUMN endtime TIME WITH TIME ZONE;


INSERT INTO test_time
(endstamp,endtime)
VALUES ('01/20/2018 10:30:00 US/Pacific', '10:30:00+5');
INSERT INTO test_time (endstamp,endtime)
VALUES ('06/20/2018 10:30:00 US/Pacific', '10:30:00+5');

--Notice the difference in offset due to daylight savings time
SELECT * FROM test_time;


SHOW TIME ZONE;

SELECT * FROM test_time;

SET TIME ZONE 'US/Pacific'

SELECT * FROM test_time;


--intervel data type

ALTER TABLE test_time
ADD COLUMN span interval;

DELETE  FROM test_time;

--Postgres Format
INSERT INTO test_time (span)
VALUES ('5 DECADES 3 YEARS, 6 MONTHS 3 DAYS');

INSERT INTO test_time (span)
VALUES ('5 DECADES 3 YEARS, 6 MONTHS 3 DAYS ago');

SELECT * FROM test_time;

SELECT span FROM test_time; 

--SQL Standard
INSERT INTO test_time (span)
VALUES ('4 32:12:10');

INSERT INTO test_time (span)
VALUES ('1-2');

SELECT span FROM test_time; 


--ISO 8061 Format
INSERT INTO test_time (span)
VALUES (‘P5Y3MT7H3M’);

INSERT INTO test_time (span)
VALUES ('P25-2-30T17:33:10');

SELECT span FROM test_time; 

SHOW intervalstyle;

SELECT * FROM test_time;

SET intervalstyle='postgres_verbose';
SELECT span FROM test_time;

SET intervalstyle='sql_standard';
SELECT span FROM test_time;

SET intervalstyle='iso_8601';
SELECT span FROM test_time;

SET intervalstyle='postgres';


--data arithmatic
SELECT DATE '2018-09-28' + INTERVAL '5 days 1 hour';

SELECT TIME '5:30:10' + INTERVAL '70 minutes 80 seconds';

SELECT TIMESTAMP '1917-06-20 12:30:10.222' +
  INTERVAL '30 years 6 months 7 days 3 hours 17 minutes 3 seconds';

SELECT INTERVAL '5 hours 30 minutes 2 seconds' +
      INTERVAL '5 days 3 hours 13 minutes';

SELECT DATE '2017-04-05' +  INTEGER '7';

-- subtracting intervals from date,time, timestamp
SELECT DATE '2018-10-20' - INTERVAL '2 months 5 days';

SELECT TIME '23:39:17' - INTERVAL '12 hours 7 minutes 3 seconds'

SELECT TIMESTAMP '2016-12-30' - INTERVAL '27 years 3 months 17 days 3 hours 37 minutes';

-- subtracting integer from date
SELECT DATE '2016-12-30' - INTEGER '300';

--subtracting 2 dates
SELECT DATE '2016-12-30' - DATE '2009-04-7';

-- subtracting 2 times and 2 timestamps
SELECT TIME '17:54:01' - TIME '03:23:45';

SELECT TIMESTAMP '2001-02-15 12:00:00' - TIMESTAMP '1655-08-30 21:33:05';

--Multiply and divide intervals
SELECT 5 * INTERVAL '7 hours 5 minutes';

SELECT INTERVAL '30 days 20 minutes' / 2;

SELECT age(TIMESTAMP '2025-10-03', TIMESTAMP '1999-10-03');

SELECT age (TIMESTAMP '1969-04-20');




--pulling
SELECT EXTRACT(YEAR FROM age(birthdate)),firstname, lastname
FROM employees;

SELECT date_part('day', shippeddate)
FROM orders;

SELECT EXTRACT (DECADE FROM age(birthdate)),firstname,lastname
FROM employees;

SELECT date_part ('DECADE', age(birthdate)),firstname,lastname
FROM employees;


--convert one data type into another
SELECT hiredate::TIMESTAMP
FROM employees;

SELECT CAST(hiredate AS TIMESTAMP)
FROM employees;

SELECT (ceil(unitprice*quantity))
FROM order_details;

SELECT (ceil(unitprice*quantity))::TEXT || ' dollars spent'
FROM order_details;



