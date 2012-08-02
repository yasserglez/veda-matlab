function stats = main(params)
  % Main loop of an Estimation of Distribution Algorithm.
  %
  % PARAMS is a struct that defines the parameters of the Estimation
  % of Distribution Algorithm. See cveda.m and dveda.m for examples.

  if ~params.quiet
    fprintf('%s\n\n', params.note);
    fprintf('Run started at %s\n\n', datestr(now(), 31));
  end  
  
  % Vectors that collect statistics of the runs.
  run_success = nan(params.runs, 1);
  run_errors = nan(params.runs, 1);
  run_generations = nan(params.runs, 1);
  run_evaluations = nan(params.runs, 1);
  run_fitness = nan(params.runs, 1);
  run_time = nan(params.runs, 1);
 
  for run = 1:params.runs
    tic();

    % Initialize statistics for this run.
    run_generations(run) = 0;
    run_evaluations(run) = 0;
    
    while true 
      if run_generations(run) == 0
        % Seeding method.
        sampled_population = feval(params.seeding, params);
      else
        % Sampling method.
        sampled_population = feval(params.sampling, params, model, ...
                                   selected_population, selected_fitness);
      end

      % Evaluate the population in the objective function.
      sampled_fitness = feval(params.objective, params, sampled_population);

      if run_generations(run) > 0
        % Report progress information.
        if ~params.quiet
          for i = 1:numel(params.verbose)
            feval(params.verbose{i}, params, run_generations(run), ...
                  population, fitness, selected_population, selected_fitness, ...
                  sampled_population, sampled_fitness);
          end
        end
      end

      population = sampled_population;
      fitness = sampled_fitness;

      % Update the statistics of this run.
      best_current = min(fitness);
      if isnan(run_fitness(run)) || best_current < run_fitness(run)
        run_fitness(run) = best_current;
      end
      run_evaluations(run) = run_evaluations(run) + ...
                             params.seeding_params.population_size;      

      % Evaluate the termination conditions.
      terminate = false;
      for i = 1:numel(params.termination)
        terminate = feval(params.termination{i}, params, ...
                          run_generations(run), run_evaluations(run), ...
                          population, fitness);
        if terminate
          % Break the loop for the termination conditions.
          break;
        end
      end
      if terminate
        % Break the main loop of the EDA.
        break;
      end

      % Selection method.
      selection = feval(params.selection, params, population, fitness);
      selected_population = population(selection,:);
      selected_fitness = fitness(selection);
      
      % Learning method.
      model = feval(params.learning, params, selected_population, ...
                    selected_fitness);

      run_generations(run) = run_generations(run) + 1;
    end

    % Update the statistics of this run that just finished.
    run_time(run) = toc();
    if isfield(params.objective_params, 'optimum')
      tolerance = params.termination_params.error_tolerance;
      run_errors(run) = abs(params.objective_params.optimum - run_fitness(run));
      if run_errors(run) <= tolerance
        run_success(run) = true;
      else
        run_success(run) = false;
      end
    end

    if ~params.quiet
      msg = '\nRun %d of %d stoped at generation %d. Time: %f seconds\n\n';
      fprintf(msg, run, params.runs, run_generations(run), run_time(run));
    end
  end

  % Print global statistics for all runs.
  if ~params.quiet
    fprintf('\nGlobal statistics (mean and standard deviation):\n\n');
    if isfield(params.objective_params, 'optimum')
      fprintf('  Success: %f (%f)\n', mean(run_success), std(run_success));
      fprintf('  Errors: %E (%E)\n', mean(run_errors), std(run_errors));
    end
    fprintf('  Number generations: %f (%f)\n', ...
            mean(run_generations), std(run_generations));
    fprintf('  Number evaluations: %f (%f)\n', ...
            mean(run_evaluations), std(run_evaluations));
    fprintf('  Best fitness: %E (%E)\n', ...
            mean(run_fitness), std(run_fitness));
    fprintf('  Runtime: %f seconds (%f)\n', mean(run_time), std(run_time));

    fprintf('\n\Run finished at: %s\n', datestr(now(), 31));
  end

  % Return the statistics.
  if nargout ~= 0
    stats = struct();
    stats.success = run_success;
    stats.errors = run_errors;
    stats.generations = run_generations;
    stats.evaluations = run_evaluations;
    stats.fitness = run_fitness;
    stats.time = run_time;
  end
end
