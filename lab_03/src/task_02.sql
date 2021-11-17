-- Функции.
-- Подставляемая табличная функция.

-- Возвращает информацию о футболистах, средний рейтинг за игру которых равен 10, а зарплаты выше средней среди футболистов.

CREATE OR REPLACE FUNCTION best_footballers()
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
    RETURN QUERY
    SELECT f.first_name, f.last_name, f.age, f.salary, f.average_rating
    FROM footballer AS f
    WHERE f.average_rating = 10 AND f.salary > 
    (
        SELECT AVG(f.salary) 
        FROM footballer AS f
    );
END;
$$ LANGUAGE PLPGSQL;

SELECT *
FROM best_footballers();
