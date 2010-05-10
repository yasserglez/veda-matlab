function fitness = objective_sphere(params, population)
  % Sphere objective function. 
  %
  % PARAMS is a struct with the parameters of the EDA and POPULATION the
  % population matrix. The output variable FITNESS is a column vector with
  % the evaluation of the function at each individual of the given population.
  %
  % The global minima: x* = (0, ..., 0), f(x*) = 0.

  fitness = sum(population .^ 2, 2);
end
