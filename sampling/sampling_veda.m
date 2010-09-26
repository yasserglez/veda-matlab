function population = ...
    sampling_veda(params, model, selected_population, selected_fitness)
  % Sampling function of the Vine EDA.
  %
  % References:
  %
  % K. Aas, C. Czado, A. Frigessi, and H. Bakken. Pair-copula constructions of
  % multiple dependence. Note SAMBA/24/06, Norwegian Computing Center, NR, 2006.  
  
  % Created by Raúl José Arderí García (2007).
  % Modified by Yasser González Fernández (2010).
  
  n = params.objective_params.number_variables;
  pop_size = params.seeding_params.population_size;
  cdf_inverse = params.sampling_params.marginal_cdf_inverse;
  ordering = model.ordering;
  
  % Simulate a population of dependent Uniform(0,1) variables from the vine.
  uniform_pop = callR('sampleVine', pop_size);
 
  % Transform the simulated Uniform(0,1) population into a population of the
  % variables of the objective function applying the inverse of the univariate
  % marginal CDFs to each observation.
  population = zeros(pop_size, n);
  for k = 1:n
    population(:,ordering(k)) = ...
      feval(cdf_inverse, selected_population(:,ordering(k)), uniform_pop(:,k));
  end
end
