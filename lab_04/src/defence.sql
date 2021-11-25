-- Защита сразу для трёх лабораторных (lab_04, lab_05, lab_06).

-- Составить список всех тренеров, работавших с 10 лучшими футболистами.
-- Использовать процедуру CLR.
-- Вывести таблицу в JSON формате.

DROP TABLE IF EXISTS best_coach;

CREATE TABLE IF NOT EXISTS best_coach
(
    surname_coach VARCHAR,
    salary_footballer VARCHAR,
    number_goals INT
);

CREATE OR REPLACE PROCEDURE search_best_coaches()
AS $$
    query = '''
        SELECT 
            co.last_name AS surname_coach,
            f.salary     AS salary_footballer,
            fcc.number_goals
        FROM 
            footballer_coach_club AS fcc 
            JOIN footballer AS f  ON fcc.footballer_id = f.id
            JOIN coach      AS co ON fcc.id = co.id
        WHERE
			fcc.number_goals = 10
        ORDER BY f.salary DESC
            '''

    res = plpy.execute(query)
    
    if res is not None:
        for i in range(10):
        
            plan = plpy.prepare("INSERT INTO best_coach VALUES($1, $2, $3)", 
                ["VARCHAR", "VARCHAR", "INT"])

            plpy.execute(plan, 
                [res[i]["surname_coach"], res[i]["salary_footballer"], res[i]["number_goals"]])

$$ LANGUAGE PLPYTHON3U;

CALL search_best_coaches();

SELECT *
FROM best_coach

\t
\a

\o /Users/kirill/Documents/bmstu/db/lab_04/src/coach.json
SELECT row_to_json(bc) FROM best_coach AS bc;
