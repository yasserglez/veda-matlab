function results = hinv_frank(u1, u2, delta)
  % Evaluate the inverse of the h-function of the bivariate Frank copula.
  %
  % References:
  %
  % Schirmacher, E. and Schirmacher, E. Multivariate dependence modeling using
  % pair-copulas. Enterprise Risk Management Symposium, Chicago, 2008.
  
  % Created by Yasser González Fernández (2010).

  u1(u1 == 0) = 0 + eps;
  
  logarg = 1 - ((1 - exp(-delta)) ./ (((1 ./ u1) - 1) .* exp(-delta .* u2) + 1));
  results = -log(logarg) ./ delta;
end
