-- 19. Инструкция UPDATE со скалярным подзапросом в предложении SET.

-- INSERT INTO footballer(id, first_name, last_name, country, age, salary, phone_number, average_rating) 
-- VALUES(5001, 'Lionel',  'Messi', 'Argentina', 34, 10000000, '8-916-999-10-10', 10.0);

UPDATE footballer
SET salary = 
(
    SELECT AVG(salary)
    FROM coach
    WHERE country = 'Russian Federation'
)
WHERE id > 5000;

-- Замена зарплаты футболистов с id больше 5000, на среднюю зарплату тренеров из России.

SELECT *
FROM footballer
WHERE id > 5000;

-- DELETE FROM footballer
-- WHERE id = 5001
