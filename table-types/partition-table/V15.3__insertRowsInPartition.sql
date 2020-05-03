INSERT INTO public.partitionTable
SELECT i, i::varchar
FROM generate_series(1, 1000000) AS g(i);