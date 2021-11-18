-- 17. Многострочная инструкция INSERT, выполняющая вставку в таблицу результирующего набора данных вложенного подзапроса.

DELETE FROM footballer
WHERE last_name = 'Messi';

INSERT INTO footballer(first_name, last_name, country, age, salary, phone_number, average_rating) 
SELECT first_name, 'Messi' as last_name, country, age, salary, CONCAT(phone_number, '-', id), average_rating
FROM footballer
WHERE country LIKE 'A%' AND first_name LIKE 'L%';

-- Добавить футболистов в таблицу по следующему принципу:
    -- 1) найти футболистов, название стран которых начинается на 'A', а имя на 'L';
    -- 2) изменить фамилию игроков на 'Messi', добавить к номеру телефона id;
    -- 3) добавить получившихся футболистов в таблицу.

SELECT *
FROM footballer
WHERE last_name = 'Messi'
