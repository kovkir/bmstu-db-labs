-- 24. Оконные функции. Использование конструкций MIN/MAX/AVG OVER().

SELECT id, name, country, AVG(foundation_date) OVER (PARTITION BY country) AS avg_foundation_date
FROM club

-- вывести id, название, страну клуба, а также среднюю дату основания клубов в этой стране.
