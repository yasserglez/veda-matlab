function fitness = objective_griewank(params, population)
  % Griewank objective function. 
  %
  % The global minima: x* = (0, ..., 0) with f(x*) = 0.
  
  p = size(population, 1);
  n = size(population, 2);
  sum_square = sum(population .^ 2, 2) / 4000;
  cos_prod = prod(cos(population ./ sqrt(repmat(1:n, p, 1))), 2);
  fitness = 1 + sum_square - cos_prod;
end
