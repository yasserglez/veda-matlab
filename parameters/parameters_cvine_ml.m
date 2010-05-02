function [params] = parameters_cvine_ml()  
  params = struct();

  params.note = 'Canonical vine estimated by maximum likelihood.';
  params.runs = 5;
  params.quiet = false;

  params.objective = 'objective_rosenbrock';
  params.objective_params = struct();
  params.objective_params.number_variables = 3;
  params.objective_params.variable_limits = repmat([0, 2], 3, 1);
  params.objective_params.optimum = 0;
  params.objective_params.optimum_individual = repmat(1, 1, 3);
  
  % LEARNING A CANONICAL VINE BY MAXIMUM LIKELIHOOD.
  
  params.learning = 'learning_cvine_ml';
  params.learning_params = struct();
  
  % Uniformly select a random ordering of the variables.
  params.learning_params.random_ordering = false;
  
  % A function that evaluates the marginal CDF of a variable of the population
  % in a column vector of observations.
  params.learning_params.marginal_cdf = 'cdf_normal';
  
  % A function that estimates the parameters of a bivariate copula from a column
  % vector of observations for each variable.
  params.learning_params.copula_fit = 'copulafit_gaussian';
  
  % h-function of the copulas used in the decomposition.
  params.learning_params.h_function = 'h_gaussian';
  
  params.sampling = 'sampling_cvine';
  params.sampling_params = struct(); 
  
  % h-function and inverse of the copulas used in the decomposition. 
  params.sampling_params.h_function = 'h_gaussian';
  params.sampling_params.h_inverse = 'hinv_gaussian';
  
  % A function that evaluates the inverse of the marginal CDF of a variable of
  % the population in a column vector of values of the CDF.
  params.sampling_params.marginal_cdf_inverse = 'cdfinv_normal';

  params.seeding = 'seeding_uniform';  
  params.seeding_params = struct();
  params.seeding_params.population_size = 200;
  
  params.replacing = 'replacing_none';
  params.replacing_params = struct();
  
  params.termination = 'termination_optimum';
  params.termination_params = struct();
  params.termination_params.max_generations = 25;
  params.termination_params.error_tolerance = 1e-7;
  
  params.selection = 'selection_truncation';
  params.selection_params = struct();
  params.selection_params.truncation_coefficient = 0.3;

  params.verbose = 'verbose_scattermatrix';
  params.verbose_params = struct();
end
