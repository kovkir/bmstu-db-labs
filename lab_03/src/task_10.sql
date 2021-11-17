-- DML триггеры.
-- Триггер INSTEAD OF.

-- Добавить информацию о футболисте в таблицу, если его зарплата выше средней среди футболистов, иначе вывести соответствующее сообщение.

CREATE OR REPLACE FUNCTION insert_info_with_limitation()
RETURNS TRIGGER
AS $$
BEGIN
    IF new.salary < (SELECT AVG(salary) FROM footballer) THEN
        RAISE NOTICE 'Too low salary';
        RETURN NULL;
    ELSE
        INSERT INTO footballer(first_name, last_name, country, age, salary, phone_number, average_rating) 
        VALUES(new.first_name, new.last_name, new.country, new.age, new.salary, new.phone_number, new.average_rating);

        RAISE NOTICE 'Information has been added to the table footballer';
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE PLPGSQL;

DROP VIEW footballer_view;
CREATE VIEW footballer_view
AS
    SELECT *
    FROM footballer;

CREATE TRIGGER insert_with_lim_trigger INSTEAD OF INSERT ON footballer_view
FOR ROW EXECUTE PROCEDURE insert_info_with_limitation();

DELETE FROM footballer 
WHERE last_name = 'Messi';

INSERT INTO footballer_view(first_name, last_name, country, age, salary, phone_number, average_rating) 
VALUES('Lionel', 'Messi', 'Argentina', 34, 10000000, 
CONCAT('8-916-999-10-10-', (SELECT MAX(id) FROM footballer)), 10.0);

SELECT *
FROM footballer
WHERE last_name = 'Messi';
