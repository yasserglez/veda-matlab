function verbose_scattermatrix(params, generation, population, evaluation, ...
                               selected_population, selected_evaluation, ...
                               sampled_population, sampled_evaluation)
  % Histograms and scatter plots for all pairs of variables.
  %
  % This verbose method uses the PLOTMATRIX function to plot histograms
  % and scatter plots for all pairs of variables in the population. If the
  % optimum of the function is known, it also includes in the scatter plots a
  % point for the variables of PARAMS.objective_params.optimum_individual.
  
  % Created by Yasser González Fernández (2010).
  
  [handles, axes_handles] = plotmatrix(population);
  set(gcf, 'NumberTitle', 'off');
  set(gcf, 'Name', 'Scatter Plots Matirx');
  title(sprintf('Generation %i', generation));
  for k = 1:size(axes_handles, 1)
    ylabel(axes_handles(k,1), sprintf('x_{%i}', k));
    xlabel(axes_handles(size(axes_handles, 1),k), sprintf('x_{%i}', k));
  end
  if ~isnan(params.objective_params.optimum_individual)
    for i = 1:size(axes_handles,2)
      for j = 1:size(axes_handles,1)
        if i ~= j
          hold(axes_handles(i,j), 'on');
          i_optimum = params.objective_params.optimum_individual(1,i);
          j_optimum = params.objective_params.optimum_individual(1,j);
          plot(axes_handles(i,j), i_optimum, j_optimum, '.r');
          hold(axes_handles(i,j), 'off');
        end
      end
    end    
  end
  
  drawnow;
end
