-- 18. Простая инструкция UPDATE.

-- INSERT INTO footballer(id, first_name, last_name, country, age, salary, phone_number, average_rating) 
-- VALUES(5001, 'Lionel',  'Messi', 'Argentina', 34, 10000000, '8-916-999-10-10', 10.0);

UPDATE footballer 
SET first_name = 'Cristiano', last_name = 'Ronaldo', age = 36
WHERE id = 5001;

SELECT *
FROM footballer
WHERE id = 5001

-- DELETE FROM footballer
-- WHERE id = 5001
