CREATE OR REPLACE FUNCTION insteadOfTriggerFunc() RETURNS TRIGGER AS
$$
BEGIN
    RAISE NOTICE 'Attempt to insert data with type_name: %', NEW.type_name;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_insteadOfTrigger
    INSTEAD OF INSERT
    ON insteadOfTriggerView
    FOR EACH ROW
EXECUTE FUNCTION insteadOfTriggerFunc();