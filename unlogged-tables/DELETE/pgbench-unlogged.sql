\set idVal random(1, 70000)
\set nameVal random(1, 1000)
BEGIN;
    DELETE FROM postgres.public.test_unlogged WHERE id = :idVal;
END;