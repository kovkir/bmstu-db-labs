-- Функции.
-- Многооператорная табличная функция.

--  Возвращает информацию о футболистах, средний рейтинг за игру которых равен 10, а возраст меньше заданного age_f.

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
FROM best_young_footballers(18)
