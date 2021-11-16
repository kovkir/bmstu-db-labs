-- 23. Инструкция SELECT, использующая рекурсивное обобщенное табличное выражение.

-- Создаем таблицу друзей футболистов.
CREATE TABLE friends_table
(
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(32),
    friend_id  INT
);

-- Заполняем таблицу.
INSERT INTO friends_table(id, name, friend_id) 
VALUES(1, 'Messi', 3);

INSERT INTO friends_table(id, name, friend_id) 
VALUES(2, 'Ronaldo', Null);

INSERT INTO friends_table(id, name, friend_id) 
VALUES(3, 'Neymar', 4);

INSERT INTO friends_table(id, name, friend_id) 
VALUES(4, 'Mbappe', 2);

SELECT *
FROM friends_table;

-- Сам рекурсивный запрос.
-- Получить цепочку друзей футболистов.
WITH RECURSIVE recursive_friends(id, name, friend_id) AS
(
    -- Определение закрепленного элемента.
    SELECT id, name, friend_id
    FROM friends_table AS ft
    WHERE ft.id = 1
    UNION ALL
    -- Определение рекурсивного элемента
    SELECT ft.id, ft.name, ft.friend_id
    FROM friends_table AS ft
    INNER JOIN recursive_friends AS rec ON ft.id = rec.friend_id
)
SELECT *
FROM recursive_friends;

-- Удаление таблицы.
DROP TABLE friends_table;
