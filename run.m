function run(parameters)
  % Run an Estimation of Distribution Algorithm.
  %
  % PARAMETERS is a struct that defines the parameters of the Estimation of
  % Distribution Algorithm. See the parameters directory for an example.

  % Created by Yasser González Fernández (2010).

  init_environment();
  params = feval(parameters);
   
  if ~params.quiet
    fprintf('%s\n\n', params.note);
    fprintf('Execution started at %s\n\n', datestr(now(), 31));
  end  
  
  % Vectors to collect statistics of all the runs.
  run_success = nan(params.runs, 1);
  num_generations = nan(params.runs, 1);
  num_evaluations = nan(params.runs, 1);
  best_fitness = nan(params.runs, 1);
  run_time = nan(params.runs, 1);
 
  for run = 1:params.runs
    tic();

    generation = 1;
    while true 
      if generation == 1
        % Execute the seeding method. Seeding methods are used to initialize the
        % first population used in the execution of the algorithm.
        sampled_population = feval(params.seeding, params);
      else
        % Execute the sampling method. Sampling methods are used to generate the
        % new population from the probabilistic model learned by the EDA.
        sampled_population = feval(params.sampling, params, model, ...
                                   selected_population, selected_evaluation);
      end

      % Evaluate the population in the objective function.
      sampled_evaluation = feval(params.objective, params, sampled_population);

      if generation > 1
        % Execute the replacing method. Replacing methods are used to combine
        % the individuals sampled in the current generation with the individuals
        % of the previous generation. It can be used to implement elitism.
        [sampled_population, sampled_evaluation] = ...
          feval(params.replacing, params, sampled_population, ...
                sampled_evaluation, previous_population, previous_evaluation);
              
        % Execute the verbose method. Verbose methods are used to print
        % information about the evolution of the population.
        if ~params.quiet
          feval(params.verbose, params, population, evaluation, ...
                selected_population, selected_evaluation, ...
                sampled_population, sampled_evaluation);
        end
      end
      
      population = sampled_population;
      evaluation = sampled_evaluation;
      
      % Update the global statistics of the runs.
      best_gen_fitness = min(evaluation);
      if isnan(best_fitness(run)) || best_gen_fitness < best_fitness(run)
        best_fitness(run) = best_gen_fitness;
      end      
      
      % Evaluate the termination condition. The termination condition is
      % evaluated at this point to avoid applying the selection and learning
      % methods in the last generation.
      terminate = feval(params.termination, params, generation, ...
                        population, evaluation);
      if terminate
        % Stop the evolution if a stop condition was satisfied.
        break;
      end

      % Execute the selection method. Selection methods define the group of
      % individuals that will be modeled using the probabilistic model.
      selection = feval(params.selection, params, population, evaluation);
      
      selected_population = population(selection,:);
      selected_evaluation = evaluation(selection);
      
      % Execute the learning method. Learning methods returns a probabilistic
      % model that its used to sample the population in the next generation.
      model = feval(params.learning, params, selected_population, ...
                    selected_evaluation);
      
      if ~params.quiet
        % Execute a verbose method. Verbose methods are used to print (or
        % anything similar) information about the current generation.
      end

      % Prepare for the next generation.
      previous_population = population;
      previous_evaluation = evaluation;
      generation = generation + 1;
    end
    
    % Current run is finished. Print information, if enabled.

    run_elapsed = toc();
    
    % Update the global statistics of the runs.
    run_time(run) = run_elapsed;
    num_generations(run) = generation;
    num_evaluations(run) = generation * params.seeding_params.population_size;
    if ~isnan(params.objective_params.optimum)
      tolerance = params.termination_params.error_tolerance;
      if abs(params.objective_params.optimum - best_fitness(run)) <= tolerance
        run_success(run) = true;
      else
        run_success(run) = false;
      end
    end
    
    if ~params.quiet
      msg = '\nRun %d of %d stoped at generation %d. Time: %f seconds.\n';
      fprintf(msg, run, params.runs, num_generations(run), run_time(run));
    end
  end

  % Print global statistics for all runs.
  if ~params.quiet
    fprintf('\n\nGlobal statistics of the runs (mean and standard deviation):\n\n');
    if ~isnan(params.objective_params.optimum)
      fprintf('Success: %f (%f)\n', mean(run_success), std(run_success));
    end
    fprintf('Number generations: %f (%f)\n', ...
            mean(num_generations), std(num_generations));
    fprintf('Number evaluations: %f (%f)\n', ...
            mean(num_evaluations), std(num_evaluations));
    fprintf('Best fitness in each generation: %f (%f)\n', ...
            mean(best_fitness), std(best_fitness));
    fprintf('Runtime: %f seconds (%f)\n', mean(run_time), std(run_time));

    fprintf('\n\nExecution finished at: %s\n', datestr(now(), 31));
  end
end

function init_environment()
  % Initialize the environment required to run the run_eda function.
  
  eda_path = genpath(pwd());
  addpath(eda_path);
end
