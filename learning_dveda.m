function model = learning_dveda(params, population, fitness)
  % Learning function of the D-Vine EDA.
  %
  % PARAMS is a struct with the parameters of the EDA. PUPULATION is the
  % population from where the probabilistic model should be learned and
  % FITNESS is the fitness of the individuals of this popualtion.
  %
  % A D-vine is defined by an ordering of the variables and the parameters of
  % each copula density in the factorization. The output variable MODEL will be
  % an struct with the following fields:
  %
  %   * ordering: vector with the order of the variables,
  %   * theta: cell array with the parameters of each bivariate copula in the
  %     pair-copula decomposition,
  %   * h_functions: cell array with the h-functions corresponding to each
  %     bivariate copula in the pair-copula decomposition,
  %   * h_inverses: cell array with the inverse of the h-functions corresponding
  %     to each bivariate copula in the pair-copula decomposition.
  %   * vine_trees: number of trees of the D-vine (for the rest
  %     of the trees, conditional independence is assumed).

  pop_size = size(population, 1);
  num_vars = size(population, 2);
  if ~isfield(params.learning_params, 'vine_trees')
    params.learning_params.vine_trees = num_vars - 1;
  end
  
  % Select an ordering of the variables.
  ordering = ordering_greedy(population);

  % Transform the population into Uniform(0,1) variables.
  uniform_pop = zeros(pop_size, num_vars);
  for k = 1:num_vars
    uniform_pop(:,k) = feval(params.learning_params.p_margin, ...
                             population(:,ordering(k)), ...
                             population(:,ordering(k)));
  end
  
  % Calculate the values for the parameters of the copulas.
  [theta, h_functions, h_inverses] = estimate_parameters(params, uniform_pop);
  
  % Set the information of the model.
  model = struct();
  model.ordering = ordering;
  model.theta = theta;
  model.h_functions = h_functions;
  model.h_inverses = h_inverses;
  model.vine_trees = params.learning_params.vine_trees;
end

function [theta, h_functions, h_inverses] = estimate_parameters(params, uniform_pop)
  % Estimate the parameters of the copulas in a D-vine.

  vine_trees = min(params.learning_params.vine_trees, size(uniform_pop, 2) - 1);
  cor_test_level = params.learning_params.cor_test_level;
  
  n = size(uniform_pop, 2);
  theta = cell(n, n);
  h_functions = cell(n, n);
  h_inverses = cell(n, n);
  v = cell(n, n);

  for i = 1:n
    v{1,i} = uniform_pop(:,i);
  end
  
  for i = 1:n-1
    if kendall_corr_test(v{1,i}, v{1,i+1}, cor_test_level)
      theta{1,i} = sin(0.5 * M_PI * kendall_corr(v{1,i}, v{1,i+1}));
      h_functions{1,i} = str2func('h_gaussian');
      h_inverses{1,i} = str2func('hinv_gaussian');
    else
      theta{1,i} = [];
      h_functions{1,i} = str2func('h_indep');
      h_inverses{1,i} = str2func('hinv_indep');
    end
  end
  v{2,1} = feval(h_functions{1,1}, v{1,1}, v{1,2}, theta{1,1});
  
  for k = 1:n-3
    v{2,2*k} = feval(h_functions{1,k+1}, v{1,k+2}, v{1,k+1}, theta{1,k+1});
    v{2,2*k+1} = feval(h_functions{1,k+1}, v{1,k+1}, v{1,k+2}, theta{1,k+1});
  end
  v{2,2*n-4} = feval(h_functions{1,n-1}, v{1,n}, v{1,n-1}, theta{1,n-1});
                           
  for j = 2:vine_trees
    for i = 1:n-j
      if kendall_corr_test(v{j,2*i-1}, v{j,2*i}, cor_test_level)
        theta{j,i} = sin(0.5 * M_PI * kendall_corr(v{j,2*i-1}, v{j,2*i}));
        h_functions{j,i} = str2func('h_gaussian');
        h_inverses{j,i} = str2func('hinv_gaussian');
      else
        theta{j,i} = [];
        h_functions{j,i} = str2func('h_indep');
        h_inverses{j,i} = str2func('hinv_indep');
      end
    end

    % Compute observations for the next tree.
    if j ~= vine_trees
      v{j+1,1} = feval(h_functions{j,1}, v{j,1}, v{j,2}, theta{j,1});
      if n > 4
        for i = 1:n-j-2
          v{j+1,2*i} = feval(h_functions{j,i+1}, v{j,2*i+2}, ...
                             v{j,2*i+1}, theta{j,i+1});
          v{j+1,2*i+1} = feval(h_functions{j,i+1}, v{j,2*i+1}, ...
                               v{j,2*i+2}, theta{j,i+1});
        end
      end
      v{j+1,2*n-2*j-2} = feval(h_functions{j,n-j}, v{j,2*n-2*j}, ...
                               v{j,2*n-2*j-1}, theta{j,n-j});
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
  ordering = [i, j];
  while length(ordering) < n
    i = ordering(1);
    j = ordering(end);
    [tii, ii] = max(taus(:,i));
    [tjj, jj] = max(taus(:,j));
    if tii >= tjj
      for k = ordering
        taus(k,ii) = -Inf;
        taus(ii,k) = -Inf;
      end
      ordering = [ii, ordering];
    else
      for k = ordering
        taus(k,jj) = -Inf;
        taus(jj,k) = -Inf;
      end
      ordering = [ordering, jj];
    end
  end
end
