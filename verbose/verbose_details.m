function verbose_details(params, generation, population, evaluation, ...
                         selected_population, selected_evaluation, ...
                         sampled_population, sampled_evaluation)
  % Prints detailed statistical information on each generation.
  
  % Created by Yasser González Fernández (2010).
  
  fprintf('\nStatistics for generation %d:\n', generation);
  [best_fitness, best_index] = min(evaluation);
  n = params.objective_params.number_variables;
  message = sprintf('  Best population individual:%s\n', repmat(' %f', 1, n));
  fprintf(message, population(best_index,:));
  fprintf('  Best population individual fitness: %f\n', best_fitness);
  fprintf('  Population fitness: %f (%f)\n', mean(evaluation), std(evaluation));
  fprintf('  Selected population fitness: %f (%f)\n', ...
          mean(selected_evaluation), std(selected_evaluation));
  fprintf('  Sampled population fitness: %f (%f)\n', ...
          mean(sampled_evaluation), std(sampled_evaluation));
end
