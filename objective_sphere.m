function fitness = objective_sphere(params, population)
  % Sphere.  x* = (0, ..., 0). f(x*) = 0.

  fitness = sum(population .^ 2, 2);
end
