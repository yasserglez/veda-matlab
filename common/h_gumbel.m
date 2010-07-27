function results = h_gumbel(u1, u2, delta)
  % Evaluate the h-function of the bivariate Gumbel copula.
  %
  % References:
  %
  % K. Aas, C. Czado, A. Frigessi, and H. Bakken. Pair-copula constructions of
  % multiple dependence. Note SAMBA/24/06, Norwegian Computing Center, NR, 2006.  

  % Created by Yasser González Fernández (2010).

  u1(u1 <= 0) = 0 + eps;
  u1(u1 >= 1) = 1 - eps;
  u2(u2 <= 0) = 0 + eps;
  u2(u2 >= 1) = 1 - eps;

  C = exp(-((((-log(u1)) .^ delta) + ((-log(u2)) .^ delta)) .^ (1/delta)));

  results = C .* (1./u2) .* ((-log(u2)) .^ (delta-1)) ...
    .* ((((-log(u1)) .^ delta) + ((-log(u2)) .^ delta)) .^ ((1/delta)-1));
end
