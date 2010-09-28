function fitness = objective_rastrigin(params, population)
  % Rastrigin objective function. 
  %
  % The global minima: x* = (0, ..., 0), f(x*) = 0.

  fitness = sum((population .^ 2) - 10 * cos(2*pi * population) + 10, 2);
end
