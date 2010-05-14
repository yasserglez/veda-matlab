function update_path()
  file_path = mfilename('fullpath');
  seps = strfind(file_path, filesep);
  eda_path = file_path(1:seps(end-1));
  addpath(genpath(eda_path));
end
