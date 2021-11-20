-- Создать таблицы:
-- • Table1{id: integer, var1: string, valid_from_dttm: date, valid_to_dttm: date}
-- • Table2{id: integer, var2: string, valid_from_dttm: date, valid_to_dttm: date}
-- Версионность в таблицах непрерывная, разрывов нет (если valid_to_dttm = '2018-09-05', то для следующей строки соответствующего ID valid_from_dttm = '2018-09-06', т.е. на день больше). Для каждого ID дата начала версионности и дата конца версионности в Table1 и Table2 совпадают.
-- Выполнить версионное соединение двух талиц по полю id.

DROP TABLE IF EXISTS  table_1, table_2;

CREATE TABLE IF NOT EXISTS table_1
(
	id INT,
	var1 VARCHAR(100),
	valid_from_dttm DATE,
	valid_to_dttm DATE
);

CREATE TABLE IF NOT EXISTS table_2
(
	id INT,
	var2 VARCHAR(100),
	valid_from_dttm DATE,
	valid_to_dttm DATE
);

INSERT INTO table_1(id, var1, valid_from_dttm, valid_to_dttm) VALUES
(1, 'A', '2018-09-01', '2018-09-15'),
(1, 'B', '2018-09-16', '5999-12-31');

INSERT INTO table_2(id, var2, valid_from_dttm, valid_to_dttm) VALUES
(1, 'A', '2018-09-01', '2018-09-18'),
(1, 'B', '2018-09-19', '5999-12-31');

WITH dates AS 
(
	SELECT t1.id, t1.var1, t2.var2,
		GREATEST(t1.valid_from_dttm, t2.valid_from_dttm) AS valid_from_dttm,
		LEAST(t1.valid_to_dttm, t2.valid_to_dttm) AS valid_to_dttm
	FROM 
		table_1 AS t1 JOIN 
		table_2 AS t2 ON t1.id = t2.id
)
SELECT *
FROM dates
WHERE valid_from_dttm <= valid_to_dttm
ORDER BY id, valid_from_dttm;
