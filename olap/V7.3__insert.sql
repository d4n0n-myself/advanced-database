INSERT INTO public.complextest
SELECT i, (i, i + 1)::mycomplex
FROM generate_series(1, 1000) AS g(i);