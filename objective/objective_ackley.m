function fitness = objective_ackley(params, population)
  % Ackley objective function. 
  %
  % PARAMS is a struct with the parameters of the EDA and POPULATION the
  % population matrix. The output variable FITNESS is a column vector with
  % the evaluation of the function at each individual of the given population.
  %
  % The global minima: x* = (0, ..., 0), f(x*) = 0.
  
  n = size(population, 2);
  power_term = exp(-0.2 * sqrt(1/n * sum(population .^ 2, 2)));
  cos_term = exp(1/n * sum(cos(2*pi * population), 2));
  fitness = -20 * power_term - cos_term + 20 + exp(1);
end
