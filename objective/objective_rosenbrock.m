function fitness = objective_rosenbrock(params, population)
  % Rosenbrock objective function. 
  %
  % Global minima: x* = (1, ..., 1), f(x*) = 0.
  
  fitness = zeros(size(population, 1), 1);
  n = size(population, 2);
  x = population;
  for i = 1:n-1
    fitness = fitness + (100 .* (x(:,i+1) - x(:,i).^2).^2 + (x(:,i) - 1).^2);
  end
end
