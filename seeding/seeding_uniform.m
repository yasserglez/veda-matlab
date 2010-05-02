function [population] = seeding_uniform(params)
  % Initializes a uniform random population. 
  %
  % PARAMS is a struct with the parameters of the EDA. The output variable
  % POPULATION is the random population sampled from the uniform distribution in
  % the interval delimited by the minimum and maximum real values of each
  % variable. The population is returned as a matrix with columns for variables
  % and rows for indiviluals. The number of individuals in the population is
  % given by PARAMS.seeding_params.population_size.

  % Created by Yasser González Fernández (2010).

  lowers = repmat(params.objective_params.variable_limits(:,1)', ...
                  params.seeding_params.population_size, 1);
  uppers = repmat(params.objective_params.variable_limits(:,2)', ...
                  params.seeding_params.population_size, 1);

  population = unifrnd(lowers, uppers, ...
                       params.seeding_params.population_size, ... 
                       params.objective_params.number_variables);
end
