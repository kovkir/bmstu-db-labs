-- Хранимые процедуры.
-- Хранимая процедура с курсором.

-- Получить название и страну располажения клубов, основанных между заданными годами. Также получить сам год основания клуба.

CREATE OR REPLACE PROCEDURE club_foundation_date(beg_year INT, end_year INT)
AS $$
DECLARE 
    cur_club RECORD;
    club_cursor cursor FOR
        SELECT *
        FROM club AS c
        WHERE c.foundation_date >= beg_year AND c.foundation_date <= end_year;
BEGIN
    OPEN club_cursor;
    LOOP
        FETCH club_cursor INTO cur_club;
        
        RAISE NOTICE 'name = %, country = %, foundation_date = %', 
            cur_club.name, cur_club.country, cur_club.foundation_date;

        EXIT WHEN NOT FOUND;
    END LOOP;
    CLOSE club_cursor;
END;
$$ LANGUAGE PLPGSQL;

CALL club_foundation_date(1915, 1917);
