-- Определяемая пользователем скалярная функция CLR.

-- Возвращает сумму денег, которую мог заработать тренер, если бы на протяжении всей карьеры имел такую же зарплату, как и сейчас.

-- CREATE EXTENSION plpython3u;

CREATE OR REPLACE FUNCTION amount_money_py(salary INT, work_experience INT)
RETURNS DECIMAL 
AS $$
    return salary * work_experience
$$ LANGUAGE PLPYTHON3U;

SELECT first_name, last_name, age, salary, work_experience, 
       amount_money_py(salary, work_experience) AS amount_money
FROM coach;
