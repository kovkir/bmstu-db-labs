-- Хранимые процедуры.
-- Рекурсивная хранимая процедуру или хранимая процедура с рекурсивным ОТВ.

-- Получить телефонные номера тренеров с id от 1 до 50, при том, что id_n+1 = id_n * 2.

CREATE OR REPLACE PROCEDURE recursive_procedure(cur_id INT, end_id INT)
AS $$
DECLARE
    cur_phone_number VARCHAR;
BEGIN
    SELECT c.phone_number
    FROM coach AS c
    WHERE c.id = cur_id
	INTO cur_phone_number;

    IF cur_id < end_id THEN
        RAISE NOTICE 'id_coach = %, phone_number = %', 
            cur_id, cur_phone_number;

        cur_id = cur_id * 2;
        CALL recursive_procedure(cur_id, 50);
    ELSE
        RAISE NOTICE 'END';
    END IF;
END;
$$ LANGUAGE PLPGSQL;

CALL recursive_procedure(1, 50);
