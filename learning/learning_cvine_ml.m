function model = learning_cvine_ml(params, population, fitness)
  % Learn a canonical vine from a population using maximum likelihood.
  %
  % PARAMS is a struct with the parameters of the EDA. PUPULATION is the
  % population from where the probabilistic model should be learned and
  % FITNESS is the fitness of the individuals of this popualtion.
  %
  % A canonical vine is defined by an ordering of the variables and the
  % parameters of each copula density in the factorization. The output variable
  % MODEL will be an struct with the following fields: 
  %
  %   * order: vector with the ordering of the variables,
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
  
  % Select an ordering of the variables.
  if params.learning_params.random_ordering
    order = randperm(num_vars);
  else
    order = 1:num_vars;
  end
  
  % Transform the population into an Uniform(0,1) population applying the
  % univariate marginal CDFs to each observation of each variable in the
  % population.
  uniform_pop = zeros(pop_size, num_vars);
  for k = 1:num_vars
    uniform_pop(:,k) = feval(params.learning_params.marginal_cdf, ...
                             population(:,order(k)), population(:,order(k)));
  end
  
  % Calculate the starting values for the parameters of the copulas needed
  % for the numerical maximization of the log-likelihood function.
  [theta, h_functions, h_inverses] = starting_theta(params, uniform_pop);
  
  % Run a local optimization method for the log-likehood.
  
  % Set the information of the model.
  model = struct();
  model.order = order;
  model.theta = theta;
  model.h_functions = h_functions;
  model.h_inverses = h_inverses;
end

function [theta, h_functions, h_inverses] = starting_theta(params, uniform_pop)
  % Calculate starting parameters of the copulas in a canonical vine.
  
  % WARNING: The way the first dimension of v is indexed here differs from the
  % Algorithm 3 in SAMBA/24/06 because of MATLAB 1-based indexing.
  
  copulafit = params.learning_params.copulafit;  
  h_function = params.learning_params.h_function;
  h_inverse = params.learning_params.h_inverse;
  if isfield(params.learning_params, 'max_trees')
    max_trees = params.learning_params.max_trees;
  else
    max_trees = NaN;
  end
  
  n = size(uniform_pop, 2);

  theta = cell(n, n);
  h_functions = cell(n, n);
  h_inverses = cell(n, n);
  
  v = cell(n, n);

  for i = 1:n
    v{1,i} = uniform_pop(:,i);
  end

  for j = 1:n-1
    for i = 1:n-j
      if isnan(max_trees) || j <= max_trees
        theta{j,i} = feval(copulafit, v{j,1}, v{j,i+1});
        h_functions{j,i} = str2func(h_function);
        h_inverses{j,i} = str2func(h_inverse);
      else
        theta{j,i} = [];
        h_functions{j,i} = str2func('h_product');
        h_inverses{j,i} = str2func('hinv_product');
      end
    end

    if j ~= n-1
      % Compute observations for the next tree.
      for i = 1:n-j
        v{j+1,i} = feval(h_functions{j,i}, v{j,i+1}, v{j,1}, theta{j,i});
      end
    end
  end
end
