function results = hinv_t(u1, u2, theta)
  % Evaluate the inverse of the h-function of the bivariate Student's t copula.
  %
  % References:
  %
  % K. Aas, C. Czado, A. Frigessi, and H. Bakken. Pair-copula constructions of
  % multiple dependence. Note SAMBA/24/06, Norwegian Computing Center, NR, 2006.  
  
  % Created by Yasser González Fernández (2010).
  
  rho = theta(1);
  df = theta(2);  

  u1(u1 <= 0) = 0 + eps;
  u1(u1 >= 1) = 1 - eps;
  u2(u2 <= 0) = 0 + eps;
  u2(u2 >= 1) = 1 - eps;
  
  x1 = tinv(u1, df + 1);
  x2 = tinv(u2, df);
  s = sqrt(((df + (x2 .^ 2)) .* (1 - (rho .^ 2))) ./ (df + 1));
  results = tcdf((x1 .* s) + (rho .* x2), df);
end
