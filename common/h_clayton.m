function results = h_clayton(u1, u2, delta)
  % Evaluate the h-function of the bivariate Clayton copula.
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

  delta(delta == 0) = 0 + eps;
    
  results = (u2 .^ (-delta-1)) .* ...
            ((u1 .^ (-delta)) + (u2 .^ (-delta)) - 1) .^ (-1-(1/delta));
end
