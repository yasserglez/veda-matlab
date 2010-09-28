function terminate = ...
    termination_evaluations(params, generation, evaluations, population, fitness)
  % Stop if a maximum number of evaluations of the objective function is exceded.
  %
  % PARAMS is a struct with the parameters of the EDA. GENERATION is the number
  % of the generation, EVALUATIONS is the number of evaluations of the objective 
  % function, POPULATION is the population and FITNESS its evaluation.
  %
  % The output variable TERMINATE indicates if the algorithm should terminate
  % the evolution. It will be true when EVALUATIONS is greater or equals than
  % the number set in PARAMS.termination_params.max_evaluations.
  
  terminate = (evaluations >= params.termination_params.max_evaluations);
end
