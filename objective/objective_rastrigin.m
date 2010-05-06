function [evaluation] = objective_rastrigin(params, population)
  % Evaluates the Rastrigin objective function. 
  %
  % PARAMS is a struct with the parameters of the EDA and POPULATION the
  % population matrix. The output variable EVALUATION is a column vector with
  % the evaluation of the function at each individual of the given population.
  %
  % The global minima: x* = (0, ..., 0), f(x*) = 0.

  evaluation = sum((population .^ 2) - 10 * cos(2*pi * population) + 10, 2);
end
