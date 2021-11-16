-- 9. Инструкция SELECT, использующая простое выражение CASE.

SELECT name, city, foundation_date,
    CASE foundation_date
        WHEN (SELECT MIN(foundation_date) FROM club)
        THEN 'Самый старый клуб'

        WHEN (SELECT MAX(foundation_date) FROM club)
        THEN 'Самый молодой клуб'

        ELSE 'Cредний по возрасту клуб'
    END AS club_age_message

FROM club
ORDER BY foundation_date

-- Получить имя клуба, город, в котором он находится, дату его основания и сообщение о возрасте клуба. Отсортировать данные по возрастанию года основания клуба.
