CREATE TABLE btreeIndex2
(
    id   INTEGER,
    content VARCHAR
);

CREATE TABLE ginIndex
(
    id   INTEGER,
    content VARCHAR
);

CREATE TABLE gistIndex
(
    id   INTEGER,
    content VARCHAR
);

INSERT INTO btreeIndex2
SELECT i, i::varchar
FROM generate_series(1, 100000) AS g(i);

INSERT INTO ginIndex
SELECT i, i::varchar
FROM generate_series(1, 100000) AS g(i);

INSERT INTO gistIndex
SELECT i, i::varchar
FROM generate_series(1, 100000) AS g(i);

CREATE INDEX btreeIndex2_content_idx ON public.btreeIndex2 USING hash (content);
CREATE INDEX ginIndex_content_idx ON public.ginIndex USING btree (content);
CREATE INDEX gistIndex_content_idx ON public.gistIndex USING brin (content);