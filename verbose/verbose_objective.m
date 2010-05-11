function verbose_objective(params, generation, population, fitness, ...
                           selected_population, selected_fitness, ...
                           sampled_population, sampled_fitness)
  % Plots the objective function and the best and optimum individuals.
  %
  % The position of the camera can be set by the optional parameters
  % PARAMS.verbose_params.azimuth and PARAMS.verbose_params.elevation. See the
  % documentation of the view function for more information.
  
  % Created by Yasser González Fernández (2010).
  
  % Setup parameters.
  lower_bounds = params.objective_params.lower_bounds;
  upper_bounds = params.objective_params.upper_bounds;
  x_lim = [lower_bounds(1), upper_bounds(1)];
  y_lim = [lower_bounds(2), upper_bounds(2)];
  if (isfield(params.verbose_params, 'azimuth') && ...
      isfield(params.verbose_params, 'elevation'))
    azimuth = params.verbose_params.azimuth;
    elevation = params.verbose_params.elevation;      
  else
    azimuth = -45;
    elevation = 30;
  end
  
  x = linspace(x_lim(1), x_lim(2));
  y = linspace(y_lim(1), y_lim(2));
  [X, Y] = meshgrid(x, y);
  Z = zeros(size(X));
  for i = 1:size(X, 1)
    for j = 1:size(X, 2)
      Z(i,j) = feval(params.objective, params, [X(i,j), Y(i,j)]);
    end
  end
  
  % Plot the surface of the objective function.
  surf(X, Y, Z, 'EdgeColor', 'none');
  colormap('gray');
  x_min = floor(x_lim(1));
  x_max = ceil(x_lim(2));
  y_min = floor(y_lim(1));
  y_max = ceil(y_lim(2));
  axis([x_min, x_max, y_min, y_max]); 
  grid('on');
  xlabel('x');
  ylabel('y');
  zlabel('f(x,y)');
  
  % Plot a marker for the optimum individual (if known).
  if isfield(params.objective_params, 'optimum_individual')
    hold('on');
    x_optimum = params.objective_params.optimum_individual(1,1);
    y_optimum = params.objective_params.optimum_individual(1,2);
    z_optimum = feval(params.objective, params, [x_optimum, y_optimum]);
    plot3(x_optimum, y_optimum, z_optimum, '.r', 'MarkerSize', 18);
    hold('off');
  end
  
  % Plot a marker for the best individual of the population.
  hold('on');
  [best_fitness, best_index] = min(fitness);
  best_indiv = population(best_index,:);
  plot3(best_indiv(1), best_indiv(2), best_fitness, '.b', 'MarkerSize', 18);
  hold('off');

  set(gcf, 'NumberTitle', 'off');
  set(gcf, 'Name', 'Objective Function');
  title(sprintf('Generation %i', generation));
  view(azimuth, elevation);
  
  drawnow;
end
