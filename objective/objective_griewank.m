function fitness = objective_griewank(params, population)
  % Griewank objective function. 
  %
  % PARAMS is a struct with the parameters of the EDA and POPULATION the
  % population matrix. The output variable FITNESS is a column vector with
  % the evaluation of the function at each individual of the given population.
  %
  % The global minima: x* = (0, ..., 0), f(x*) = 0.
  
  p = size(population, 1);
  n = size(population, 2);
  sum_power = (1/4000) * sum(population .^ 2, 2);
  cos_prod = prod(cos(population ./ sqrt(repmat(1:n, p, 1))), 2);
  fitness = 1 + sum_power - cos_prod;
end
