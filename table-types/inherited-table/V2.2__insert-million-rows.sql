CREATE OR REPLACE FUNCTION insertMillionRows() RETURNS void AS
$$
DECLARE
    value integer = 0;
BEGIN
    FOR i IN 1..1000000
        LOOP
        value = (random() * 1000000);
        INSERT INTO public.users VALUES (value::int, value::varchar);
        END LOOP;
END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

select insertMillionRows();