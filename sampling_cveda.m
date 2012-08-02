function population = ...
    sampling_cveda(params, model, selected_population, selected_fitness)
  % Sampling function of the C-Vine EDA.
  %
  % PARAMS is a struct with the parameters of the EDA. MODEL is a struct
  % that represents the canonical vine, see the documentation of the
  % learning_cveda function for information about its fields.
  % SELECTED_POPULATION is the population from where the canonical vine was
  % estimated and SELECTED_FITNESS its evaluation.
  %
  % The output variable POPULATION is the random population sampled from the
  % canonical vine. The population is returned as a matrix with columns for
  % variables and rows for indiviluals. The number of individuals in the
  % population is given by PARAMS.seeding_params.population_size.

  pop_size = params.seeding_params.population_size;
  n = params.objective_params.number_variables;
  q_margin = params.sampling_params.q_margin;

  ordering = model.ordering;
  theta = model.theta;
  h_functions = model.h_functions;
  h_inverses = model.h_inverses;
  vine_trees = model.vine_trees;

  uniform_pop = zeros(pop_size, n);
  W = unifrnd(0, 1, pop_size, n);
  v = sparse(n, n);

  for individual = 1:pop_size
    w = W(individual,:);
    v(1,1) = w(1);
    uniform_pop(individual,1) = v(1,1);

    for i = 2:n
      % Sampling the i-th variable.
      v(i,1) = w(i);
      for k = min(vine_trees, i-1):-1:1
        v(i,1) = feval(h_inverses{k,i-k}, v(i,1), v(k,k), theta{k,i-k});
      end
      uniform_pop(individual,i) = v(i,1);

      % Compute the h-inverse values needed for the (i+1)-th variable.
      if i ~= n
        for j = 1:min(vine_trees, i-1)
          v(i,j+1) = feval(h_functions{j,i-j}, v(i,j), v(j,j), theta{j,i-j});
        end
      end
    end
  end

  % Transform the Uniform(0,1) population into the domain of the function.
  population = zeros(pop_size, n);
  for k = 1:n
    population(:,ordering(k)) = ...
      feval(q_margin, selected_population(:,ordering(k)), uniform_pop(:,k));
  end
end
