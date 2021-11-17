-- Функции.
-- Рекурсивная функция или функция с рекурсивным ОТВ.

-- Удаление таблицы.
DROP TABLE IF EXISTS friends_table;

-- Создаем таблицу друзей футболистов.
CREATE TABLE IF NOT EXISTS friends_table
(
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(32),
    friend_id INT
);

-- Заполняем таблицу.
INSERT INTO friends_table(id, name, friend_id) VALUES
(1, 'Messi', 3),
(2, 'Ronaldo', Null),
(3, 'Neymar', 4),
(4, 'Mbappe', 2);

SELECT *
FROM friends_table;

-- Получить цепочку друзей футболистов.

CREATE OR REPLACE FUNCTION friends(start_id INT)
RETURNS TABLE
(
    id INT,
    name VARCHAR,
    friend_id INT
)
AS $$
BEGIN
    RETURN QUERY
    WITH RECURSIVE recursive_friends(id, name, friend_id) AS
    (
        -- Определение закрепленного элемента.
        SELECT ft.id, ft.name, ft.friend_id
        FROM friends_table AS ft
        WHERE ft.id = start_id
        UNION ALL
        -- Определение рекурсивного элемента
        SELECT ft.id, ft.name, ft.friend_id
        FROM friends_table AS ft
        INNER JOIN recursive_friends AS rec ON ft.id = rec.friend_id
    )
    SELECT *
    FROM recursive_friends;
END;
$$ LANGUAGE PLPGSQL;

SELECT *
FROM friends(1);
