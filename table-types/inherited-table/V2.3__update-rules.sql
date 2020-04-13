CREATE OR REPLACE FUNCTION setUpdateRules() RETURNS void AS
$$
BEGIN
    FOR i in 1..10
        LOOP
            FOR j in 1..10
                LOOP
                    CONTINUE WHEN i = j;

                    EXECUTE format('CREATE OR REPLACE RULE redirect_update_on_%s_to_%s
                                        AS ON UPDATE TO public.users
                                        WHERE OLD.id / 100000 = %s AND NEW.id / 100000 = %s
                                    DO INSTEAD (
                                        INSERT INTO users_%s VALUES (NEW.id, NEW.name);
                                        DELETE FROM users_%s WHERE id = OLD.id;
                                    );', i, j, (i - 1), (j - 1), j, i);

                END LOOP;
        END LOOP;
END
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

SELECT setUpdateRules();