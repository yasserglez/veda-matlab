function [results] = h_gaussian(u1, u2, rho)
  % Evaluate the h-function of the bivariate Gaussian copula.
  %
  % See the following for more information:
  %
  % K. Aas, C. Czado, A. Frigessi, and H. Bakken. Pair-copula constructions of
  % multiple dependence. Note SAMBA/24/06, Norwegian Computing Center, NR, 2006.  
  
  % Created by Raúl José Arderí García (2007).
  % Modified by Yasser González Fernández (2010).

  % Avoid NaNs and Infs.
  u1(u1 == 0) = 0 + eps;
  u1(u1 == 1) = 1 - eps;
  u2(u2 == 0) = 0 + eps;
  u2(u2 == 1) = 1 - eps;
  rho(rho == -1) = -1 + eps;
  rho(rho == 1) = 1 - eps;
    
  b1 = norminv(u1, 0, 1);
  b2 = norminv(u2, 0, 1);
  results = normcdf((b1 - (rho * b2)) / sqrt(1 - (rho ^ 2)), 0, 1);
end
