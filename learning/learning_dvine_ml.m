function model = learning_dvine_ml(params, population, fitness)
  % Learn a D-vine from a population using maximum likelihood.
  %
  % PARAMS is a struct with the parameters of the EDA. PUPULATION is the
  % population from where the probabilistic model should be learned and
  % FITNESS is the fitness of the individuals of this popualtion.
  %
  % A D-vine is defined by an order of the variables and the parameters of
  % each copula density in the factorization. The output variable MODEL will be
  % an struct with the following fields:
  %
  %   * order: vector with the order of the variables,
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
  model.max_trees = params.learning_params.max_trees;  
end

function [theta, h_functions, h_inverses] = starting_theta(params, uniform_pop)
  % Calculate starting parameters of the copulas in a D-vine.
  
  % WARNING: The way the first dimension of v is indexed here differs from the
  % Algorithm 4 in SAMBA/24/06 because of MATLAB 1-based indexing.
  
  fitcopula = params.learning_params.fitcopula;  
  h_function = params.learning_params.h_function;
  h_inverse = params.learning_params.h_inverse;
  max_trees = params.learning_params.max_trees;
  
  n = size(uniform_pop, 2);

  theta = cell(n, n);
  h_functions = cell(n, n);
  h_inverses = cell(n, n);
  
  v = cell(n, n);

  for i = 1:n
    v{1,i} = uniform_pop(:,i);
  end
  
  for i = 1:n-1
    if kendall_corr_test(v{1,i}, v{1,i+1})
      theta{1,i} = feval(fitcopula, v{1,i}, v{1,i+1});
      h_functions{1,i} = str2func(h_function);
      h_inverses{1,i} = str2func(h_inverse);
    else
      theta{1,i} = [];
      h_functions{1,i} = str2func('h_product');
      h_inverses{1,i} = str2func('hinv_product');
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
      if kendall_corr_test(v{j,2*i-1}, v{j,2*i})
        theta{j,i} = feval(fitcopula, v{j,2*i-1}, v{j,2*i});
        h_functions{j,i} = str2func(h_function);
        h_inverses{j,i} = str2func(h_inverse);
      else
        theta{j,i} = [];
        h_functions{j,i} = str2func('h_product');
        h_inverses{j,i} = str2func('hinv_product');
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
