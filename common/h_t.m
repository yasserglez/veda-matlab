function results = h_t(u1, u2, theta)
  % Evaluate the h-function of the bivariate Student's t copula.
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
  
  rho(rho == -1) = -1 + eps;
  rho(rho == 1) = 1 - eps;

  x1 = tinv(u1, df);
  x2 = tinv(u2, df);
  n = x1 - (rho .* x2);
  d = sqrt(((df + (x2 .^ 2)) .* (1 - (rho .^ 2))) ./ (df + 1));
  results = tcdf(n ./ d, df + 1);
end
