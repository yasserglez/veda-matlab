function terminate = ...
    termination_optimum(params, generation, evaluations, population, fitness)
  % Stop if a known optimum is found.
  %
  % PARAMS is a struct with the parameters of the EDA. GENERATION is the number
  % of the generation that has just finished, EVALUATIONS is the number of
  % evaluations of the objective function, POPULATION is the population used
  % in this generation and FITNESS its evaluation.
  %
  % The output variable TERMINATE indicates if the algorithm should terminate
  % the evolution. It will be 1 when the fitness of an individual in the 
  % population that is close enough to a known optimum of the objective function. 
  % The error tolerance is given by PARAMS.termination_params.error_tolerance.
  
  % Created by Yasser González Fernández (2010).  
  
  error = abs(params.objective_params.optimum - fitness);
  terminate = any(error <= params.termination_params.error_tolerance);
end
