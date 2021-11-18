-- 11. Создание новой временной локальной таблицы из результирующего набора данных инструкции SELECT.

DROP TABLE IF EXISTS inter;

SELECT name, country, city, email
INTO inter
FROM club
WHERE name LIKE '%Inter';

-- Создание новой временной локальной таблицы из выборки данных по клубам, название которых заканчивается словом Inter.

SELECT *
FROM inter
