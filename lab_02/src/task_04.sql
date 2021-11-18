-- 4. Инструкция SELECT, использующая предикат IN с вложенным подзапросом.

SELECT *
FROM footballer_coach_club
WHERE footballer_id IN
(
    SELECT id
    FROM footballer
    where age < 24 AND average_rating > 8
)
AND club_id IN
(
    SELECT id
    FROM club
    WHERE name LIKE 'Real%'
)
AND number_goals > 5

-- Получить всю информацию из таблицы footballer_coach_club для игроков моложе 24 лет, средним рейтингом больше 8, забивших больше 5 голов в клубе, название которого начинается со слова Real.
