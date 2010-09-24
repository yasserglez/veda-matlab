function population = ...
    sampling_cveda(params, model, selected_population, selected_fitness)
  % Sampling function of the Copula EDA.
  
  % Created by Yasser González Fernández (2010).
  
  pop_size = params.seeding_params.population_size;
  n = params.objective_params.number_variables;
  cdf_inverse = params.sampling_params.marginal_cdf_inverse; 
  
  % Simulate the multivariate copula.
  uniform_pop = copularnd(model.family, model.theta, pop_size);
  
  % Transform the simulated Uniform(0,1) population into a population of the
  % variables of the objective function applying the inverse of the univariate
  % marginal CDFs to each observation of each variable in the population.
  population = zeros(pop_size, n);
  for k = 1:n
    population(:,k) = ...
        feval(cdf_inverse, selected_population(:,k), uniform_pop(:,k));
  end
end
