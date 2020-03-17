\set nameVal random(1, 1000)
BEGIN;
    INSERT INTO postgres.public.test_unlogged (name) VALUES (:nameVal);
END;