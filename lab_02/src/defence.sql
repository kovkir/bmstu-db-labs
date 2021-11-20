-- Задача на защите.

-- Найти всех футболистов с одинаковыми именами и выписать из каких они клубов.

SELECT f1.id, f1.first_name,
(
    SELECT c.name
    FROM club AS c
    WHERE c.id =
	(
        SELECT fcc.club_id
        FROM footballer_coach_club as fcc
        WHERE fcc.footballer_id = f1.id
    )
) AS club_name
FROM footballer AS f1 
WHERE f1.first_name = ANY
(
    SELECT first_name
    FROM footballer AS f2
    WHERE NOT f1.id = f2.id
)
ORDER BY first_name
