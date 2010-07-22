function plotmatrix_population()
  % Generate plotmatrix plots from populations.
  %
  % Reads the files saved using the verbose_populations verbose method found in
  % the current working directory and generates plotmatrix plots.
 
  files = dir('*population*.dat');
  for i = 1:numel(files)
    file = files(i);
    if ~file.isdir
      [path, name] = fileparts(file.name);
      pop = load(file.name, '-ascii');
      figure('Visible', 'off');
      plotmatrix(pop);
      title(strrep(file.name, '_', '\_'));
      plotfile = strcat(name, '.jpg');
      print('-djpeg', plotfile);
    end
  end
end
