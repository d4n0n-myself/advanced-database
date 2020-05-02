SELECT pg_size_pretty(pg_relation_size(class.oid))
FROM pg_class class
WHERE relname LIKE 'btreeindex2_content_idx';

SELECT pg_size_pretty(pg_relation_size(class.oid))
FROM pg_class class
WHERE relname LIKE 'ginindex_content_idx';

SELECT pg_size_pretty(pg_relation_size(class.oid))
FROM pg_class class
WHERE relname LIKE 'gistindex_content_idx';