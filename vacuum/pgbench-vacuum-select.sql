BEGIN;
    SELECT name FROM public.disabledautovacuum WHERE id = 1;
END;