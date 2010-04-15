function [results] = h_gaussian(u1, u2, rho)
  % Evaluate the h-function for the bivariate Gaussian copula.
  %
  % See the following for more information:
  %
  % K. Aas, C. Czado, A. Frigessi, and H. Bakken. Pair-copula constructions of
  % multiple dependence. Note SAMBA/24/06, Norwegian Computing Center, NR, 2006.  
  
  % Created by Raúl José Arderí García (2007).
  % Modified by Yasser González Fernández (2010).
  
  b1 = norminv(u1, 0, 1);
  b2 = norminv(u2, 0, 1);
  results = normcdf((b1 - rho * b2) / sqrt(1 - (rho^2)), 0, 1);
end
