function [terminate] = ...
    termination_generations(params, generation, population, evaluation)
  % Stop the algorithm based on the number of generations.
  %
  % PARAMS is a struct with the parameters of the EDA. GENERATION is the number
  % of the generation that has just finished, POPULATION is the population used
  % in this generation and EVALUATION its evaluation.
  %
  % The output variable TERMINATE indicates if the algorithm should terminate
  % the evolution. It will be true when GENERATION is greater or equals than the
  % number set in PARAMS.termination_params.max_generations.
  
  terminate = (generation >= params.termination_params.max_generations);
end
