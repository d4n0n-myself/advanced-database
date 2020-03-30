CREATE OR REPLACE FUNCTION addDatabaseRule(tableName VARCHAR, startVal INTEGER, endVal INTEGER) RETURNS void AS
$$
BEGIN
    EXECUTE format('CREATE OR REPLACE RULE redirect_insert_to_%s
    AS ON INSERT TO public.users
    WHERE NEW.id >= %s AND NEW.id < %s
    DO INSTEAD INSERT INTO %s
               VALUES (NEW.id, NEW.name);', tableName, startVal, endVal, tableName);
END
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

SELECT addDatabaseRule('users_1', 0, 100000);
SELECT addDatabaseRule('users_2', 100000, 200000);
SELECT addDatabaseRule('users_3', 200000, 300000);
SELECT addDatabaseRule('users_4', 300000, 400000);
SELECT addDatabaseRule('users_5', 400000, 500000);
SELECT addDatabaseRule('users_6', 500000, 600000);
SELECT addDatabaseRule('users_7', 600000, 700000);
SELECT addDatabaseRule('users_8', 700000, 800000);
SELECT addDatabaseRule('users_9', 800000, 900000);
SELECT addDatabaseRule('users_10', 900000, 1000000);