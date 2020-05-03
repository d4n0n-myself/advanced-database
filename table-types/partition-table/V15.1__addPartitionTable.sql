CREATE TABLE public.partitionTable
(
    id   integer,
    name varchar
) PARTITION BY HASH (name);

CREATE TABLE public.partitionTable1
    PARTITION OF public.partitionTable FOR VALUES WITH (MODULUS 10, REMAINDER 1);
CREATE TABLE public.partitionTable2
    PARTITION OF public.partitionTable FOR VALUES WITH (MODULUS 10, REMAINDER 2);
CREATE TABLE public.partitionTable3
    PARTITION OF public.partitionTable FOR VALUES WITH (MODULUS 10, REMAINDER 3);
CREATE TABLE public.partitionTable4
    PARTITION OF public.partitionTable FOR VALUES WITH (MODULUS 10, REMAINDER 4);
CREATE TABLE public.partitionTable5
    PARTITION OF public.partitionTable FOR VALUES WITH (MODULUS 10, REMAINDER 5);
CREATE TABLE public.partitionTable6
    PARTITION OF public.partitionTable FOR VALUES WITH (MODULUS 10, REMAINDER 6);
CREATE TABLE public.partitionTable7
    PARTITION OF public.partitionTable FOR VALUES WITH (MODULUS 10, REMAINDER 7);
CREATE TABLE public.partitionTable8
    PARTITION OF public.partitionTable FOR VALUES WITH (MODULUS 10, REMAINDER 8);
CREATE TABLE public.partitionTable9
    PARTITION OF public.partitionTable FOR VALUES WITH (MODULUS 10, REMAINDER 9);
CREATE TABLE public.partitionTable10
    PARTITION OF public.partitionTable FOR VALUES WITH (MODULUS 10, REMAINDER 0);