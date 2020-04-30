CREATE OR REPLACE VIEW insteadOfTriggerView AS
SELECT type_name, sum(value)
FROM insteadOfTrigger
GROUP BY type_name;