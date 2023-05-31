CREATE TABLE workers (
  id serial PRIMARY KEY,
  first_name varchar(300) NOT NULL CHECK(first_name != ''),
  last_name varchar(400) NOT NULL CHECK(last_name != ''),
  salary int NOT NULL CHECK(salary > 0),
  birthday date
);
---------------------
INSERT INTO workers (first_name, last_name, birthday, salary)
VALUES('Олег', 'Олеженко', '1990-10-23', 300);
INSERT INTO workers (first_name, last_name, birthday, salary)
VALUES('Ярослава', 'Славенко', '1994-05-16', 1200);
INSERT INTO workers (first_name, last_name, birthday, salary)
VALUES('Саша', 'Олександров', '1985-02-28', 1000),
  ('Маша', 'Макаренко', '1995-06-05', 900);
----------------------
UPDATE workers
SET salary = 500
WHERE first_name = 'Олег';
---
UPDATE workers
SET birthday = birthday + MAKE_INTERVAL(
    years => 1987 - EXTRACT(
      year
      from birthday
    )::INTEGER
  )
WHERE id = 4;
---
UPDATE workers
SET salary = 700
WHERE salary > 500;
---
UPDATE workers
SET birthday = birthday + MAKE_INTERVAL(
    years => 1999 - EXTRACT(
      year
      from birthday
    )::INTEGER
  )
WHERE id BETWEEN 2 AND 5;
---
UPDATE workers
SET first_name = 'Женя'
WHERE first_name = 'Саша';
----------------------
SELECT *
FROM workers
WHERE id = 3;
---
SELECT *
FROM workers
WHERE salary > 400;
---
SELECT salary,
  EXTRACT(
    year
    from (age(birthday))
  ) AS age
FROM workers
WHERE first_name = 'Женя';
---
SELECT *
FROM workers
WHERE first_name = 'Петя';
---
SELECT *
FROM workers
WHERE (
    extract(
      year
      from age(birthday)
    ) >= 27
  )
  AND (salary < 1000);
---
SELECT *
FROM workers
WHERE (
    extract(
      year
      from age(birthday)
    ) >= 25
  )
  AND (
    extract(
      year
      from age(birthday)
    ) <= 30
  );
---
SELECT *
FROM workers
WHERE (salary > 300)
  OR (char_length(first_name) < 6);
------------------
DELETE FROM workers
WHERE id = 4;
---
DELETE FROM workers
WHERE first_name = 'Петя';
---
DELETE FROM workers
WHERE extract(
    year
    from(age(birthday))
  ) > 40;
------------------
SELECT *,
  char_length(concat(first_name, last_name)) AS letters_quantity
FROM workers;
---
SELECT *
FROM workers
LIMIT 3;
---
SELECT *
FROM workers
WHERE (
    extract(
      month
      from (birthday)
    ) = 2
  )
  OR (
    extract(
      year
      from(age(birthday))
    ) > 30
  );
---
SELECT *
FROM workers
WHERE extract(
    month
    from (birthday)
  ) = extract(
    month
    from(current_date)
  ) + 1;
----------------