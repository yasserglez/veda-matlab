function h = kendall_corr_test(x, y, alpha)
  % Independence test based on the Kendall's tau rank correlation coefficient.

  if exist('kendall', 'file') == 2
    % Octave Statistics Package.
    p = cor_test(x, y, '!=', 'kendall');
    p = p.pval;
  else
    % MATLAB Statistics Toolbox.
    [tau, p] = corr(x, y, 'type', 'Kendall');
  end

  h = (p <= alpha);
end
