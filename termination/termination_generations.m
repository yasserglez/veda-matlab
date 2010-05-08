function terminate = ...
    termination_generations(params, generation, evaluations, population, fitness)
  % Stop if a maximum number of generations is reached.
  %
  % PARAMS is a struct with the parameters of the EDA. GENERATION is the number
  % of the generation that has just finished, EVALUATIONS is the number of
  % evaluations of the objective function, POPULATION is the population used
  % in this generation and FITNESS its evaluation.
  %
  % The output variable TERMINATE indicates if the algorithm should terminate
  % the evolution. It will be true when GENERATION is greater or equals than the
  % number set in PARAMS.termination_params.max_generations.
  
  % Created by Yasser González Fernández (2010).  
  
  terminate = (generation >= params.termination_params.max_generations);
end
