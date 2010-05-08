function [population, fitness] = ...
    replacing_none(params, current_population, current_fitness, ...
                   previous_population, previous_fitness)
  % A replacing method that does not modify the population.
  %
  % PARAMS is a struct with the parameters of the EDA. CURRENT_POPULATION should
  % be the population sampled in the current generation and CURRENT_FITNESS
  % the valuation of each solution of this population. PREVIOUS_POPULATION
  % should be the population of the previous generation after the replacing
  % method was applied and PREVIOUS_FITNESS the evaluation of each solution
  % of this population.
  %
  % The output variable POPULATION is the population that the algorithm should
  % use for this generation and FITNEESS the evaluation of each solution in
  % this population.
  
  % Created by Yasser González Fernández (2010).  

  population = current_population;
  fitness = current_fitness;
end
