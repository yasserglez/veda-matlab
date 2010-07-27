function boxplot_population()
  % Generate boxplot plots from populations.
  %
  % Reads the files saved using the verbose_populations verbose method found in
  % the current working directory and generates boxplot plots.
 
  files = dir('*population*.dat');
  for i = 1:numel(files)
    file = files(i);
    if ~file.isdir
      [path, name] = fileparts(file.name);
      pop = load(file.name, '-ascii');
      figure('Visible', 'off');
      boxplot(pop, 'whisker', Inf);
      title(strrep(file.name, '_', '\_'));
      plotfile = strcat(name, '_boxplot', '.jpg');
      print('-djpeg', plotfile);
    end
  end
end
