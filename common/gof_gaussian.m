function result = gof_gaussian(x, y)
  % Goodness-of-fit test for the bivariate Gaussian copula.
  
  result = callR('gofCopulaWrapper', 'gaussian', [x, y]);
end
