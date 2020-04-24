CREATE TABLE clustered
(
    id   int,
    name varchar
);

CREATE INDEX clustered_id_idx ON public.clustered USING btree (id);