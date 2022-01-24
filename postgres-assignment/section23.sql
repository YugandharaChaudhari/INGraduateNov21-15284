--COMPOSITE TYPE
CREATE TYPE address AS (
	street_address 	varchar(50),
	street_address2 varchar(50),
	city			varchar(50),
	state_region	varchar(50),
	country			varchar(50),
	postalcode		varchar(15)
);

CREATE TABLE friends (
	first_name varchar(100),
	last_name varchar(100),
	address	address
);

DROP TYPE address CASCADE;
DROP TABLE friends;


CREATE TYPE address AS (
	street_address 	varchar(50),
	street_address2 varchar(50),
	city			varchar(50),
	state_region	varchar(50),
	country			varchar(50),
	postalcode		varchar(15)
);

CREATE TYPE full_name AS (
	first_name varchar(50),
	middle_name varchar(50),
	last_name varchar(50)
);

CREATE TABLE friends (
	name full_name,
	address	address
);

DROP TYPE address CASCADE;
DROP TYPE full_name CASCADE;
DROP TABLE friends;





CREATE TYPE address AS (
	street_address 	varchar(50),
	street_address2 varchar(50),
	city			varchar(50),
	state_region	varchar(50),
	country			varchar(50),
	postalcode		varchar(15)
);

CREATE TYPE full_name AS (
	first_name varchar(50),
	middle_name varchar(50),
	last_name varchar(50)
);

CREATE TYPE dates_to_remember AS (
  birthdate date,
  age       integer,
  anniversary date
);

CREATE TABLE friends (
	name full_name,
	address	address,
  specialdates dates_to_remember
);

INSERT INTO friends (name, address, specialdates)
VALUES (ROW('Boyd','M','Gregory'),ROW('7777','','Boise','Idaho','USA','99999'),ROW('1969-02-01',49,'2001-07-15'));

SELECT * FROM friends;
SELECT name FROM friends;

SELECT (address).city,(specialdates).birthdate
FROM friends;

SELECT (address).city,(specialdates).birthdate
FROM friends
WHERE (name).first_name = 'Boyd';

SELECT (address).state_region,(name).middle_name,(specialdates).age FROM friends
WHERE (name).last_name = 'Gregory';
