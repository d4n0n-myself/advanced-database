CREATE OR REPLACE FUNCTION insertIntoUsers(prevId INTEGER, newName VARCHAR) RETURNS void AS
$$
DECLARE
    newId integer = 0;
    count integer = 0;
BEGIN
    count = (SELECT count(*) FROM users WHERE id = prevId and xmin::text = (txid_current() % (2^32)::bigint)::text);
    FOR i in 1..count
        LOOP
            newId = (SELECT (((prevId / 100000) + 1 + (random() * 10)::int) % 10)::int * 100000 +
                            (random() * 100000)::int);
            INSERT INTO users VALUES (newId, newName);
        END LOOP;
END
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

CREATE OR REPLACE RULE redirect_update_to_users
    AS ON UPDATE TO public.users
    DO INSTEAD (SELECT insertIntoUsers(OLD.id, NEW.name);
        DELETE FROM users where id = OLD.id and xmin::text = (txid_current() % (2^32)::bigint)::text);