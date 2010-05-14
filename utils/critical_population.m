function critical_population(parameters, left, right, r, p)
  % Find the minimum population size required by an algorithm.
  %
  % Find the minimum population size required by the algorithm identified by the 
  % PARAMETERS to optimize the objective function with probability P in R runs. 
  % This algorithm uses bisection on the population size starting with the 
  % interval delimited by the LEFT and RIGHT values.
  
  % Created by Yasser González Fernández (2010).
  
  update_path();
  
  params = feval(parameters);
  params.runs = r;
  current_width = right - left;
  while current_width > 1
    fprintf('\nCurrent population interval: [%d, %d]\n\n', left, right);
    
    middle = round((left + right) / 2);
    params.seeding_params.population_size = middle;
    
    fprintf('Running %d runs with population size %d\n\n', ...
            r, params.seeding_params.population_size);
    middle_stats = run(@() params);
    middle_p = mean(middle_stats.success);
    fprintf('\nProbability in %d runs with population size %d: %f\n', ...
            r, params.seeding_params.population_size, middle_p);
    
    if middle_p < p
      left = middle;
    else
      right = middle;
    end
    current_width = right - left;
  end
  fprintf('\nCritical population size: %d\n', right);
end
