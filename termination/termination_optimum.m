function [terminate] = ...
    termination_optimum(params, generation, population, evaluation)
  % Stop the algorithm if a known optimum of the function is found.
  %
  % PARAMS is a struct with the parameters of the EDA. GENERATION is the number
  % of the generation that has just finished, POPULATION is the population used
  % in this generation and EVALUATION its evaluation.
  %
  % The output variable TERMINATE indicates if the algorithm should terminate
  % the evolution. It will be 1 when a solution of the population gives a
  % value of the function that is close enough to a known optimum of the
  % objective function. The error tolerance is given by
  % PARAMS.termination_params.error_tolerance.
  
  % Created by Yasser González Fernández (2010).  
  
  error = abs(params.objective_params.optimum - evaluation);
  terminate = any(error <= params.termination_params.error_tolerance);
end
