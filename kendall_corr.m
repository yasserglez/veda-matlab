function tau = kendall_corr(x, y)
  % Kendall's tau rank correlation coefficient.

  if exist('kendall', 'file') == 2
    % Octave Statistics Package.
    tau = kendall(x, y);
  else
    % MATLAB Statistics Toolbox.
    tau = corr(x, y, 'type', 'Kendall');
  end
end
