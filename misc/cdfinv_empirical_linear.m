function [x] = cdfinv_empirical_linear(sample, u)
  % Inverse of an univariate empirical CDF.
  %
  % Calculates the values of the empirical CDF in the column vector SAMPLE.
  % Using this values of the empirical CDF, approximates its inverse using
  % linear interpolation and evaluates the column vector U.
  
  % Created by Yasser González Fernández (2010).  
  
  if exist('ecdf', 'file') == 2
    % MATLAB Statistics Toolbox.
    [ecdf_f, ecdf_x] = ecdf(sample);
    n = size(ecdf_x, 1);
    sample_u = ecdf_f(2:n);
    sample = ecdf_x(2:n);
  else
    % Octave Statistics Package.
    unique_sample = unique(sample);
    sample_u = empirical_cdf(unique_sample, sample);
    sample = unique_sample;
  end 
  
  sample_u(1) = 0;
  sample_u(size(sample_u, 1)) = 1;
  x = interp1q(sample_u, sample, u);
end
