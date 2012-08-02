function verbose_simple(params, generation, population, fitness, ...
                        selected_population, selected_fitness, ...
                        sampled_population, sampled_fitness)
  % Prints one line with statistical information on each generation.

  best_fitness = min(fitness);
  mean_fitness = mean(fitness);
  std_fitness = std(fitness);
  if (generation == 1) 
    fprintf('%5s %12s %31s %12s\n', ...
      'GEN.', 'BEST FITNESS', 'MEAN FITNESS += STD. FITNESS', 'BEST ERROR')
  end
  if isfield(params.objective_params, 'optimum')
    fprintf('%5d %E (%E +- %E) %E\n', ...
      generation, best_fitness, mean_fitness, std_fitness, ...
      abs(params.objective_params.optimum - best_fitness))
  else
    fprintf('Gen: %d Best: %E Mean: %E Std: %E\n', ...
      generation, best_fitness, mean_fitness, std_fitness);
  end
  fflush(stdout);
end
