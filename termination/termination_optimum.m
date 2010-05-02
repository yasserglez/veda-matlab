function [terminate] = ...
    termination_optimum(params, generation, population, evaluation)
  % Stop if a known optimum is found or maximum generations reached.
  %
  % PARAMS is a struct with the parameters of the EDA. GENERATION is the number
  % of the generation that has just finished, POPULATION is the population used
  % in this generation and EVALUATION its evaluation.
  %
  % The output variable TERMINATE indicates if the algorithm should terminate
  % the evolution. It will be 1 when a maximum number of generations is reached 
  % or when the fitness of an individual in the population that is close enough 
  % to a known optimum of the objective function. The maximum number of
  % generations is set by PARAMS.termination_params.max_generations. The error
  % tolerance is given by PARAMS.termination_params.error_tolerance.
  
  % Created by Yasser González Fernández (2010).  
  
  error = abs(params.objective_params.optimum - evaluation);
  x = any(error <= params.termination_params.error_tolerance);
  y = (generation >= params.termination_params.max_generations);
  terminate = x | y;
end
