function fitness = objective_ackley(params, population)
  % Ackley objective function. 
  %
  % PARAMS is a struct with the parameters of the EDA and POPULATION the
  % population matrix. The output variable FITNESS is a column vector with
  % the evaluation of the function at each individual of the given population.
  %
  % The global minima: x* = (0, ..., 0), f(x*) = 0.
  
  n = size(population, 2);
  square_term = exp(-0.2 * sqrt(sum(population .^ 2, 2) / n));
  cos_term = exp(sum(cos(2*pi * population), 2) / n);
  fitness = -20 * square_term - cos_term + 20 + exp(1);
end
