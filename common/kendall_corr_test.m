function h = kendall_corr_test(x, y, alpha)
  % Test whether two samples come from uncorrelated populations.
  
  if exist('kendall', 'file') == 2
    % Octave Statistics Package.
    p = corr_test(x, y, '!=', 'kendall');
  else
    % MATLAB Statistics Toolbox.
    [tau, p] = corr(x, y, 'type', 'Kendall');
  end

  h = (p <= alpha);
end
