function [parameters] = copulafit_gaussian(x, y)
  % Estimate the parameters of a bivariate Gaussian copula.
  %
  % This function is used to estimate the parameters of a bivariate copula in a
  % pair-copula decomposition of a multivariate density function. X and Y are
  % samples of correlated uniform [0,1] variables. The output variable
  % PARAMETERS is a vector with the estimated parameters of the copula.
  %
  % The parameter of a bivariate Gaussian copula is the linear correlation
  % coefficient between observations of the variables in X and Y.
  
  % Created by Yasser González Fernández (2010).
  
  sigma = corrcoef([x y]);
  parameters = sigma(1,2);
end
