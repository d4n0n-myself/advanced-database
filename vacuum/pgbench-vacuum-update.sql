\set rndVal random(1, 1000000)
BEGIN;
    UPDATE public.disabledautovacuum SET name = (:rndVal)::varchar WHERE id = 1;
END;