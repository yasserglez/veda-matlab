function rho = fitcopula_gaussian_kendall(x, y)
  % Estimate the parameters of a bivariate Gaussian copula.
  %
  % This function is used to estimate the parameters of a bivariate copula in a
  % pair-copula decomposition of a multivariate density function. X and Y are
  % samples of correlated Uniform(0,1) variables. The output variable
  % is a vector with the estimated parameters of the copula.
  %
  % References:
  %
  % Romano, C. Calibrating and simulating copula functions: An application to
	% the italian stock market. Working paper 12. Centro Interdipartimale sul 
  % Diritto  e l’Economia dei Mercati, 2002.  
  
  % Created by Yasser González Fernández (2010).
  
  tau = kendall_corr(x, y);
  rho = sin(tau * (pi / 2));
end
