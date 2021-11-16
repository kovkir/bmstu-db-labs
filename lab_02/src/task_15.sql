-- 15. Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY и предложения HAVING.

SELECT age, AVG(salary) AS average_salary, 
            AVG(average_rating) AS average_rating
FROM footballer
GROUP BY age
HAVING age < (SELECT AVG(age) FROM footballer)
ORDER BY age

-- Получить среднюю зарплату и рейтинг футболистов каждого возраста при условии, что они моложе большинства других футболистов. Отсортировать данные по возрастанию возраста.
