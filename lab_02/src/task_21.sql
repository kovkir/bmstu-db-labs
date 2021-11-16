-- 21. Инструкция DELETE с вложенным коррелированным подзапросом в предложении WHERE.

-- INSERT INTO coach(id, first_name, last_name, country, age, salary, work_experience, phone_number, email) 
-- VALUES(5001, 'Lionel',  'Messi', 'Argentina', 34, 5000000, 0, '8-916-999-10-10', 'lionelmessi1987@gmail.com');

-- Довавление тренера 'Messi' в таблицу 'coach'

DELETE FROM footballer
WHERE last_name IN
(
    SELECT last_name
    FROM coach
    WHERE id > 5000
);

-- Удалить футболистов из таблицы, если их фамилия совподает с фамилиями тренеров, id которых больше 5000.

SELECT *
FROM footballer, coach
WHERE last_name = 'Messi'
