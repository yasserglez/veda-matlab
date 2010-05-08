function verbose_simple(params, generation, population, evaluation, ...
                        selected_population, selected_evaluation, ...
                        sampled_population, sampled_evaluation)
  % Prints one line with statistical information on each generation.
  
  % Created by Yasser González Fernández (2010).

  best_fitness = min(evaluation);
  mean_fitness = mean(evaluation);
  std_fitness = std(evaluation);
  fprintf('Gen: %d Best: %f Mean: %f Std: %f\n', ...
          generation, best_fitness, mean_fitness, std_fitness);
end
