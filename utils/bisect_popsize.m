function bisect_popsize(parameters, left, right, width, r, p)
  % Find bounds for the minimum population size required for an algorithm.
  %
  % Find an interval smaller that WIDTH for the minimum population size required
  % by the algorithm identified by the PARAMETERS to optimize the objective
  % function with probability P in R runs. This algorithm uses bisection on the
  % population size starting with the interval delimited by the LEFT and RIGHT
  % values.
  
  % Created by Yasser González Fernández (2010).  
  
  init_env();
  
  params = feval(parameters);
  params.quiet = true;
  params.runs = r;
  
  current_width = right - left;
  while current_width > width
    fprintf('Current population bounds: [%d, %d]\n', left, right);
    
    middle = round((left + right) / 2);
    params.seeding_params.population_size = middle;
    
    fprintf('Running with population size %d: ', ...
            params.seeding_params.population_size);
    middle_stats = run(@() params);
    middle_p = mean(middle_stats.success);
    fprintf('%f\n', middle_p);
    
    if middle_p < p
      left = middle;
    else
      right = middle;
    end
    current_width = right - left;
  end
  fprintf('Final population bounds: [%d, %d]\n', left, right);
end

function init_env()
  % Initialize the environment required to run the function.
  
  eda_path = genpath(pwd());
  addpath(eda_path);
end
