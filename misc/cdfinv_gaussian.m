function [x] = cdfinv_gaussian(sample, u)
  % Inverse of the univariate Normal CDF.
  %
  % Estimates the parameters of the Normal distribution from SAMPLE and sets X
  % to the evaluation of the inverse of the univariate Normal CDF in each
  % element in the column vector U.
  
  % Created by Yasser González Fernández (2010).  
  
  mu = mean(sample);
  sigma = std(sample);
  x = norminv(u, mu, sigma);
end

