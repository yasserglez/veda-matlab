function delta = fitcopula_frank(x, y)
  % Estimate the parameters of a bivariate Frank copula.
  %
  % This function is used to estimate the parameters of a bivariate copula in a
  % pair-copula decomposition of a multivariate density function. X and Y are
  % samples of correlated Uniform(0,1) variables. The output variable
  % is a vector with the estimated parameters of the copula.
  
  % Created by Yasser González Fernández (2010).
  
  % TODO: Modify to support running in Octave.
  
  x(x <= 0) = 0 + eps;
  x(x >= 1) = 1 - eps;
  y(y <= 0) = 0 + eps;
  y(y >= 1) = 1 - eps;
  
  delta = copulafit('Frank', [x y]);
end
