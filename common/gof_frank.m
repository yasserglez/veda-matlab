function result = gof_frank(x, y)
  % Goodness-of-fit test for the bivariate Frank copula.
  
  result = callR('gofCopulaWrapper', 'frank', [x, y]);
end
