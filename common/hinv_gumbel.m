function results = hinv_gumbel(u1, u2, delta)
  % Evaluate the inverse of the h-function of the bivariate Gumbel copula.
  %
  % References:
  %
  % K. Aas, C. Czado, A. Frigessi, and H. Bakken. Pair-copula constructions of
  % multiple dependence. Note SAMBA/24/06, Norwegian Computing Center, NR, 2006.  
  
  % Created by Yasser González Fernández (2010).
  
  % The inverse of the h-function of the Gumbel copula cannot be expressed in
  % closed form, so, it is calculated numerically.
  
  m = size(u1, 1);
  results = zeros(m, 1);
  for i = 1:m
    f = @(x) abs(h_gumbel(x, u2(i), delta) - u1(i));
    results(i) = fminbnd(f, 0, 1);
  end
end
