function criticalpop(parameters, left, right, r, p)
  % Find the minimum population size required by an algorithm.
  %
  % Find the minimum population size required by the algorithm identified by the 
  % PARAMETERS to optimize the objective function with probability P in R runs. 
  % This algorithm uses bisection on the population size starting with the 
  % interval delimited by the LEFT and RIGHT values.
  
  % Created by Yasser González Fernández (2010).
  
  init();
  
  params = feval(parameters);
  params.runs = 1;
  params.quiet = true;
  
  current_width = right - left;
  while current_width > 1
    fprintf('\nCurrent population interval: [%d, %d]\n\n', left, right);
    
    middle = round((left + right) / 2);
    params.seeding_params.population_size = middle;
    
    stats = NaN;
    num_fails = 0;
    num_success = 0;
    while (num_success + num_fails) < r
      fprintf('Run #%d with population size %d...', ...
              num_success + num_fails + 1, middle);
      run_stats = runeda(@() params);
      if run_stats.success == 0
        fprintf('FAILED!\n');
        num_fails = num_fails + 1;
        if (num_fails / r) > (1 - p)
          break;
        end
      else
        fprintf('OK!\n');
        num_success = num_success + 1;
        if isstruct(stats)
          stats.success = [stats.success, run_stats.success];
          stats.errors = [stats.errors, run_stats.errors];
          stats.generations = [stats.generations, run_stats.generations];
          stats.evaluations = [stats.evaluations, run_stats.evaluations];
          stats.fitness = [stats.fitness, run_stats.fitness];
          stats.time = [stats.time, run_stats.time];
        else
          stats = run_stats;
        end
      end
    end
    
    if (num_fails / r) <= (1 - p)
      fprintf('\nGlobal statistics in %d runs:\n\n', r);
      fprintf('  Success: %f\n', num_success / r);
      fprintf('  Errors: %g (%g)\n', mean(stats.errors), std(stats.errors));
      fprintf('  Number generations: %f (%f)\n', ...
              mean(stats.generations), std(stats.generations));
      fprintf('  Number evaluations: %f (%f)\n', ...
              mean(stats.evaluations), std(stats.evaluations));
      fprintf('  Best fitness: %g (%g)\n', ...
              mean(stats.fitness), std(stats.fitness));
      fprintf('  Run time: %g secs. (%g)\n', ...
              mean(stats.time), std(stats.time));            
            
      right = middle;
    else
      fprintf('\nThe population size %d is too small.\n', middle);

      left = middle;
    end
    
    current_width = right - left;
  end
  fprintf('\nCritical population size: %d\n', right);
end
