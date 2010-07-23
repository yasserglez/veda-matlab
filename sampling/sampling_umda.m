function population = ...
    sampling_umda(params, model, selected_population, selected_fitness)
  % Sampling function of the UMDA.
  
  % Created by Yasser González Fernández (2010).   
  
  num_vars = params.objective_params.number_variables;
  num_indivs = params.seeding_params.population_size;
  cdf_inverse = params.sampling_params.marginal_cdf_inverse;
  
  population = zeros(num_indivs, num_vars);
  uniform_population = unifrnd(0, 1, num_indivs, num_vars);
  for k = 1:num_vars
    population(:,k) = ...
      feval(cdf_inverse, selected_population(:,k), uniform_population(:,k));
  end
end
