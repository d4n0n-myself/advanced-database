CREATE OR REPLACE FUNCTION splitCityTableFn() RETURNS TRIGGER AS
$$
BEGIN
    IF (SELECT NOT EXISTS(
            SELECT
            FROM pg_catalog.pg_class c
            WHERE c.relname = ('city_' || NEW.countryid)
              AND c.relkind = 'r'
        )) THEN
        BEGIN
            EXECUTE format('CREATE TABLE city_%s () INHERITS (public.city);', NEW.countryid);
            EXECUTE format('CREATE INDEX city_%s_id_idx ON public.city_%s (id);', NEW.countryid, NEW.countryid);
            EXECUTE format('ALTER TABLE city_%s ADD CONSTRAINT check_countryid CHECK (public.city_%s.countryid = %s);',
                           NEW.countryid, NEW.countryid, NEW.countryid);
            EXECUTE format('CREATE TRIGGER updateCountryTrigger
                BEFORE UPDATE
                ON public.city_%s
                FOR EACH ROW
            EXECUTE FUNCTION checkCountryUpdate();', NEW.countryid);
        END;
    END IF;
    EXECUTE format('INSERT INTO city_%s VALUES (%s, ''%s'', %s)', NEW.countryid, NEW.id, NEW.name, NEW.countryid);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION checkCountryUpdate() RETURNS TRIGGER AS
$$
BEGIN
    IF (NEW.countryid <> OLD.countryid) THEN
        BEGIN
            EXECUTE format('DELETE FROM public.city_%s WHERE id = %s;', OLD.countryid, OLD.id);
            EXECUTE format('INSERT INTO public.city_%s VALUES (%s, ''%s'', %s);', NEW.countryid, NEW.id, NEW.name,
                           NEW.countryid);
        END;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER splitCityTableTrigger
    BEFORE INSERT
    ON public.city
    FOR EACH ROW
EXECUTE FUNCTION splitCityTableFn();