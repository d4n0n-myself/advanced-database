CREATE TABLE hashIndex
(
    id   INTEGER,
    name VARCHAR
);

CREATE TABLE btreeIndex
(
    id   INTEGER,
    name VARCHAR
);

CREATE TABLE brinIndex
(
    id   INTEGER,
    name VARCHAR
);

INSERT INTO hashIndex
SELECT i, i::varchar
FROM generate_series(1, 100000) AS g(i);

INSERT INTO btreeIndex
SELECT i, i::varchar
FROM generate_series(1, 100000) AS g(i);

INSERT INTO brinIndex
SELECT i, i::varchar
FROM generate_series(1, 100000) AS g(i);

CREATE INDEX hashIndex_name_idx ON public.hashIndex USING hash (name);
CREATE INDEX btreeIndex_name_idx ON public.btreeIndex USING btree (name);
CREATE INDEX brinIndex_name_idx ON public.brinIndex USING brin (name);