-- 8. Инструкция SELECT, использующая скалярные подзапросы в выражениях столбцов.

SELECT first_name, last_name,
(
	SELECT fcc.number_goals
	FROM footballer_coach_club AS fcc
	WHERE fcc.id = footballer.id
)
FROM footballer
WHERE salary > (SELECT AVG(salary) FROM footballer)

-- Получить имя, фамилию и кол-во голов футболиста, забитых за один клуб при одной тренере при условии, что зарплата футболиста больше средней.
