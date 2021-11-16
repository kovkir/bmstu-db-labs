-- 17. Многострочная инструкция INSERT, выполняющая вставку в таблицу результирующего набора данных вложенного подзапроса.

INSERT INTO footballer(id, first_name, last_name, country, age, salary, phone_number, average_rating) 
SELECT id + 5000, first_name, 'Messi' as last_name, country, age, salary, CONCAT(phone_number, '-0'), average_rating
FROM footballer
WHERE country LIKE 'A%' AND first_name LIKE 'L%';

-- Добавить футболистов в таблицу по следующему принципу:
    -- 1) найти футболистов, название стран которых начинается на 'A', а имя на 'L';
    -- 2) добавить к id найденных футболистов 5000, изменить фамилию игроков на 'Messi', добавить к номеру телефона '-0';
    -- 3) добавить получившихся футболистов в таблицу.

SELECT *
FROM footballer
WHERE last_name = 'Messi'
