CREATE TABLE public.buffers1k (
    id int,
    name varchar
);

CREATE TABLE public.buffers10k (
    id int,
    name varchar
);

CREATE TABLE public.buffers100k (
    id int,
    name varchar
);

INSERT INTO public.buffers1k SELECT i, i::varchar FROM generate_series(1,1000) AS g(i);
INSERT INTO public.buffers10k SELECT i, i::varchar FROM generate_series(1,10000) AS g(i);
INSERT INTO public.buffers100k SELECT i, i::varchar FROM generate_series(1,100000) AS g(i);

CREATE EXTENSION IF NOT EXISTS pg_prewarm;

SELECT pg_prewarm('buffers1k');
SELECT pg_prewarm('buffers10k');
SELECT pg_prewarm('buffers100k');