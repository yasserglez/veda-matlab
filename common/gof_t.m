function result = gof_t(x, y)
  % Goodness-of-fit test for the bivariate t copula.
  
  % Created by Yasser González Fernández (2010).
  
  x(x <= 0) = 0 + eps;
  x(x >= 1) = 1 - eps;
  y(y <= 0) = 0 + eps;
  y(y >= 1) = 1 - eps;
  
  result = callR('gofCopulaWrapper', 't', [x, y]);
end
