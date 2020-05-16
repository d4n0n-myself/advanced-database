\set idVal random(1, 1000000)
BEGIN;
    SELECT comparesql(:idVal);
END;