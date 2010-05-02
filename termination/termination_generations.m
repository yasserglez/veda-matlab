function [terminate] = ...
    termination_generations(params, generation, population, evaluation)
  % Stop if a maximum number of generations is reached.
  %
  % PARAMS is a struct with the parameters of the EDA. GENERATION is the number
  % of the generation that has just finished, POPULATION is the population used
  % in this generation and EVALUATION its evaluation.
  %
  % The output variable TERMINATE indicates if the algorithm should terminate
  % the evolution. It will be true when GENERATION is greater or equals than the
  % number set in PARAMS.termination_params.max_generations.
  
  % Created by Yasser González Fernández (2010).  
  
  terminate = (generation >= params.termination_params.max_generations);
end
