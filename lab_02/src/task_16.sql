-- 16. Однострочная инструкция INSERT, выполняющая вставку в таблицу одной строки значений.

INSERT INTO footballer(id, first_name, last_name, country, age, salary, phone_number, average_rating) 
VALUES(5001, 'Lionel',  'Messi', 'Argentina', 34, 10000000, '8-916-999-10-10', 10.0);

SELECT *
FROM footballer
WHERE last_name = 'Messi'
