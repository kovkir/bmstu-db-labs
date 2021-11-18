-- 6. Инструкция SELECT, использующая предикат сравнения с квантором.

SELECT last_name, salary, age
FROM footballer
WHERE salary > ALL
(
	SELECT salary
	FROM coach
	WHERE work_experience > 30
)

-- Получить фамилию, зарплату и возраст футболистов, зарплата которых выше зарплаты всех тренеров, стаж работы которых больше 30 лет.
