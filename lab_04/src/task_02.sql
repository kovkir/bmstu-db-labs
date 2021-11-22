-- Пользовательская агрегатная функция CLR.

-- Возвращает кол-во тренеров моложе заданного возраста, которые могли заработать более 100 000 000 евро, если бы на протяжении всей карьеры имели такую же зарплату, что и сейчас.

CREATE OR REPLACE FUNCTION find_number_rich_people_py(age INT)
RETURNS INT 
AS $$
    query = '''
        SELECT amount_money_py(salary, work_experience) AS amount_money 
        FROM coach 
        WHERE age < %d;
            ''' %(age)

    res = plpy.execute(query)
    
    if res is not None:
        quantity = 0;

        for coach in res:
            if coach["amount_money"] > 100000000:
                quantity += 1        
        return quantity

$$ LANGUAGE PLPYTHON3U;

SELECT find_number_rich_people_py(60)
