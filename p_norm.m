function u = p_norm(sample, x)
  % Distribution function of the normal distribution.

  mu = mean(sample);
  sigma = std(sample);
  u = normcdf(x, mu, sigma);  
end
