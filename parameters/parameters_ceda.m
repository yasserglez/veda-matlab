function params = parameters_ceda()
  params = struct();

  params.note = 'Gaussian Copula EDA with Gaussian marginals.';
  params.runs = 1;
  params.quiet = false;

  params.objective = 'objective_sphere';
  params.objective_params = struct();
  params.objective_params.number_variables = 3;
  n = params.objective_params.number_variables;
  params.objective_params.lower_bounds = repmat(-5.12, 1, n);
  params.objective_params.upper_bounds = repmat(5.12, 1, n);
  params.objective_params.optimum = 0;
  params.objective_params.optimum_individual = repmat(0, 1, n);

  params.learning = 'learning_ceda';
  params.learning_params = struct();
  
  % Name of the family of the multivariate copula. The family name must
  % match the ones used by the copulafit and copularnd functions of the 
  % MATLAB Statistics toolbox.
  params.learning_params.copula_family = 'Gaussian';  
  
  % A function that evaluates the marginal CDF of a variable of the 
  % population in a column vector of observations.
  params.learning_params.marginal_cdf = 'cdf_gaussian';
  
  params.sampling = 'sampling_ceda';
  params.sampling_params = struct();

  % A function that evaluates the inverse of the marginal CDF of a variable 
  % of the population in a column vector of values of the CDF.
  params.sampling_params.marginal_cdf_inverse = 'cdfinv_gaussian';

  params.seeding = 'seeding_uniform';
  params.seeding_params = struct();
  params.seeding_params.population_size = 100;

  params.replacing = 'replacing_none';
  params.replacing_params = struct();

  params.termination = {'termination_generations', 'termination_optimum'};
  params.termination_params = struct();
  params.termination_params.max_generations = 100;
  params.termination_params.error_tolerance = 1e-7;

  params.selection = 'selection_truncation';
  params.selection_params = struct();
  params.selection_params.truncation_coefficient = 0.3;

  params.verbose = {'verbose_simple'};
  params.verbose_params = struct();
end
