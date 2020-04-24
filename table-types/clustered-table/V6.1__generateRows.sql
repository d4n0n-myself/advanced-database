INSERT INTO public.clustered
SELECT (random() * 10000), 'test'
FROM generate_series(1, 10000);

ANALYZE public.clustered;