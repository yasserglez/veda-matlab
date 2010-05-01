function [u] = cdf_normal(sample, x)
  % Univariate Normal CDF.
  %
  % Estimates the parameters of the Normal distribution from SAMPLE and sets U
  % to the evaluation of the univariate Normal CDF in each element in the column
  % vector X.
  
  % Created by Yasser González Fernández (2010).
  
  mu = mean(sample);
  sigma = std(sample);
  u = normcdf(x, mu, sigma);  
end

