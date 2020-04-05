--apply flyway script

--get size
CREATE EXTENSION IF NOT EXISTS pgstattuple;
SELECT table_len as "Table total size" from pgstattuple('public.disabledautovacuum');
SELECT count(*) from disabledAutoVacuum;

--run benchmark from pgbench-vacuum-select.sql

--run update benchmark from pgbench-vacuum-update.sql

SELECT table_len as "Table total size" from pgstattuple('public.disabledautovacuum');
SELECT count(*) from disabledAutoVacuum;

--run benchmark from pgbench-vacuum-select.sql

VACUUM disabledAutoVacuum;

SELECT table_len as "Table total size" from pgstattuple('public.disabledautovacuum');
SELECT count(*) from disabledAutoVacuum;

--run benchmark from pgbench-vacuum-select.sql

VACUUM FULL disabledAutoVacuum;

SELECT table_len as "Table total size" from pgstattuple('public.disabledautovacuum');
SELECT count(*) from disabledAutoVacuum;

--run benchmark from pgbench-vacuum-select.sql