CREATE OR REPLACE FUNCTION insertMillionCities() RETURNS void AS
$$
DECLARE
    value integer = 0;
BEGIN
    FOR i IN 1..1000000
        LOOP
            value = (random() * 10)::INT;
            IF (value = 0) THEN
                value = 1;
            END IF;
            INSERT INTO public.city VALUES (i, i::varchar, value);
        END LOOP;
END;
$$ LANGUAGE plpgsql RETURNS NULL ON NULL INPUT;

select insertMillionCities();