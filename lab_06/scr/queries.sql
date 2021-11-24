-- 1. Выполнить скалярный запрос.
-- Получить среднюю зарплату футболистов из России

SELECT avg(salary)
FROM footballer
WHERE country = 'Russian Federation';

-- 2. Выполнить запрос с несколькими соединениями (JOIN).
-- Пулучть фамилии футбулистов, тренеров, названия клубов и кол-во голов, забитых данными футболистами под руководством данных тренеров за данные клубы (первые 10 записей).

SELECT f.last_name  AS surname_footballer,
       co.last_name AS surname_coach,
       cl.name      AS name_club, 
       fcc.number_goals
FROM footballer_coach_club AS fcc 
    JOIN footballer AS f  ON fcc.footballer_id = f.id
    JOIN coach      AS co ON fcc.id = co.id
    JOIN club       AS cl ON fcc.id = cl.id 
WHERE f.id < 11;

-- 3. Выполнить запрос с ОТВ(CTE) и оконными функциями.
-- Создать полные дубли в таблице club, после чего устранить их с использованием функции ROW_NUMBER(). Вывести первые 10 записей.

WITH table_with_duplicates AS
(
    SELECT *
    FROM club

    UNION ALL

    SELECT *
    FROM club
),
tmp_table AS
(   
    SELECT *, ROW_NUMBER() OVER (PARTITION BY id) AS number
    FROM table_with_duplicates
)
SELECT *
FROM tmp_table
WHERE number = 1 AND id < 11;

-- 4. Выполнить запрос к метаданным.
-- Получить имя текущей базы данных и лимит подключений к ней.

SELECT pg.datname, pg.datconnlimit
FROM pg_database AS pg
WHERE pg.datname = 'football_db';

-- 5. Вызвать скалярную функцию.
-- Вернуть сумму денег, которую мог заработать тренер, если бы на протяжении всей карьеры имел такую же зарплату, как и сейчас. Вывести первые 10 записей.

CREATE OR REPLACE FUNCTION amount_money(salary INT, work_experience INT)
RETURNS DECIMAL AS $$
BEGIN
    RETURN salary * work_experience;
END;
$$ LANGUAGE PLPGSQL;

SELECT last_name, age, salary, work_experience, amount_money(salary, work_experience)
FROM coach
WHERE id < 11;

-- 6. Вызвать многооператорную табличную функцию.
--  Вернуть информацию о футболистах, средний рейтинг за игру которых равен 10, а возраст меньше 18.

CREATE OR REPLACE FUNCTION best_young_footballers(age_f INT)
RETURNS TABLE
(
    first_name VARCHAR, 
    last_name VARCHAR, 
    age INT, 
    salary INT, 
    average_rating REAL
)
AS $$
BEGIN
    DROP TABLE IF EXISTS tmp_table;

    CREATE TEMP TABLE IF NOT EXISTS tmp_table
    (
        first_name VARCHAR, 
        last_name VARCHAR, 
        age INT, 
        salary INT, 
        average_rating REAL
    );

    INSERT INTO tmp_table(first_name, last_name, age, salary, average_rating)
    SELECT f.first_name, f.last_name, f.age, f.salary, f.average_rating
    FROM footballer as f
    WHERE f.age < age_f AND f.average_rating = 10;

    RETURN QUERY
    SELECT *
    FROM tmp_table;
END;
$$ LANGUAGE PLPGSQL;

SELECT *
FROM best_young_footballers(18);

-- 7. Вызвать хранимую процедуру.
-- Увеличить тренеру с заданным id зарплаты на заданную сумму.

CREATE OR REPLACE PROCEDURE change_salary(id_coach INT, salary_increase INT)
AS $$
BEGIN
    UPDATE coach
    SET salary = salary + salary_increase
    WHERE id = id_coach;
END;
$$ LANGUAGE PLPGSQL;

CALL change_salary(1, 505);

SELECT id, first_name, last_name, age, salary
FROM coach
WHERE id = 1
ORDER BY id;


-- 8. Вызвать системную функцию.
-- Вызвать системную функцию для вывода имени текущей базы данных.

SELECT *
FROM current_database();

-- 9. Создать таблицу в базе данных, соответствующую тематике БД.
-- Создаем таблицу друзей футболистов.

DROP TABLE IF EXISTS friends_table;

CREATE TABLE IF NOT EXISTS friends_table
(
    id   INT NOT NULL PRIMARY KEY,
    name VARCHAR(32),
    age  INT NOT NULL,
    friend_id INT,
    check (age >= 16 and age <= 45)
);

-- 10. Выполнить вставку данных в созданную таблицу с использованием инструкции INSERT.
-- Выполнить вставку данных в созданную таблицу друзей футболистов.

INSERT INTO friends_table(id, name, age, friend_id) VALUES
(1, 'Messi', 34, 3),
(2, 'Ronaldo', 36, Null),
(3, 'Neymar', 29, 4),
(4, 'Mbappe', 22, 2);

SELECT *
FROM friends_table;
