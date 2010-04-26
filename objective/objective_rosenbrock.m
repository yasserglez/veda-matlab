function [evaluation] = objective_rosenbrock(params, population)
  % Evaluates the Rosenbrock objective function. 
  %
  % PARAMS is a struct with the parameters of the EDA and POPULATION the
  % population matrix. The output variable EVALUATION is a column vector with
  % the evaluation of the function at each individual of the given population.
  %
  % Global minima: x* = (1, ..., 1), f(x*) = 0.
  
  evaluation = zeros(size(population, 1), 1);
  for individual = 1:size(population, 1)
    x = population(individual,:);
    z = 0;
    for j = 1:size(population, 2) - 1
      z = z + 100 * (x(j)^2 - x(j + 1))^2 + (x(j) - 1)^2;
    end
    evaluation(individual) = z;
  end
end
