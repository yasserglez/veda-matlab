function u = cdf_empirical_kernel(sample, x)
  % Univariate empirical CDF.
  %
  % Calculates the empirical CDF from the column vector SAMPLE using a kernel
  % estimator and returns its evaluation on each element of X.
  
  % Created by Yasser González Fernández (2010).
  
  u = ksdensity(sample, x, 'function', 'cdf');
end
