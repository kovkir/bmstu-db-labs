-- Триггер CLR.

-- Триггер AFTER.
-- Выводит сообщение при дабавлении информации в таблицу 'footballer'.

CREATE OR REPLACE FUNCTION insert_info_py()
RETURNS TRIGGER
AS $$
    if TD["new"]["last_name"] == "Messi":
        plpy.notice(f"The legend was recorded in the table! (age = {TD['new']['age']})")
    else:
        plpy.notice(f"Information has been added to the table footballer (age = {TD['new']['age']})")
$$ LANGUAGE PLPYTHON3U;

-- CREATE TRIGGER insert_info_trigger_py AFTER INSERT ON footballer
-- FOR ROW EXECUTE PROCEDURE insert_info_py();

INSERT INTO footballer(first_name, last_name, country, age, salary, phone_number, average_rating) 
VALUES('Lionel', 'Messi', 'Argentina', 34, 10000000, 
CONCAT('8-916-999-10-10-', (SELECT MAX(id) FROM footballer)), 10.0);

DELETE FROM footballer 
WHERE last_name = 'Messi';
