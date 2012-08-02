function x = q_norm(sample, u)
  % Quantile function of the normal distribution.

  mu = mean(sample);
  sigma = std(sample);
  x = norminv(u, mu, sigma);
end
