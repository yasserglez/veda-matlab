function selection = selection_truncation(params, population, fitness)
  % Truncation selection.
  %
  % PARAMS is a struct with the parameters of the EDA. POPULATION is the
  % population of the current generation and FITNESS the evaluation of the
  % inidivuals of this population.
  %
  % The output variable SELECTION is a column vector with the indexes of the
  % selected individuals from POPULATION. In the truncation selection
  % individuals are ordered and the best K are selected. K is determined by the
  % product of the number of individuals in the population and the truncation
  % coefficient given by PARAMS.selection_params.truncation_coefficient.
  
  coef = params.selection_params.truncation_coefficient;
  pop_size = size(population, 1);
  [sorted, indexes] = sort(fitness);
  selection = indexes(1:ceil(coef * pop_size));
end
