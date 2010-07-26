function result = gof_gumbel(x, y)
  % Goodness-of-fit test for the bivariate Gumbel copula.
  
  % Created by Yasser González Fernández (2010).
  
  x(x <= 0) = 0 + eps;
  x(x >= 1) = 1 - eps;
  y(y <= 0) = 0 + eps;
  y(y >= 1) = 1 - eps;

  result = callR('gofCopulaWrapper', 'gumbel', [x, y]);
end
