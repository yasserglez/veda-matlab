function verbose_scatter(params, generation, population, fitness, ...
                         selected_population, selected_fitness, ...
                         sampled_population, sampled_fitness)
  % Scatter plot of two variables in the different populations.
  %
  % This will create bivariate scatter plots for the given variables in the
  % current, selected and simulated populations. The variables are selected
  % by its indexes using the PARAMS.verbose_params.x_index (1 by default) and
  % PARAMS.verbose_params.y_index (2 by default) parameters. If the optimum of
  % the function is known, it also includes in the scatter plot a point for the
  % variables of PARAMS.objective_params.optimum_individual.
  
  % Created by Raúl José Arderí García (2007).
  % Modified by Yasser González Fernández (2010).
  
  if (isfield(params.verbose_params, 'x_index') && ...
      isfield(params.verbose_params, 'y_index'))
      x_index = params.verbose_params.x_index;
      y_index = params.verbose_params.y_index;
  else
      x_index = 1;
      y_index = 2;
  end
  
  lower_bounds = params.objective_params.lower_bounds;
  upper_bounds = params.objective_params.upper_bounds;
  x_lim = [lower_bounds(x_index), upper_bounds(x_index)];
  y_lim = [lower_bounds(y_index), upper_bounds(y_index)];  
  optimum_known = isfield(params.objective_params, 'optimum_individual');
  if optimum_known
    x_optimum = params.objective_params.optimum_individual(1,x_index);
    y_optimum = params.objective_params.optimum_individual(1,y_index);
  end

  set(gcf, 'NumberTitle', 'off');
  set(gcf, 'Name', 'Scatter Plots');  
  
  % Scatter plot of the variables in the population.
  subplot(1, 3, 1);
  scatter(population(:,x_index), population(:,y_index), '.');
  if optimum_known
    hold on;
    plot(x_optimum, y_optimum, '.r');
    hold off;
  end
  box on;
  axis equal;
  xlabel(sprintf('x_{%i}', x_index));
  ylabel(sprintf('x_{%i}', y_index));
  title(sprintf('Population\nGeneration %i', generation));
  xlim(x_lim);
  ylim(y_lim);
  
  % Scatter plot of the variables in the selected population.
  subplot(1, 3, 2);
  scatter(selected_population(:,x_index), selected_population(:,y_index), '.');
  if optimum_known
    hold on;
    plot(x_optimum, y_optimum, '.r');
    hold off;
  end  
  box on;
  axis equal;
  xlabel(sprintf('x_{%i}', x_index));
  ylabel(sprintf('x_{%i}', y_index));
  title(sprintf('Selected Population\nGeneration %i', generation));
  xlim(x_lim);
  ylim(y_lim);
  
  % Scatter plot of the variables in the sampled population.
  subplot(1, 3, 3);
  scatter(sampled_population(:,x_index), sampled_population(:,y_index), '.');
  if optimum_known
    hold on;
    plot(x_optimum, y_optimum, '.r');
    hold off;
  end  
  box on;
  axis equal;
  xlabel(sprintf('x_{%i}', x_index));
  ylabel(sprintf('x_{%i}', y_index));
  title(sprintf('Simulated Population\nGeneration %i', generation));
  xlim(x_lim);
  ylim(y_lim);
  
  drawnow;
end
