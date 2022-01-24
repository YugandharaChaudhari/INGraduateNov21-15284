--declaring arry
DROP TABLE IF EXISTS friends;


CREATE TABLE friends (
    name full_name,
    address address,
    specialdates dates_to_remember,
    children varchar(50) ARRAY
);

DROP TABLE IF EXISTS salary_employees;

CREATE TABlE salary_employees (
    name text,
    pay_by_quarter integer[4],
	schedule text[][]
)



--inputting array value 
INSERT INTO friends (name, address, specialdates, children)
VALUES (ROW('Boyd','M','Gregory'),
		ROW('7777','','Boise','Idaho','USA','99999'),
		ROW('1969-02-01',49,'2001-07-15'),
	   '{"Austin","Ana Grace"}');

 INSERT INTO friends (name, address, specialdates, children)
 VALUES (ROW('Scott','X','Levy'),
 		ROW('357 Page Road','','Austin','TX','USA','88888'),
 		ROW('1972-03-01',46,'2002-01-30'),
 		   ARRAY['Ben','Jill']);

INSERT INTO salary_employees (name,pay_by_quarter,schedule)
VALUES ('Bill',
		 		'{20000, 20000, 20000, 20000}',
				'{{"meeting", "training"},{"lunch", "sales call"}}')

INSERT INTO salary_employees (name,pay_by_quarter,schedule)
VALUES ('Bill',
		 ARRAY[20000, 20000, 20000, 20000],
		 ARRAY[['meeting', 'training'],['lunch', 'sales call']])




SELECT children[2]
FROM friends;

SELECT pay_by_quarter[2:3]
FROM salary_employees;

SELECT array_dims(schedule)
FROM salary_employees;

SELECT array_length(schedule,1),array_length(schedule,2)
FROM salary_employees;




UPDATE friends
SET children=ARRAY['Maddie','Timmy','Cheryl']
WHERE (name).first_name = 'Boyd';

SELECT children
FROM friends
WHERE (name).first_name = 'Boyd'
LIMIT 1;

UPDATE friends
SET children[2]='Ricky'
WHERE (name).first_name = 'Boyd';

SELECT children
FROM friends
WHERE (name).first_name = 'Boyd'
LIMIT 1;

UPDATE friends
SET children[2:3]=ARRAY['Suzy','Billy']
WHERE (name).first_name = 'Boyd';

SELECT children
FROM friends
WHERE (name).first_name = 'Boyd'
LIMIT 1;

UPDATE salary_employees
SET pay_by_quarter=ARRAY[22000,25000,27000,22000]
WHERE name='Bill';

SELECT pay_by_quarter
FROM salary_employees
WHERE name='Bill';

UPDATE salary_employees
SET pay_by_quarter[4]=26000
WHERE name='Bill';

SELECT pay_by_quarter
FROM salary_employees
WHERE name='Bill';

UPDATE salary_employees
SET pay_by_quarter[2:3]=ARRAY[24000,25000]
WHERE name='Bill';

SELECT pay_by_quarter
FROM salary_employees
WHERE name='Bill';




SELECT *
FROM friends
WHERE children[0] = 'Billy' OR children[1] = 'Billy'
OR children[2]='Billy' OR children[3]='Billy';

SELECT *
FROM friends
WHERE 'Austin' = ANY (children)


SELECT *
FROM salary_employees
WHERE 'sales call' = ANY (schedule);




-- equal
SELECT ARRAY[1, 2, 3, 4] = ARRAY[1, 2, 3, 4];

-- not equal, the elements are not in same order
SELECT ARRAY[1, 2, 4, 3] = ARRAY[1, 2, 3, 4];

-- true
SELECT ARRAY[1, 2, 4, 3] > ARRAY[1, 2, 3, 4];

-- false
SELECT ARRAY[1, 2, 3, 4] > ARRAY[1, 2, 3, 4];

-- false 3 smaller than 4, doesn't look at 5 greater than 4
SELECT ARRAY[1, 2, 3, 5] > ARRAY[1, 2, 4, 4];

-- true
SELECT ARRAY[1, 2, 3, 5] @> ARRAY[2, 5];

-- false
SELECT ARRAY[1, 2, 3, 5] @> ARRAY[2, 5, 7];

-- true
SELECT ARRAY[1, 2] <@ ARRAY[2, 5, 7, 1];

-- true
SELECT ARRAY[1, 2, 13, 17] && ARRAY[2, 5, 7, 1];

--false
SELECT ARRAY[ 13, 17] && ARRAY[2, 5, 7, 1];

SELECT *
FROM friends
WHERE children && ARRAY['Billy'::varchar(50)];

SELECT *
FROM salary_employees
WHERE schedule && ARRAY['sales call'];
