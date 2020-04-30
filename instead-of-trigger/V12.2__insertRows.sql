INSERT INTO insteadOfTrigger
SELECT i::varchar, i
FROM generate_series(1, 1000) AS g(i);