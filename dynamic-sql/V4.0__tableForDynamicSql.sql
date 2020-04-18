CREATE TABLE city (
    id INT,
    name VARCHAR,
    countryId INT
);

CREATE INDEX city_id_idx ON public.city (id);