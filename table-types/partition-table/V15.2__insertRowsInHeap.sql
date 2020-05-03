INSERT INTO public.partitionHeapTable
SELECT i, i::varchar
FROM generate_series(1, 1000000) AS g(i);