function fitness = objective_sumcan(params, population)
  % Summation Cancellation objective function. 
  %
  % PARAMS is a struct with the parameters of the EDA and POPULATION the
  % population matrix. The output variable FITNESS is a column vector with
  % the evaluation of the function at each individual of the given population.
  %
  % The global minima: x* = (0, ..., 0), f(x*) = -10^5.
  
  [m, n] = size(population);
  y = zeros(m, n);
  y(:,1) = population(:,1);
  for i = 2:n
    y(:,i) = population(:,i) + y(:,i-1);
  end
  fitness = -1 ./ (10^-5 + sum(abs(y), 2));
end