-- 2. Инструкция SELECT, использующая предикат BETWEEN.

SELECT first_name, last_name, email, work_experience
FROM coach
WHERE work_experience BETWEEN 15 AND 20
