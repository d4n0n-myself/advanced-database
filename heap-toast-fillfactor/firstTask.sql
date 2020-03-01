--#region create table and set storage
CREATE OR REPLACE FUNCTION myCreateTable(tableName VARCHAR, storage VARCHAR) RETURNS void AS
$$
BEGIN
    EXECUTE format('CREATE TABLE IF NOT EXISTS %s (
        id   bigint,
        name varchar
    );', tableName);

    EXECUTE format('TRUNCATE %s', tableName);

    EXECUTE format('ALTER TABLE public.%s ALTER COLUMN name SET STORAGE %s;', tableName, storage);
END
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

SELECT myCreateTable('test_main', 'MAIN');
SELECT myCreateTable('test_plain', 'PLAIN');
SELECT myCreateTable('test_extended', 'EXTENDED');
SELECT myCreateTable('test_external', 'EXTERNAL');
--#endregion

--#region check storage
SELECT a.attname,
       t.typname,
       CASE
           WHEN a.attstorage = 'p' THEN 'plain'
           WHEN a.attstorage = 'e' THEN 'external'
           WHEN a.attstorage = 'x' THEN 'extended'
           WHEN a.attstorage = 'm' THEN 'main' END
FROM pg_catalog.pg_attribute a
         INNER JOIN pg_type t ON t.OID = a.atttypid
where attrelid = (SELECT pg_class.oid
                  FROM pg_class
                  WHERE pg_class.relname = 'test_external');
--#endregion

--#region insert values
CREATE OR REPLACE FUNCTION doInsertLoop(tab text) RETURNS void AS
$$
BEGIN
    FOR i IN 1..100
        LOOP
            EXECUTE format('INSERT INTO %s VALUES (%s, %s)', tab, i, array_to_string(
                    ARRAY(SELECT generate_series.generate_series::integer FROM generate_series(1, 1045)), ''
                ));
        END LOOP;
END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;
SELECT doInsertLoop('test_main');
SELECT doInsertLoop('test_plain');
SELECT doInsertLoop('test_extended');
SELECT doInsertLoop('test_external');
--#endregion

--#region show size of values
CREATE OR REPLACE FUNCTION showSize(tab text)
    RETURNS TABLE
            (
                id          bigint,
                name        varchar,
                size_pretty text,
                sizeInKb    text
            )
AS
$$
BEGIN
    RETURN QUERY EXECUTE format('SELECT id,
       name,
       pg_size_pretty(pg_column_size(name)::bigint),
       pg_column_size(name)::bigint / 1024 || '' KB '' as sizeInKB
FROM public.%s;', tab);
END
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

SELECT *
FROM showSize('test_main');
SELECT *
FROM showSize('test_plain');
SELECT *
FROM showSize('test_external');
SELECT *
FROM showSize('test_extended');
--#endregion

--#region show size of original table
CREATE OR REPLACE function sizeOfRelation(tablename varchar)
    RETURNS varchar
AS
$$
DECLARE
    size varchar;
BEGIN
    EXECUTE format('SELECT pg_size_pretty(pg_relation_size(c.OID)) AS "Size of %s" ' ||
                   'FROM pg_class c where relname = ''%s'';', tablename, tablename) INTO size;
    RETURN size;
END
$$ LANGUAGE plpgsql;
SELECT sizeofrelation('test_main');
SELECT sizeofrelation('test_plain');
SELECT sizeofrelation('test_extended');
SELECT sizeofrelation('test_external');
--#endregion

--#region show data of original table
select count(*)
from test_main;
select count(*)
from test_plain;
select count(*)
from test_extended;
select count(*)
from test_external;
--#endregion

--#region show size of toast table
CREATE OR REPLACE function sizeToast(tablename varchar)
    RETURNS VARCHAR
AS
$$
DECLARE
    size varchar;
BEGIN
    EXECUTE format('SELECT pg_size_pretty(pg_relation_size(c.OID)) AS "Size of %s" ' ||
                   'FROM pg_class c where relname = ''pg_toast_%s'';', tablename,
                   (SELECT oid FROM pg_class WHERE relname = tablename)) INTO size;
    RETURN size;
END
$$ LANGUAGE plpgsql;
select sizeToast('test_main');
select sizeToast('test_plain');
select sizeToast('test_extended');
select sizeToast('test_external');
--#endregion

--#region show data of toast table
CREATE OR REPLACE function listToast(tablename varchar)
    RETURNS TABLE
            (
                chunk_id   oid,
                chunk_seq  int,
                chunk_data bytea
            )
AS
$$
BEGIN
    RETURN QUERY EXECUTE format('SELECT * FROM pg_toast.pg_toast_%s ',
                                (SELECT oid FROM pg_class WHERE relname = tablename));
END
$$ LANGUAGE plpgsql;
select count(*)
from listToast('test_main');
select count(*)
from listToast('test_plain');
select count(*)
from listToast('test_extended');
select count(*)
from listToast('test_external');
--#endregion

--#region show header/pages
CREATE EXTENSION pageinspect;
SELECT *
FROM page_header(get_raw_page('test_main', 0));
SELECT *
FROM page_header(get_raw_page('test_plain', 0));
SELECT *
FROM page_header(get_raw_page('test_external', 0));
SELECT *
FROM page_header(get_raw_page('test_extended', 0));
--#endregion