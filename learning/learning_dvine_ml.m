function model = learning_dvine_ml(params, population, fitness)
  % Learn a D-vine from a population using maximum likelihood.
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
  %
  % References:
  %
  % K. Aas, C. Czado, A. Frigessi, and H. Bakken. Pair-copula constructions of
  % multiple dependence. Note SAMBA/24/06, Norwegian Computing Center, NR, 2006.
  
  % Created by Yasser González Fernández (2010).  
  
  pop_size = size(population, 1);
  num_vars = size(population, 2);
  if ~isfield(params.learning_params, 'max_trees')
    params.learning_params.max_trees = num_vars - 1;
  end  
  
  % Select an ordering of the variables.
  ordering = feval(params.learning_params.ordering, population);
  
  % Transform the population into an Uniform(0,1) population applying the
  % univariate marginal CDFs to each observation of each variable in the
  % population.
  uniform_pop = zeros(pop_size, num_vars);
  for k = 1:num_vars
    uniform_pop(:,k) = feval(params.learning_params.marginal_cdf, ...
                             population(:,ordering(k)), ...
                             population(:,ordering(k)));
  end
  
  % Calculate the starting values for the parameters of the copulas needed
  % for the numerical maximization of the log-likelihood function.
  [theta, h_functions, h_inverses] = starting_theta(params, uniform_pop);
  
  % Run a local optimization method for the log-likehood.
  
  % Set the information of the model.
  model = struct();
  model.ordering = ordering;
  model.theta = theta;
  model.h_functions = h_functions;
  model.h_inverses = h_inverses;
  model.max_trees = params.learning_params.max_trees;  
end

function [theta, h_functions, h_inverses] = starting_theta(params, uniform_pop)
  % Calculate starting parameters of the copulas in a D-vine.
  
  % WARNING: The way the first dimension of v is indexed here differs from the
  % Algorithm 4 in SAMBA/24/06 because of MATLAB 1-based indexing.
  
  gof_cops = params.learning_params.gof_copulas;
  h_funcs = params.learning_params.h_functions;
  h_invs = params.learning_params.h_inverses;
  max_trees = min(params.learning_params.max_trees, size(uniform_pop, 2) - 1);
  indep_test = params.learning_params.indep_test;
  
  n = size(uniform_pop, 2);

  theta = cell(n, n);
  h_functions = cell(n, n);
  h_inverses = cell(n, n);
  
  v = cell(n, n);

  for i = 1:n
    v{1,i} = uniform_pop(:,i);
  end
  
  for i = 1:n-1
    if indep_test && kendall_corr_test(v{1,i}, v{1,i+1}, 0.05)
      statistic = Inf;
      for c = 1:size(gof_cops, 2)
        result = feval(gof_cops{c}, v{1,i}, v{1,i+1});
        if result.statistic < statistic
          theta{1,i} = result.parameters;
          h_functions{1,i} = str2func(h_funcs{c});
          h_inverses{1,i} = str2func(h_invs{c});
          statistic = result.statistic;
        end
      end
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
                           
  for j = 2:max_trees
    for i = 1:n-j
      if indep_test && kendall_corr_test(v{j,2*i-1}, v{j,2*i}, 0.05)
        statistic = Inf;
        for c = 1:size(gof_cops, 2)
          result = feval(gof_cops{c}, v{j,2*i-1}, v{j,2*i});
          if result.statistic < statistic
            theta{j,i} = result.parameters;
            h_functions{j,i} = str2func(h_funcs{c});
            h_inverses{j,i} = str2func(h_invs{c});
            statistic = result.statistic;
          end
        end
      else
        theta{j,i} = [];
        h_functions{j,i} = str2func('h_indep');
        h_inverses{j,i} = str2func('hinv_indep');
      end
    end
    
    % Compute observations for the next tree.
    if j ~= max_trees
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

function ordering = ordering_default(population)
  % Default ordering of the variables of a C-vine.

  ordering = 1:size(population, 2);
end

function ordering = ordering_stronger(population)
  % An ordering that includes the pair with the stronger dependence.
  
  nk = nchoosek(size(population,2),2);
  is = zeros(1,nk);
  js = zeros(1,nk);
  taus = zeros(1,nk);
  
  % Calculate the absolute value of the correlations between all variables.
  k = 0;
  for j = 1:size(population,2)
    for i = 1:j-1
      k = k + 1;
      is(k) = i;
      js(k) = j;
      taus(k) = abs(corr(population(:,i), population(:,j), 'type', 'Kendall'));
    end
  end
  [ignore, taus_ordering] = sort(taus, 'descend');  
  
  % Build the ordering vector.
  ordering = zeros(1,size(population,2));
  ordering(1) = is(taus_ordering(1));
  ordering(2) = js(taus_ordering(1));
  k = 2;
  for i = 1:size(population,2)
    if i ~= ordering(1) && i ~= ordering(2)
      k = k + 1;
      ordering(k) = i;
    end
  end
end
