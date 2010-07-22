function results = h_frank(u1, u2, delta)
  % Evaluate the h-function of the bivariate Frank copula.
  %
  % References:
  %
  % Schirmacher, E. and Schirmacher, E. Multivariate dependence modeling using
  % pair-copulas. Enterprise Risk Management Symposium, Chicago, 2008.
  
  % Created by Yasser González Fernández (2010).
  
  u1(u1 <= 0) = 0 + eps;
  u1(u1 >= 1) = 1 - eps;
  u2(u2 <= 0) = 0 + eps;
  u2(u2 >= 1) = 1 - eps;
  
  delta(delta == 0) = 0 + eps;  
  
  n = exp(-delta .* u2);
  d = ((1 - exp(-delta)) ./ (1 - exp(-delta .* u1))) + exp(-delta .* u2) - 1;
  results = n ./ d;
end
