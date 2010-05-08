function verbose_details(params, generation, population, fitness, ...
                         selected_population, selected_fitness, ...
                         sampled_population, sampled_fitness)
  % Prints detailed statistical information on each generation.
  
  % Created by Yasser González Fernández (2010).
  
  fprintf('\nDetailed statistics for generation %d:\n', generation);
  [best_fitness, best_index] = min(fitness);
  n = params.objective_params.number_variables;
  message = sprintf('  Best individual:%s\n', repmat(' %f', 1, n));
  fprintf(message, population(best_index,:));
  fprintf('  Best individual fitness: %f\n', best_fitness);
  fprintf('  Population fitness: %f (%f)\n', mean(fitness), std(fitness));
  fprintf('  Selected population fitness: %f (%f)\n', ...
          mean(selected_fitness), std(selected_fitness));
  fprintf('  Sampled population fitness: %f (%f)\n', ...
          mean(sampled_fitness), std(sampled_fitness));
end
