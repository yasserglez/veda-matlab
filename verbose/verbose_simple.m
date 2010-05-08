function verbose_simple(params, generation, population, fitness, ...
                        selected_population, selected_fitness, ...
                        sampled_population, sampled_fitness)
  % Prints one line with statistical information on each generation.
  
  % Created by Yasser González Fernández (2010).

  best_fitness = min(fitness);
  mean_fitness = mean(fitness);
  std_fitness = std(fitness);
  fprintf('Gen: %d Best: %f Mean: %f Std: %f\n', ...
          generation, best_fitness, mean_fitness, std_fitness);
end
