-- Функции.
-- Скалярная функция.

-- Возвращает сумму денег, которую мог заработать тренер, если бы на протяжении всей карьеры имел такую же зарплату, как и сейчас.

CREATE OR REPLACE FUNCTION amount_money(salary INT, work_experience INT)
RETURNS DECIMAL AS $$
BEGIN
    RETURN salary * work_experience;
END;
$$ LANGUAGE PLPGSQL;

SELECT first_name, last_name, age, salary, work_experience, amount_money(salary, work_experience)
FROM coach;
