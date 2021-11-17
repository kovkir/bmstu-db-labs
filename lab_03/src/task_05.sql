-- Хранимые процедуры.
-- Хранимая процедура без параметров или с параметрами.

-- Увеличить тренеру с заданным id зарплаты на заданную сумму.

CREATE OR REPLACE PROCEDURE change_salary(id_coach INT, salary_increase INT)
AS $$
BEGIN
    UPDATE coach
    SET salary = salary + salary_increase
    WHERE id = id_coach;
END;
$$ LANGUAGE PLPGSQL;

CALL change_salary(1, 505);

SELECT id, first_name, last_name, age, salary
FROM coach
ORDER BY id;
