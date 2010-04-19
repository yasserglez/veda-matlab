function [parameters] = copula_fit_gaussian_kendall(x, y)
  % Estimate the parameters of a bivariate Gaussian copula.
  %
  % This function is used to estimate the parameters of a bivariate copula in a
  % pair-copula decomposition of a multivariate density function. X and Y are
  % samples of correlated uniform [0,1] variables. The output variable
  % PARAMETERS is a vector with the estimated parameters of the copula.
  %
  % The parameter of a bivariate Gaussian copula is the linear correlation
  % coefficient between observations of the variables in X and Y.  The linear
  % correlation coefficient is calculated from the Kendall's tau rank
  % correlation coefficient, using the one-to-one mapping for the bivariate
  % normal.
  
  % Created by Yasser González Fernández (2010).
  
  tau = corr([x y], 'type', 'Kendall');
  parameters = sin(tau(1,2) * (pi/2));
end
