-- 22. Инструкция SELECT, использующая простое обобщенное табличное выражение.

WITH cte (first_name, last_name, age, salary) AS
(
    SELECT first_name, last_name, age, salary
    FROM footballer
    WHERE age < 18
)
SELECT MAX(salary)
FROM cte

-- Получить максимальную зарплату футболиста, моложе 18 лет.
