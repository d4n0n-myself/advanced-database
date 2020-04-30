SELECT pg_size_pretty(pg_relation_size(class.oid))
FROM pg_class class
WHERE relname LIKE 'btreeindex_name_idx';

SELECT pg_size_pretty(pg_relation_size(class.oid))
FROM pg_class class
WHERE relname LIKE 'hashindex_name_idx';

SELECT pg_size_pretty(pg_relation_size(class.oid))
FROM pg_class class
WHERE relname LIKE 'brinindex_name_idx';