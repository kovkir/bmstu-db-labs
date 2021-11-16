-- 5. Инструкция SELECT, использующая предикат EXISTS с вложенным подзапросом.

SELECT first_name, last_name, country
FROM coach
where age < 35 AND EXISTS
(
    SELECT id
    FROM footballer_coach_club AS fcc
    WHERE fcc.coach_id = coach.id AND number_goals > 8
)

-- Получить имя, фамилию и страну тренера моложе 35 лет, под руководством которого один футболист в одном клубе забил больше 8 мячей.
