\set id random(1,1000000)
BEGIN;
    SELECT * FROM public.partitiontable WHERE name = :id::varchar;
COMMIT;