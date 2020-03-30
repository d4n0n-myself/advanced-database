CREATE TABLE public.users
(
    id   integer,
    name varchar
);

create index users_idx on public.users (id);

CREATE OR REPLACE FUNCTION createInheritedTable(tableName VARCHAR) RETURNS void AS
$$
BEGIN
    EXECUTE format('create table %s (LIKE public.users INCLUDING ALL) inherits (public.users);', tableName);
END
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

SELECT createInheritedTable('users_1');
SELECT createInheritedTable('users_2');
SELECT createInheritedTable('users_3');
SELECT createInheritedTable('users_4');
SELECT createInheritedTable('users_5');
SELECT createInheritedTable('users_6');
SELECT createInheritedTable('users_7');
SELECT createInheritedTable('users_8');
SELECT createInheritedTable('users_9');
SELECT createInheritedTable('users_10');

CREATE OR REPLACE FUNCTION addPartitionCheck(tableName VARCHAR, startVal INTEGER, endVal INTEGER) RETURNS void AS
$$
BEGIN
    EXECUTE format('ALTER TABLE %s
    ADD CONSTRAINT partition_check CHECK (id >= %s and id < %s);', tableName, startVal, endVal);
END
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

SELECT addPartitionCheck('users_1', 0, 100000);
SELECT addPartitionCheck('users_2', 100000, 200000);
SELECT addPartitionCheck('users_3', 200000, 300000);
SELECT addPartitionCheck('users_4', 300000, 400000);
SELECT addPartitionCheck('users_5', 400000, 500000);
SELECT addPartitionCheck('users_6', 500000, 600000);
SELECT addPartitionCheck('users_7', 600000, 700000);
SELECT addPartitionCheck('users_8', 700000, 800000);
SELECT addPartitionCheck('users_9', 800000, 900000);
SELECT addPartitionCheck('users_10', 900000, 1000000);