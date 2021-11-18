-- 23. Инструкция SELECT, использующая рекурсивное обобщенное табличное выражение.

-- Удаление таблицы.
DROP TABLE IF EXISTS friends_table;

-- Создаем таблицу друзей футболистов.
CREATE TABLE IF NOT EXISTS friends_table
(
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(32),
    friend_id  INT
);

-- Заполняем таблицу.
INSERT INTO friends_table(id, name, friend_id) VALUES
(1, 'Messi', 3),
(2, 'Ronaldo', Null),
(3, 'Neymar', 4),
(4, 'Mbappe', 2);

SELECT *
FROM friends_table;

-- Сам рекурсивный запрос.
-- Получить цепочку друзей футболистов.
WITH RECURSIVE recursive_friends(id, name, friend_id) AS
(
    -- Определение закрепленного элемента.
    SELECT ft.id, ft.name, ft.friend_id
    FROM friends_table AS ft
    WHERE ft.id = 1
    UNION ALL
    -- Определение рекурсивного элемента
    SELECT ft.id, ft.name, ft.friend_id
    FROM friends_table AS ft
    JOIN recursive_friends AS rec ON ft.id = rec.friend_id
)
SELECT *
FROM recursive_friends;
