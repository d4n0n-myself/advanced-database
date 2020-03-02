--#region create table and set fillfactor
CREATE OR REPLACE FUNCTION myCreateTableWithFillfactor(tableName VARCHAR, fillfactor int) RETURNS void AS
$$
BEGIN
    EXECUTE format('CREATE TABLE IF NOT EXISTS %s  (
    id int,
    name varchar(100),
    date1 date,
    date2 date
) WITH (FILLFACTOR = %s);', tableName, fillfactor);
END
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

SELECT myCreateTableWithFillfactor('fillfactor50', 50);
SELECT myCreateTableWithFillfactor('fillfactor75', 75);
SELECT myCreateTableWithFillfactor('fillfactor90', 90);
SELECT myCreateTableWithFillfactor('fillfactor100', 100);
--#endregion

--#region insert values
CREATE OR REPLACE FUNCTION doInsertLoop10000(tab text) RETURNS void AS
$$
BEGIN
    FOR i IN 1..10000
        LOOP
            EXECUTE format('INSERT INTO %s VALUES (%s, %s)', tab, i, array_to_string(
                    ARRAY(SELECT generate_series.generate_series::integer FROM generate_series(1, 29)), ''
                ));
        END LOOP;
END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

select doInsertLoop10000('fillfactor50');
select doInsertLoop10000('fillfactor75');
select doInsertLoop10000('fillfactor90');
select doInsertLoop10000('fillfactor100');
--#endregion

--#region update value
CREATE OR REPLACE FUNCTION updateVarcharValue(tab text) RETURNS void AS
$$
BEGIN
    EXECUTE format('UPDATE %s SET name = name || name;', tab);
END
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

select updateVarcharValue('fillfactor50');
select updateVarcharValue('fillfactor75');
select updateVarcharValue('fillfactor90');
select updateVarcharValue('fillfactor100');
--#endregion
