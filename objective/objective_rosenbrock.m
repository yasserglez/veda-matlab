function [evaluation] = objective_rosenbrock(params, population)
  % Evaluates the Rosenbrock objective function. 
  %
  % PARAMS is a struct with the parameters of the EDA and POPULATION the
  % population matrix. The output variable EVALUATION is a column vector with
  % the evaluation of the function at each individual of the given population.
  %
  % Sugested search domain: -5 <= xi <= 10, i = 1, ..., n. 
  % Global minima: x* = (1, ..., 1), f(x*) = 0.

  x = population;
  n = size(population, 2);
  m = size(population, 1);
  z = zeros(m, 1);
  for i = 1:m
    for j = 1:n - 1
      z(i) = z(i) + 100 * (x(i,j)^2 - x(i,j + 1))^2 + (x(i,j) - 1)^2;
    end
  end
  evaluation = z;
end
