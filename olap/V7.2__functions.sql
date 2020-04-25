CREATE OR REPLACE FUNCTION public.myComplex_additionFunc(state myComplex, second myComplex) RETURNS public.myComplex AS
$$
BEGIN
    RETURN (state.x + second.x, state.y + second.y);
END;
$$
    LANGUAGE plpgsql IMMUTABLE
                     STRICT;

CREATE OR REPLACE FUNCTION public.myComplex_subtractionFunc(state myComplex, second myComplex) RETURNS public.myComplex AS
$$
BEGIN
    RETURN (state.x - second.x, state.y - second.y);
END;
$$
    LANGUAGE plpgsql IMMUTABLE
                     STRICT;

CREATE OR REPLACE FUNCTION public.myComplex_multiplyFunc(state myComplex, second myComplex) RETURNS public.myComplex AS
$$
BEGIN
    RETURN (
            ((state.x * second.x) - (state.y * second.y))::decimal,
            ((state.y * second.x) + (state.x * second.y))::decimal
        );
END;
$$
    LANGUAGE plpgsql IMMUTABLE
                     STRICT;

CREATE OR REPLACE FUNCTION public.myComplex_divisionFunc(state myComplex, second myComplex) RETURNS public.myComplex AS
$$
DECLARE
    denominator DECIMAL;
BEGIN
    denominator = (second.x * second.x) + (second.y * second.y);
    RETURN (
            ((state.x * second.x) + (state.y * second.y))::decimal / denominator,
            ((state.y * second.x) - (state.x * second.y))::decimal / denominator
        );
END;
$$
    LANGUAGE plpgsql IMMUTABLE
                     STRICT;

CREATE AGGREGATE public.myComplex_addition(myComplex) (
    stype = public.mycomplex,
    sfunc = public.myComplex_additionFunc
    );

CREATE AGGREGATE public.myComplex_subtraction(myComplex) (
    stype = public.mycomplex,
    sfunc = public.myComplex_subtractionFunc,
    initcond = '(0,0)'
    );

CREATE AGGREGATE public.myComplex_multiply(myComplex) (
    stype = public.mycomplex,
    sfunc = public.myComplex_multiplyFunc
    );

CREATE AGGREGATE public.myComplex_division(myComplex) (
    stype = public.mycomplex,
    sfunc = public.myComplex_divisionFunc
    );

CREATE OPERATOR + (
    leftarg = myComplex,
    rightarg = myComplex,
    procedure = myComplex_additionFunc,
    commutator = +
    );

CREATE OPERATOR - (
    leftarg = myComplex,
    rightarg = myComplex,
    procedure = myComplex_subtractionFunc,
    commutator = -
    );

CREATE OPERATOR * (
    leftarg = myComplex,
    rightarg = myComplex,
    procedure = myComplex_multiplyFunc,
    commutator = *
    );

CREATE OPERATOR / (
    leftarg = myComplex,
    rightarg = myComplex,
    procedure = myComplex_divisionFunc,
    commutator = /
    );