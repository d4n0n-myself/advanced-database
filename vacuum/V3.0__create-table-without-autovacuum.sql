CREATE TABLE disabledautovacuum
(
    id   int,
    name varchar
) WITH (autovacuum_enabled = false);

INSERT INTO public.disabledautovacuum VALUES (1,'test');