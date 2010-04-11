function [terminate] = ...
    termination_generations_optimum(params, generation, population, evaluation)
  % Combine termination_generations and termination_optimum criteria.
  %
  % PARAMS is a struct with the parameters of the EDA. GENERATION is the number
  % of the generation that has just finished, POPULATION is the population used
  % in this generation and EVALUATION its evaluation.
  %
  % The output variable TERMINATE indicates if the algorithm should terminate
  % the evolution. It will be 1 when the criteria defined by termination_optimum
  % or termination_generations is satisfied. See the documentation of this
  % functions for more information.
  
  terminate = termination_generations(params, generation, population, evaluation);
  if ~terminate
    terminate = termination_optimum(params, generation, population, evaluation);
  end
end
