function h = kendall_corr_test(x, y, alpha)
  % Test whether two samples come from uncorrelated populations.
  
  if nargin < 3
    % 5% significance level by default.
    alpha = 0.05;
  end  
  
  n = numel(x);
  tau = kendall_corr(x, y);
  stat = tau / sqrt((2 * (2*n+5)) / (9*n*(n-1)));
  cdf = normcdf(stat, 0, 1);
  p = 2 * min(cdf, 1-cdf);

  h = (p <= alpha);
end
