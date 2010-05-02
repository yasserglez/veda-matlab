function verbose_scattermatrix(params, generation, population, evaluation, ...
                               selected_population, selected_evaluation, ...
                               sampled_population, sampled_evaluation)
  % Histograms and scatter plots for all pairs of variables.
  
  % Created by Yasser González Fernández (2010).
  
  [handles, axes_handles] = plotmatrix(population);
  set(gcf, 'NumberTitle', 'off');
  set(gcf, 'Name', 'Scatter Plots Matirx');
  title(sprintf('Generation %i', generation));
  for k = 1:size(axes_handles, 1)
    ylabel(axes_handles(k,1), sprintf('x_{%i}', k));
    xlabel(axes_handles(size(axes_handles, 1),k), sprintf('x_{%i}', k));
  end
  
  drawnow;
end
