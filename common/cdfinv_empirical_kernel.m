function x = cdfinv_empirical_kernel(sample, u)
  % Inverse of an univariate empirical CDF.
  %
  % Evaluates the inverse of the empirical CDF from the column vector SAMPLE
  % using a kernel estimator and returns its evaluation on each element of U.
  
  % Created by Yasser González Fernández (2010).
  
  x = ksdensity(sample, u, 'function', 'icdf');
end
