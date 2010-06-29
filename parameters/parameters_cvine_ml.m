function params = parameters_cvine_ml()
  params = struct();

  params.note = 'Canonical vine estimated by maximum likelihood.';
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

  % LEARNING A CANONICAL VINE BY MAXIMUM LIKELIHOOD.

  params.learning = 'learning_cvine_ml';
  params.learning_params = struct();

  % Number of trees of the cannonical vine that will represent dependence and
  % conditional dependence between the variables and assume conditional
  % independence for the rest of the trees.
  params.learning_params.max_trees = 4;

  % A function that evaluates the marginal CDF of a variable of the population
  % in a column vector of observations.
  params.learning_params.marginal_cdf = 'cdf_gaussian';
  
  % Functions to make a goodness-of-fit test. One function for each copula to be
  % considered to model the bivariate relationships in the C-vine. This should
  % match the order of the h-functions and its inverses.
  params.learning_params.gof_copulas = {'gof_gaussian', 'gof_frank'};

  % h-functions and inverse of the copula used in the C-vine. This should match
  % the order of the goodness-of-fit test functions.
  params.learning_params.h_functions = {'h_gaussian', 'h_frank'};
  params.learning_params.h_inverses = {'hinv_gaussian', 'hinv_frank'};

  params.sampling = 'sampling_cvine';
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
  params.termination_params.max_generations = 25;
  params.termination_params.error_tolerance = 1e-7;

  params.selection = 'selection_truncation';
  params.selection_params = struct();
  params.selection_params.truncation_coefficient = 0.3;

  params.verbose = {'verbose_simple'};
  params.verbose_params = struct();
end
