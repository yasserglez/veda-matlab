function verbose_scatter(params, generation, population, evaluation, ...
                         selected_population, selected_evaluation, ...
                         sampled_population, sampled_evaluation)
  % Scatter plot of two variables in the different populations.
  %
  % This will create bivariate scatter plots for the given variables in the
  % current, selected and simulated populations. The variables are selected
  % by its indexes using the PARAMS.verbose_params.x_index and
  % PARAMS.verbose_params.y_index parameters.
  
  % Created by Raúl José Arderí García (2007).
  % Modified by Yasser González Fernández (2010).
  
  x_index = params.verbose_params.x_index;
  y_index = params.verbose_params.y_index;
  x_lim = params.objective_params.variable_limits(x_index,:);
  y_lim = params.objective_params.variable_limits(y_index,:);
  
  set(gcf, 'NumberTitle', 'off');
  set(gcf, 'Name', 'Scatter Plots');  
  
  % Scatter plot of the variables in the population.
  subplot(1, 3, 1);
  scatter(population(:,x_index), population(:,y_index), '.');
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
  box on;
  axis equal;
  xlabel(sprintf('x_{%i}', x_index));
  ylabel(sprintf('x_{%i}', y_index));
  title(sprintf('Simulated Population\nGeneration %i', generation));
  xlim(x_lim);
  ylim(y_lim);
  
  drawnow;
end
