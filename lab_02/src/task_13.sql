-- 13. Инструкция SELECT, использующая вложенные подзапросы с уровнем вложенности 3.

SELECT *
FROM footballer_coach_club
WHERE footballer_id 
IN
(
    SELECT id 
    FROM footballer as f
    WHERE f.age > 2 * 
                (
                    SELECT AVG(c.work_experience)
                    FROM coach as c
                    WHERE c.salary > 
                                (
                                   SELECT MIN(f.salary)
                                   FROM footballer as f
                                )
                ) 
)

-- Получить всю информацию из таблицы footballer_coach_club для игроков, чей возраст минимум в два раза больше среднего опыта работы тренеров, чья зарплата превышает минимальную зарплату футболистов. 
