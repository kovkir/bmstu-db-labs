-- Определяемый пользователем тип данных CLR.

CREATE TYPE name_price AS
(
    surname_footballer VARCHAR,
    surname_coach VARCHAR,
    name_club VARCHAR,
    number_goals INT
);

-- Пулучть фамилии футбулистов, тренеров, названия клубов и кол-во голов, забитых данными футболистами под руководством данных тренеров за данные клубы (если кол-во голов больше заданного значения).  

CREATE OR REPLACE FUNCTION get_inf_about_goals_scored_py(number_goals INT)
RETURNS SETOF name_price
AS $$
    query = '''
        SELECT 
            f.last_name  AS surname_footballer,
            co.last_name AS surname_coach,
            cl.name      AS name_club, 
            fcc.number_goals
        FROM 
            footballer_coach_club AS fcc 
            JOIN footballer AS f  ON fcc.footballer_id = f.id
            JOIN coach      AS co ON fcc.id = co.id
            JOIN club       AS cl ON fcc.id = cl.id 
        WHERE
			fcc.number_goals > %d
            ''' %(number_goals)

    res_query = plpy.execute(query)
    
    if res_query is not None:
        return res_query

$$ LANGUAGE PLPYTHON3U;

SELECT * 
FROM get_inf_about_goals_scored_py(9);
