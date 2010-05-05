function [u] = cdf_empirical(sample, x)
  % Univariate empirical CDF.
  %
  % Calculates the empirical CDF from the column vector SAMPLE and returns in
  % the output variable U its evaluation on each element of the column vector X.
  
  % Created by Yasser González Fernández (2010).
  
  if exist('ecdf', 'file') == 2
    % MATLAB Statistics Toolbox.
    [ecdf_f, ecdf_x] = ecdf(sample);
    u = zeros(size(x, 1), 1);
    for x_index = 1:size(x, 1)
      ecdf_x_index = find(ecdf_x == x(x_index), 1, 'last');
      u(x_index) = ecdf_f(ecdf_x_index);
    end
  else
    % Octave Statistics Package.
    u = empirical_cdf(x, sample);
  end
end
