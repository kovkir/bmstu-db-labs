-- DML триггеры.
-- Триггер AFTER.

-- Выводит сообщение при дабавлении информации в таблицу 'footballer'.

CREATE OR REPLACE FUNCTION insert_info()
RETURNS TRIGGER
AS $$
BEGIN
    RAISE NOTICE 'Information has been added to the table footballer';
    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

-- CREATE TRIGGER insert_info_trigger AFTER INSERT ON footballer
-- FOR ROW EXECUTE PROCEDURE insert_info();

INSERT INTO footballer(first_name, last_name, country, age, salary, phone_number, average_rating) 
VALUES('Lionel', 'Messi', 'Argentina', 34, 10000000, 
CONCAT('8-916-999-10-10-', (SELECT MAX(id) FROM footballer)), 10.0);

SELECT *
FROM footballer
WHERE last_name = 'Messi';

DELETE FROM footballer 
WHERE last_name = 'Messi';
