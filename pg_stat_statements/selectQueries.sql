SELECT query,
       calls,
       total_time,
       rows,
       100.0 * shared_blks_read / nullif(shared_blks_hit + shared_blks_read, 0) as read_percent,
       calls / total_time                                                       as "TPS"
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 20;

SELECT pg_stat_statements_reset();

SELECT pg_reload_conf();