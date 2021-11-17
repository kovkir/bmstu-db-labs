-- Хранимые процедуры.
-- Хранимая процедура доступа к метаданным.

-- https://postgrespro.ru/docs/postgresql/9.6/infoschema-columns

-- Получить названия столбцов (атрибутов) и их тип. Также вывести информацию о том, может ли столбец содержать NULL.

CREATE OR REPLACE PROCEDURE get_metadata(my_table_name VARCHAR)
AS $$
DECLARE
    cur_column RECORD;
    my_cursor cursor FOR
        SELECT *
        FROM information_schema.columns
        WHERE my_table_name = table_name;
BEGIN
    OPEN my_cursor;
    LOOP
        FETCH my_cursor INTO cur_column;

        RAISE NOTICE 'column_name = %, data_type = %, is_nullable = %', 
            cur_column.column_name, cur_column.data_type, cur_column.is_nullable;

        EXIT WHEN NOT FOUND;
    END LOOP;
    CLOSE my_cursor;
END;
$$ LANGUAGE PLPGSQL;

CALL get_metadata('footballer');
