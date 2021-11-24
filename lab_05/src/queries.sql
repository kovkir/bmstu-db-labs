-- 1. Из таблиц базы данных, созданной в первой лабораторной работе, извлечь данные в JSON.

\t
\a

\o /Users/kirill/Documents/bmstu/db/lab_05/src/coach.json
SELECT row_to_json(c) FROM coach AS c;

\o /Users/kirill/Documents/bmstu/db/lab_05/src/footballer.json
SELECT row_to_json(f) FROM footballer AS f;

\o /Users/kirill/Documents/bmstu/db/lab_05/src/club.json
SELECT row_to_json(c) FROM club AS c;

\o /Users/kirill/Documents/bmstu/db/lab_05/src/footballer_coach_club.json
SELECT row_to_json(fcc) FROM footballer_coach_club AS fcc;

-- 2. Выполнить загрузку и сохранение JSON файла в таблицу. Созданная таблица после всех манипуляций должна соответствовать таблице базы данных, созданной в первой лабораторной работе.

DROP TABLE IF EXISTS club_from_json;

CREATE TABLE IF NOT EXISTS club_from_json
(
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(100) UNIQUE NOT NULL,
    country VARCHAR(100) NOT NULL,
    city    VARCHAR(100) NOT NULL,
    email   VARCHAR(100) UNIQUE,
    foundation_date INTEGER NOT NULL,
    check (country != ''),
    check (city != ''),
    check (email like '%_@_%._%'),
    check ((foundation_date >= 1857) and (foundation_date) <= 2021)
);

DROP TABLE IF EXISTS club_from_json;

CREATE TABLE IF NOT EXISTS json_table
(
    data JSONB
);

\COPY json_table (data) FROM '/Users/kirill/Documents/bmstu/db/lab_05/src/club.json';

INSERT INTO club_from_json (id, name, country, city, email, foundation_date)
SELECT (data->>'id')::INT, data->>'name', data->>'country', data->>'city', data->>'email',
       (data->>'foundation_date')::INT
FROM json_table;

SELECT * 
FROM club_from_json;

-- 3. Создать таблицу, в которой будет атрибут с типом JSON. Заполнить атрибут правдоподобными данными с помощью команд INSERT.

DROP TABLE IF EXISTS footballer_from_jsonb;

CREATE TEMP TABLE IF NOT EXISTS footballer_from_jsonb
(
    data JSONB
);

INSERT INTO footballer_from_jsonb (data) VALUES
('{"id" : 1, "last_name" : "Messi", "country" : "Argentina", "age" : 34, "average_rating" : 10, "personal_data" : {"salary" : 10000000, "phone_number" : "8-916-999-10-10"}}'),
('{"id" : 2, "last_name" : "Ronaldo", "country" : "Portugal", "age" : 36, "average_rating" : 9.5, "personal_data" : {"salary" : 9500150, "phone_number" : "8-916-888-07-07"}}'),
('{"id" : 3, "last_name" : "Neymar", "country" : "Brazil", "age" : 29, "average_rating" : 8.9, "personal_data" : {"salary" : 8300400, "phone_number" : "8-916-777-10-10"}}');

SELECT * 
FROM footballer_from_jsonb;

-- 4. Выполнить следующие действия:

-- 1) Извлечь JSON фрагмент из JSON документа.

SELECT data->'last_name' AS last_name,
       data->'personal_data' AS personal_data
FROM footballer_from_json;

-- 2) Извлечь значения конкретных узлов или атрибутов JSON документа.

SELECT data->'last_name' AS last_name,
       data->'personal_data'->'salary' AS salary,
       data->'personal_data'->'phone_number' AS phone_number
FROM footballer_from_json;

-- 3) Выполнить проверку существования узла или атрибута.

CREATE OR REPLACE FUNCTION key_exists_check(json_date JSONB, key TEXT)
RETURNS BOOLEAN
AS $$
BEGIN
    RETURN (json_date->key) IS NOT NULL;
END;
$$ LANGUAGE PLPGSQL;

SELECT key_exists_check(footballer_from_json.data, 'country')
FROM footballer_from_json;

-- 4) Изменить JSON документ.

UPDATE footballer_from_json
SET data = data || '{"personal_data" : {"salary" : 7300400, "phone_number" : "8-916-777-10-10"}}'::jsonb 
WHERE (data->>'last_name')::VARCHAR = 'Neymar';

SELECT * 
FROM footballer_from_json;

-- 5) Разделить JSON документ на несколько строк по узлам.

-- jsonb_array_elements - Разворачивает массив JSON в набор значений JSON.

DROP TABLE IF EXISTS footballer_from_json;

CREATE TEMP TABLE IF NOT EXISTS footballer_from_json
(
    data JSON
);

INSERT INTO footballer_from_json VALUES
('[
    {"id" : 1, "last_name" : "Messi", "country" : "Argentina", "age" : 34, "average_rating" : 10, "personal_data" : {"salary" : 10000000, "phone_number" : "8-916-999-10-10"}},
    {"id" : 2, "last_name" : "Ronaldo", "country" : "Portugal", "age" : 36, "average_rating" : 9.5, "personal_data" : {"salary" : 9500150, "phone_number" : "8-916-888-07-07"}},
    {"id" : 3, "last_name" : "Neymar", "country" : "Brazil", "age" : 29, "average_rating" : 8.9, "personal_data" : {"salary" : 8300400, "phone_number" : "8-916-777-10-10"}}
]');

SELECT jsonb_array_elements(data::jsonb)
FROM footballer_from_json;
