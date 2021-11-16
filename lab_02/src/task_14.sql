-- 14. Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY, но без предложения HAVING.

SELECT age, AVG(salary) AS average_salary, 
            AVG(average_rating) AS average_rating
FROM footballer
GROUP BY age
ORDER BY age

-- Получить среднюю зарплату и рейтинг футболистов каждого возраста. Отсортировать данные по возрастанию возраста.
