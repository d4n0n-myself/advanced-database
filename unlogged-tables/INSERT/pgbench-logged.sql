\set nameVal random(1, 1000)
BEGIN;
    INSERT INTO postgres.public.test_logged (name) VALUES (:nameVal);
END;