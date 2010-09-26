function params = parameters_veda()
  params = struct();

  params.note = 'C-Vine EDA with Gaussian marginals.';
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

  params.learning = 'learning_veda_ml';
  params.learning_params = struct();
  
  % Type of vine: CVine or DVine.
  params.learning_params.vine_type = 'CVine';

  % Number of trees of the vine that will represent dependence and
  % conditional dependence. Assume conditional independence for the rest.
  params.learning_params.max_trees = 2;
  
  % A function that selects an ordering of the variables in the vine.
  params.learning_params.ordering = 'ordering_stronger';

  % A function that evaluates the marginal CDF of a variable of the population
  % in a column vector of observations.
  params.learning_params.marginal_cdf = 'cdf_gaussian';
  
  % Significance level of the hypothesis test for correlation to check if there
  % is enough evidence of dependence before fitting a copula. If the
  % independence is not rejected at this significance level, the Independence 
  % copula will be used.
  params.learning_params.cor_test_level = 0.1;
  
  % Candidate copulas for the pair copula construction. The algorithm learning
  % the vine will select the "best" copula from this list for each copula in
  % the decomposition.
  params.learning_params.copulas = {'Gaussian'};

  params.sampling = 'sampling_veda';
  params.sampling_params = struct();

  % A function that evaluates the inverse of the marginal CDF of a variable of
  % the population in a column vector of values of the CDF.
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
