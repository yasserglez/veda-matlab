function [evaluation] = objective_sphere(params, population)
  % Evaluates the Sphere objective function. 
  %
  % PARAMS is a struct with the parameters of the EDA and POPULATION the
  % population matrix. The output variable EVALUATION is a column vector with
  % the evaluation of the function at each individual of the given population.
  %
  % Search domain: −5.12 <= xi <= 5.12, i = 1, ..., n.
  % The global minima: x* = (0, ..., 0), f(x*) = 0.

  evaluation =  sum(population .^ 2, 2);
end
