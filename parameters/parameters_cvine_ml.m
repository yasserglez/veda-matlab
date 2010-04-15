function [params] = parameters_cvine_ml()  
  params = struct();

  params.note = 'Canonical vine estimated by maximum likelihood.';
  params.runs = 1;
  params.quiet = false;

  params.objective = 'objective_sphere';
  params.objective_params = struct();
  params.objective_params.number_variables = 1000;
  params.objective_params.variable_bounds = repmat([-100; 100], 1, 1000);
  params.objective_params.optimum = 0;
  
  % LEARNING A CANONICAL VINE BY MAXIMUM LIKELIHOOD.
  
  params.learning = 'learning_cvine_ml';
  
  params.learning_params = struct();  
  
  % A function that evaluates the marginal cdf of a variable of the population
  % in a column vector of observations. Currently we assume the marginals have
  % the same distribution but can be extended to use different marginals
  % distributions.
  params.learning_params.marginal_cdf = 'empirical_cdf';
  
  % A function that estimates the parameters of a bivariate copula from a column
  % vector of observations for each variable. Currently, we are using the same
  % copula for each pair-copula but can be extended to use different copulas. 
  params.learning_params.copula_fit = 'copula_fit_gaussian';
  
  % h-function corresponding to the copulas used in the decomposition.
  params.learning_params.h_function = 'h_gaussian';
  
  params.sampling = 'sampling_cvine';
  params.sampling_params = struct();  

  params.seeding = 'seeding_uniform';  
  params.seeding_params = struct();
  params.seeding_params.population_size = 100;
  
  params.replacing = 'replacing_none';
  params.replacing_params = struct();
  
  params.termination = 'termination_generations_optimum';
  params.termination_params = struct();
  params.termination_params.max_generations = 10;
  params.termination_params.error_tolerance = 1e-10;
  
  params.selection = 'selection_truncation';
  params.selection_params = struct();
  params.selection_params.truncation_coefficient = 0.5;

  params.verbose = 'verbose_none';
  params.verbose_params = struct();
end
