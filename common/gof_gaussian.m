function result = gof_gaussian(x, y)
  % Goodness-of-fit test for the bivariate Gaussian copula.
  
  % Created by Yasser González Fernández (2010).  
  
  x(x <= 0) = 0 + eps;
  x(x >= 1) = 1 - eps;
  y(y <= 0) = 0 + eps;
  y(y >= 1) = 1 - eps;  
  
  result = callR('gofCopulaWrapper', 'gaussian', [x, y]);
end
