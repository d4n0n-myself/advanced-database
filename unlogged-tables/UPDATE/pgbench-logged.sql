\set idVal random(1, 70000)
\set nameVal random(1, 1000)
BEGIN;
    UPDATE postgres.public.test_logged SET name = (:nameVal)::varchar || (:nameVal) WHERE id = :idVal;
END;