SELECT public.myComplex_addition(complex) FROM complextest WHERE id in (2,3);
SELECT public.myComplex_subtraction(complex) FROM complextest WHERE id in (2,4);
SELECT public.myComplex_subtraction(complex) FROM complextest;
SELECT public.myComplex_multiply(complex) FROM complextest WHERE id in (2,3);
SELECT public.myComplex_division(complex) FROM complextest WHERE id in (2,3);

SELECT (2,3)::myComplex + (3,4)::myComplex;
SELECT (2,3)::myComplex - (3,4)::myComplex;
SELECT (2,3)::myComplex * (3,4)::myComplex;
SELECT (2,3)::myComplex / (3,4)::myComplex;