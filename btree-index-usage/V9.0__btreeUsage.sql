CREATE TABLE btreeUsage
(
    a integer,
    b integer,
    c integer
);

INSERT INTO btreeUsage
SELECT i, i, i
FROM generate_series(1, 1000) AS g(i);

CREATE INDEX btree_a_idx ON btreeUsage (a);
CREATE INDEX btree_b_idx ON btreeUsage (b);
CREATE INDEX btree_c_idx ON btreeUsage (c);
CREATE INDEX btree_ab_idx ON btreeUsage (a, b);
CREATE INDEX btree_ac_idx ON btreeUsage (a, c);
CREATE INDEX btree_ba_idx ON btreeUsage (b, a);
CREATE INDEX btree_bc_idx ON btreeUsage (b, c);
CREATE INDEX btree_ca_idx ON btreeUsage (c, a);
CREATE INDEX btree_cb_idx ON btreeUsage (c, b);
CREATE INDEX btree_abc_idx ON btreeUsage (a, b, c);
CREATE INDEX btree_acb_idx ON btreeUsage (a, c, b);
CREATE INDEX btree_bca_idx ON btreeUsage (b, c, a);
CREATE INDEX btree_bac_idx ON btreeUsage (b, a, c);
CREATE INDEX btree_cab_idx ON btreeUsage (c, a, b);
CREATE INDEX btree_cba_idx ON btreeUsage (c, b, a);