-- Задача на защите.

-- Написать процедуру для передачи футболиста от клуба к клубу.
-- Пишите имя/id футболиста, потом название/id клуба, куда перенести.

CREATE OR REPLACE PROCEDURE club_change(id_f INT, id_c INT)
AS $$
BEGIN
    UPDATE footballer_coach_club 
    SET club_id = id_c
    WHERE id_f = id_f;
END;
$$ LANGUAGE PLPGSQL;

CALL club_change(1, 3);

SELECT f.id, f.first_name,
(
    SELECT c.name
    FROM club AS c
    WHERE c.id =
	(
        SELECT fcc.club_id
        FROM footballer_coach_club as fcc
        WHERE fcc.footballer_id = f.id
    )
) AS club_name
FROM footballer AS f
WHERE f.id = 1;
