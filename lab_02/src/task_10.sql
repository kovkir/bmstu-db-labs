-- 10. Инструкция SELECT, использующая поисковое выражение CASE.

SELECT first_name, last_name, work_experience,
    CASE
        WHEN (work_experience > 30)
        THEN 'Профессионал своего дела'

        WHEN (work_experience > 10)
        THEN 'Опытный тренер'

        ELSE 'Начинающий тренер'
    END AS qualification_message

FROM coach

-- Получить имя, фамилию и стаж работы тренера, а также сообщение об его квалификации.
