-- Хранимая процедура CLR.

-- Добавляет нового футболиста в таблицу.

CREATE OR REPLACE PROCEDURE add_footballer_py
(
    id INT,
    first_name VARCHAR,
    last_name VARCHAR,
    country VARCHAR,
    age INT,
    salary INT,
    phone_number VARCHAR,
    average_rating REAL
) 
AS $$
    plan = plpy.prepare("INSERT INTO footballer VALUES($1, $2, $3, $4, $5, $6, $7, $8)", 
        ["INT", "VARCHAR", "VARCHAR", "VARCHAR", "INT", "INT", "VARCHAR", "REAL"])

    plpy.execute(plan, 
        [id, first_name, last_name, country, age, salary, phone_number, average_rating])

$$ LANGUAGE plpython3u;

DELETE FROM footballer
WHERE last_name = 'Messi';

CALL add_footballer_py(5001, 'Lionel',  'Messi', 'Argentina', 34, 10000000, '8-916-999-10-10', 10.0);

SELECT *
FROM footballer
WHERE last_name = 'Messi'
