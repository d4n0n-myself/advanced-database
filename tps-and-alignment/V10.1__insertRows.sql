INSERT INTO varcharFirst
SELECT i::varchar,i,i,i,i,i,i,i,i,i,i,i,
       i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,
       i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,
       i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,
       i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,
       i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i
FROM generate_series(1, 1000000) AS g(i);

INSERT INTO varcharLast
SELECT i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,
       i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,
       i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,
       i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,
       i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,
       i,i,i,i,i,i,i,i,i,i,i,i,i,i,i,i::varchar
FROM generate_series(1, 1000000) AS g(i);