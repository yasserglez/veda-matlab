function population = seeding_uniform(params)
  % Initialize a Uniform random population. 
  %
  % PARAMS is a struct with the parameters of the EDA. The output variable
  % POPULATION is the random population sampled from the uniform distribution in
  % the interval delimited by the minimum and maximum real values of each
  % variable. The population is returned as a matrix with columns for variables
  % and rows for indiviluals. The number of individuals in the population is
  % given by PARAMS.seeding_params.population_size.

  lower_bounds = repmat(params.objective_params.lower_bounds, ...
                        params.seeding_params.population_size, 1);
  upper_bounds = repmat(params.objective_params.upper_bounds, ...
                        params.seeding_params.population_size, 1);

  population = unifrnd(lower_bounds, upper_bounds, ...
                       params.seeding_params.population_size, ... 
                       params.objective_params.number_variables);
end
