function init()
  % Initialize the environment required to run the EDA.
  
  global EDA_INITIALIZED;
  
  if isempty(EDA_INITIALIZED)
    % Add subdirectories to the MATLAB path.
    addpath(genpath(pwd()));
    
    % Initialize the RMatlab interface to GNU R.
    initializeR({'Rmatlab', '--quiet', '--no-save', '--no-restore'});
    callR('library', 'copula');
    callR('source', 'R/scripts/gofCopulaWrapper.R');
    
    % Set the flag to avoid executing this code multiple times.
    EDA_INITIALIZED = true;
  end
end
