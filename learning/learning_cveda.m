function model = learning_cveda_ml(params, population, fitness)
  % Learn function of the C-Vine EDA.
  %
  % PARAMS is a struct with the parameters of the EDA. PUPULATION is the
  % population from where the probabilistic model should be learned and
  % FITNESS is the fitness of the individuals of this popualtion.
  %
  % A canonical vine is defined by an ordering of the variables and the
  % parameters of each copula density in the factorization. The output variable
  % MODEL will be an struct with the following fields:
  %
  %   * ordering: vector with the ordering of the variables,
  %   * theta: cell array with the parameters of each bivariate copula in the
  %     pair-copula decomposition,
  %   * h_functions: cell array with the h-functions corresponding to each
  %     bivariate copula in the pair-copula decomposition,
  %   * h_inverses: cell array with the inverse of the h-functions corresponding
  %     to each bivariate copula in the pair-copula decomposition.
  %   * max_trees: maximum number of trees of the canonical vine (for the rest
  %     of the trees, conditional independence is assumed).

  pop_size = size(population, 1);
  num_vars = size(population, 2);
  if ~isfield(params.learning_params, 'max_trees')
    params.learning_params.max_trees = num_vars - 1;
  end

  % Select an ordering of the variables.
  ordering = ordering_greedy(population);

  % Transform the population into Uniform(0,1) variables.
  uniform_pop = zeros(pop_size, num_vars);
  for k = 1:num_vars
    uniform_pop(:,k) = feval(params.learning_params.marginal_cdf, ...
                             population(:,ordering(k)), ...
                             population(:,ordering(k)));
  end

  % Calculate the values for the parameters of the copulas.
  [theta, h_functions, h_inverses] = starting_theta(params, uniform_pop);

  % Set the information of the model.
  model = struct();
  model.ordering = ordering;
  model.theta = theta;
  model.h_functions = h_functions;
  model.h_inverses = h_inverses;
  model.max_trees = params.learning_params.max_trees;
end

function [theta, h_functions, h_inverses] = starting_theta(params, uniform_pop)
  % Calculate starting parameters of the copulas in a canonical vine.

  max_trees = min(params.learning_params.max_trees, size(uniform_pop, 2) - 1);
  cor_test_level = params.learning_params.cor_test_level;

  n = size(uniform_pop, 2);

  theta = cell(n, n);
  h_functions = cell(n, n);
  h_inverses = cell(n, n);

  v = cell(n, n);

  for i = 1:n
    v{1,i} = uniform_pop(:,i);
  end

  for j = 1:max_trees
    for i = 1:n-j
      if kendall_corr_test(v{j,1}, v{j,i+1}, cor_test_level)
        theta{j,i} = sin(0.5 * M_PI * kendall_corr(v{j,1}, v{j,i+1}));
        h_functions{j,i} = str2func('h_gaussian');
        h_inverses{j,i} = str2func('hinv_gaussian');
      else
        theta{j,i} = [];
        h_functions{j,i} = str2func('h_indep');
        h_inverses{j,i} = str2func('hinv_indep');
      end
    end

    if j ~= max_trees
      % Compute observations for the next tree.
      for i = 1:n-j
        v{j+1,i} = feval(h_functions{j,i}, v{j,i+1}, v{j,1}, theta{j,i});
      end
    end
  end
end

function ordering = ordering_greedy(population)
  % Select an ordering of the variables using a greedy algorithm.

  n = size(population, 2);
  taus = abs(corr(population, 'type', 'Kendall'));
  taus = triu(taus) + diag(repmat(-Inf, 1, n)) + tril(taus);
  
  [tk, k] = max(taus(:));
  [i, j] = ind2sub(size(taus), k);
  taus(i,j) = -Inf; 
  taus(j,i) = -Inf;
  [tii, ii] = max(taus(:,i));
  [tjj, jj] = max(taus(:,j));
  all = 1:n;
  if tii >= tjj
    rest = all(all ~= i & all ~= ii & all ~= j);
    ordering = [i, ii, j, rest];
  else
    rest = all(all ~= j & all ~= jj & all ~= i);
    ordering = [j, jj, i, rest];
  end
end
