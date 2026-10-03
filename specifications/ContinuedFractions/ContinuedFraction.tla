------------------------- MODULE ContinuedFraction -------------------------

(***************************************************************************)
(* The core algorithm to compute the unique, simple continued fraction of  *)
(* a rational number.                                                      *)
(***************************************************************************)

=============================================================================
\* AUTHOR: Sandeep R. Murthy
\* EMAIL:  srm@tuta.com
\* DATE:   03.10.2026

EXTENDS Integers, Sequences

VARIABLES x, y, coeffs

\* Type invariant to ensure that the numerator and denominator are
\* integers, and that in particular the denominator is non-zero.
TypeOK == /\ x \in Int
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
EuclideanDivision ==
    /\ y # 0
    /\ \E quo, rem \in Int :
        /\ quo = x \div y
        /\ rem = x \mod y
        /\ x' = y
        /\ y' = rem
        /\ coeffs' = Append(coeffs, quo)

\* Terminate when the current-state denominator (y), which is the current-state
\* division remainder, is 0.
End ==
    y = 0

\* Define the next-state relation: if we've reached the end
NextState ==
    IF End THEN UNCHANGED <<x, y, coeffs>> ELSE EuclideanDivision

\* Define the spec.
Spec ==
    Init /\ [][NextState]_<<x, y, coeffs>>

\* Property that guarantees termination for any valid rational input.
AlwaysTerminates ==
    <> (y = 0)

=============================================================================




