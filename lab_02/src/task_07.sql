-- 7. Инструкция SELECT, использующая агрегатные функции (SUM, MIN, MAX, AVG и COUNT) в выражениях столбцов.

SELECT AVG(salary)
FROM footballer
WHERE country = 'Russian Federation' AND age < 20

-- Получить среднюю зарплату футболистов из Росси моложе 20 лет.
