function [params] = parameters_default()  
  params = struct();

  % GENERAL PARAMETERS OF THE EXECUTION.

  % A note that will be printed as part of the output of the algorithm.
  params.note = 'Default EDA';

  % The algorithm will run this number of times.
  params.runs = 1;
  
  % Do not print anything to the standard output.
  params.quiet = false;


  % PARAMETERS OF THE OBJECTIVE FUNCTION TO BE MINIMIZED.

  % Name of the objective function. It should be one of the functions defined in
  % the M-files in the objective directory.
  params.objective = 'objective_sphere';

  params.objective_params = struct();

  % Number of variables of the objective function.
  params.objective_params.number_variables = 2;
  n = params.objective_params.number_variables;

  % Minimum and maximum values for each variable.
  params.objective_params.lower_bounds = repmat(-5.12, 1, n);
  params.objective_params.upper_bounds = repmat(5.12, 1, n);
  
  % Optimum individual and optimum value of the function. This parameters 
  % should be set to NaN if the are not known.
  params.objective_params.optimum = 0;
  params.objective_params.optimum_individual = repmat(0, 1, n);


  % PARAMETERS OF THE SEEDING METHOD.

  % Function used to implement the seeding strategy. It should be one of the
  % functions defined in the M-files in the seeding directory. Seeding methods
  % are used to initialize the first population used in the execution of the
  % algorithm.
  params.seeding = 'seeding_uniform';
  
  params.seeding_params = struct();
  
  % Number of solutions in the population.
  params.seeding_params.population_size = 100;
  
  
  % PARAMETERS OF THE REPLACING METHOD.
  
  % Function used to implement a replacing strategy. It should be one of the
  % functions defined in the M-files in the replacing directory. Replacing
  % methods are used to combine the individuals sampled in the current
  % generation with the individuals of the previous generation.
  params.replacing = 'replacing_none';
  
  params.replacing_params = struct();
  
  
  % PARAMETERS OF THE STOP CONDITION.
  
  % Functions used to check the stop condition. It should be set to a cell
  % array containing functions defined in the M-files in the termination 
  % directory. All this functions will be evaluated on each generation, if one 
  % of them returns 1 the the algorithm will stop.
  params.termination = {'termination_generations', 'termination_optimum'};
  
  params.termination_params = struct();
  
  % Maximum number of generations and the error tolerance when checking the
  % evaluation of the objective function against the known optimum.
  params.termination_params.max_generations = 10;
  params.termination_params.error_tolerance = 1e-7;
  
  
  % PARAMETERS OF THE SELECTION METHOD.
  
  % Function used to implement the selection method. It should be one of the
  % functions defined in the M-files in the selection directory. Selection
  % methods determine the group of individuals that will be modeled using the
  % probabilistic model.
  params.selection = 'selection_truncation';
  
  params.selection_params = struct();
  
  % Coefficient between 0 and 1 that determines the number of individuals of the
  % population will be selected to build the probabilistic model.
  params.selection_params.truncation_coefficient = 0.3;
  
 
  % PARAMETERS OF THE LEARNING METHOD.
  
  % Function used to implement the learning method. It should be one of the
  % functions defined in the M-files in the learning directory. The selected
  % learning method have to be consistent with the sampling algorithm.
  params.learning = '';

  params.learning_params = struct();  
  
  
  % PARAMETERS OF THE SAMPLING METHOD.
  
  % Execute the sampling method. Sampling methods are used to generate the new
  % population from the probabilistic model learned by the EDA. The sampling
  % method is therefore dependent of the learning method used in the algorithm.
  params.sampling = '';
  
  params.sampling_params = struct();
  
  
  % PARAMETERS RELATED WITH THE INFORMATION PRINTED FOR EACH GENERATION.
  
  % Functions used print information during the evolution. It should be set to a
  % cell array containing functions defined in the M-files in the verbose
  % directory.
  params.verbose = {'verbose_none'};
  
  params.verbose_params = struct();
end
