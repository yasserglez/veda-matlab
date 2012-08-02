% Running the D-Vine Estimation of Distribution Algorithm.

params = struct();

% A note that will be printed as part of the output of the algorithm.
params.note = 'D-Vine EDA';

% The algorithm will run this number of times.
params.runs = 1;

% Supress output on the standard output.
params.quiet = false;

% Parameters of the objective function.
params.objective = 'objective_sphere';
params.objective_params = struct();
params.objective_params.number_variables = 10;
n = params.objective_params.number_variables;
params.objective_params.lower_bounds = repmat(-600, 1, n);
params.objective_params.upper_bounds = repmat(600, 1, n);
params.objective_params.optimum = 0;
params.objective_params.optimum_individual = repmat(0, 1, n);

params.learning = 'learning_dveda';
params.learning_params = struct();

% Number of trees of the D-vine (for the rest of the trees, conditional 
% independence is assumed).
params.learning_params.vine_trees = n - 1;

% Significance level of the independence test. The product copula will be 
% selected if there is not enough evidence of dependence.
params.learning_params.cor_test_level = 0.1;

% A function that evaluates the distribution function of the margins.
params.learning_params.p_margin = 'p_norm';

params.sampling = 'sampling_cveda';
params.sampling_params = struct();

% A function that evaluates the quantile function of the margins.
params.sampling_params.q_margin = 'q_norm';

params.seeding = 'seeding_uniform';
params.seeding_params = struct();
params.seeding_params.population_size = 30 * n;

params.termination = {'termination_generations', 'termination_optimum'};
params.termination_params = struct();
params.termination_params.max_generations = 100;
params.termination_params.error_tolerance = 1e-6;

params.selection = 'selection_truncation';
params.selection_params = struct();
params.selection_params.truncation_coefficient = 0.3;

params.verbose = {'verbose_simple'};
params.verbose_params = struct();

% Run the main loop of the EDA.
main(params)
