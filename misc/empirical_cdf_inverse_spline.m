function [x] = empirical_cdf_inverse_spline(sample, u)
  % Inverse of an univariate empirical cumulative distribution function.
  %
  % Calculates the values of the empirical CDF in the column vector SAMPLE.
  % Using this values of the empirical CDF, approximates its inverse using cubic
  % spline interpolation and evaluates the column vector U.
  
  % Created by Yasser González Fernández (2010).  
  
  sample_u = empirical_cdf(sample, sample);
  x = interp1(sample_u, sample, u, 'spline');
end
