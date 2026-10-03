--algorithm ContinuedFraction
variables x \in Int, y \in Int \ {0}, coeffs = <<>>

{
  while (y # 0) {
    with (quo = x \div y, rem = x \mod y) {
      coeffs := Append(coeffs, quo);
      x := y;
      y := rem;
    };
  };
}