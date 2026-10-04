------------------------- MODULE ContinuedFractionPlusCal ------------------

(**************************************************************************)
(* The C-style PlusCal version of the core continued fraction algorithm.  *)
(*                                                                        *)
(*                                                                        *)
(* AUTHOR: Sandeep R. Murthy                                              *)
(* EMAIL:  srm@tuta.com                                                   *)
(* DATE:   03.10.2026                                                     *)
(**************************************************************************)

EXTENDS Integers, Sequences

VARIABLES x, y, coeffs

\* Type invariant to ensure that the numerator and denominator are
\* integers, and that in particular the denominator is non-zero.
TypeOK == 
    /\ x \in Int
    /\ y \in Int \ {0}

\* Initial state - check the type invariant is satisfied and that
\* the coefficients sequence is empty.
Init ==
    /\ TypeOK
    /\ coeffs = <<>>

\* Core algorithm step for Euclidean division:
\*     while current-state denominator (y) is non-zero:
\*         compute the integer quotient (quo) and remainder (rem) of the
\*           numerator / denominator division (x/y);
\*         set the next-state numerator (x') and denominator (y') to the values
\*           of the current-state denominator (y) and division remainder (rem)
\*           respectively;
\*         append the division quotient (quo) to the coefficients sequence
\*         (coeffs);

--algorithm ContinuedFraction
variables x \in Int, y \in Int \ {0}, coeffs = <<>>

{
  while (y # 0) {
    with (quo = x \div y, rem = x % y) {
      coeffs := Append(coeffs, quo);
      x := y;
      y := rem;
    };
  };
}
end algorithm

============================================================================
