function plotmatrix_population_u(marginal_cdf)
  % Generate plotmatrix plots from populations transformed to the unit interval.
  %
  % Reads the files saved using the verbose_populations verbose method found in
  % the current working directory and generates plotmatrix plots of the
  % populations transformed to the unit interval (the copula space).
 
  files = dir('*population*.dat');
  for i = 1:numel(files)
    file = files(i);
    if ~file.isdir
      [path, name] = fileparts(file.name);
      pop = load(file.name, '-ascii');
      % Transforming the population.
      upop = zeros(size(pop));
      for k = 1:size(pop, 2)
        upop(:,k) = feval(marginal_cdf, pop(:,k), pop(:,k));
      end
      % Plotting.
      figure('Visible', 'off');
      plotmatrix(upop);
      title(strrep(file.name, '_', '\_'));
      plotfile = strcat(name, '_plotmatrix_uniform', '.jpg');
      print('-djpeg', plotfile);
    end
  end
end
