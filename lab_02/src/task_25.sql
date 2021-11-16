-- 25. Оконные фнкции для устранения дублей.
-- Придумать запрос, в результате которого в данных появляются полные дубли. Устранить дублирующиеся строки с использованием функции ROW_NUMBER().

WITH table_with_duplicates AS
(
    SELECT *
    FROM club

    UNION ALL

    SELECT *
    FROM club
),
tmp_table AS
(   
    SELECT *, ROW_NUMBER() OVER (PARTITION BY id) AS number
    FROM table_with_duplicates
)
SELECT *
FROM tmp_table
WHERE number = 1
