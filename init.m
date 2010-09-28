function init()
  % Initialize the environment required to run the EDA.
  
  global INIT;
  
  if isempty(INIT)
    % Initialize the random number generator using a time-dependent seed.
    RandStream.setDefaultStream(RandStream('mt19937ar', 'seed', sum(100 * clock)));
  
    % Add subdirectories to the MATLAB path.
    addpath(genpath(pwd()));
    
    % Initialize the RMatlab interface to GNU R.
    initializeR({'Rmatlab', '--quiet', '--no-save', '--no-restore'});
    callR('source', 'R/scripts/VEDA.R');
    
    % Set a flag to avoid executing this code multiple times.
    INIT = true;
  end
end
