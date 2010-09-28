function fitness = objective_sphere(params, population)
  % Sphere objective function. 
  %
  % The global minima: x* = (0, ..., 0), f(x*) = 0.

  fitness = sum(population .^ 2, 2);
end
