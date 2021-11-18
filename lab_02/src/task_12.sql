-- 12. Инструкция SELECT, использующая вложенные коррелированные подзапросы в качестве производных таблиц в предложении FROM.

SELECT first_name, last_name, age, number_goals
FROM footballer AS F 
JOIN 
(
    SELECT footballer_id, number_goals
    FROM footballer_coach_club
    WHERE number_goals = 10
) AS FCC ON F.id = FCC.footballer_id

-- Получить имя, фамилию, возраст футболиста, забившего за один клуб при одной тренере ровно 10 голов.
