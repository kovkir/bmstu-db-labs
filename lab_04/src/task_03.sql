-- Определяемая пользователем табличная функция CLR.

-- Возвращает информацию о футболистах, средний рейтинг за игру которых выше заданного, а зарплаты выше средней среди футболистов.

CREATE OR REPLACE FUNCTION best_footballers_py(avg_rating REAL)
RETURNS TABLE
(
    first_name VARCHAR, 
    last_name VARCHAR, 
    age INT, 
    salary INT, 
    average_rating REAL
)
AS $$
    query = '''
        SELECT first_name, last_name, age, salary, average_rating 
        FROM footballer 
        WHERE salary > 
        (
            SELECT AVG(salary) 
            FROM footballer 
        );
            '''

    res_query = plpy.execute(query)
    
    if res_query is not None:
        res = list()

        for footballer in res_query:
            if footballer["average_rating"] >= avg_rating:
                res.append(footballer)

        return res

$$ LANGUAGE PLPYTHON3U;

SELECT *
FROM best_footballers_py(9);
