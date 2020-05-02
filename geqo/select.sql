EXPLAIN ANALYZE
SELECT *
FROM btreeindex bti
         left join clustered c2 on bti.id = c2.id
         inner join fillfactor50 f on bti.id = f.id
         right join fillfactor75 f75 on bti.id = f75.id
         full outer join fillfactor90 f90 on bti.id = f90.id
         inner join fillfactor100 f100 on bti.id = f100.id
         inner join btreeindex2 bti2 on bti.id = bti2.id;