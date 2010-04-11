function [evaluation] = objective_sphere(params, population)
  % Evaluates the Sphere objective function. 
  %
  % PARAMS is a struct with the parameters of the EDA and POPULATION the
  % population matrix. The output variable EVALUATION is a column vector with
  % the evaluation of the function at each individual of the given population.

  evaluation =  sum(population .^ 2, 2);
end
