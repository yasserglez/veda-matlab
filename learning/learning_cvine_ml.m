function model = learning_cvine_ml(params, population, fitness)
  % Learn a canonical vine from a population using maximum likelihood.
  %
  % PARAMS is a struct with the parameters of the EDA. PUPULATION is the
  % population from where the probabilistic model should be learned and
  % FITNESS is the fitness of the individuals of this popualtion.
  %
  % A canonical vine is defined by an ordering of the variables and the
  % parameters of each copula density in the factorization. The output variable
  % MODEL will be an struct with two fields: ordering, a vector for the order
  % of the variables and parameters, a cell array with the parameters of each
  % copula.
  %
  % References:
  %
  % K. Aas, C. Czado, A. Frigessi, and H. Bakken. Pair-copula constructions of
  % multiple dependence. Note SAMBA/24/06, Norwegian Computing Center, NR, 2006.
  
  % Created by Yasser González Fernández (2010).  
  
  num_individuals = size(population, 1);
  num_vars = size(population, 2);
  
  % Select an ordering of the variables.
  if params.learning_params.random_ordering
    ordering = randperm(num_vars);
  else
    ordering = 1:num_vars;
  end
  
  % Transform the population into an Uniform(0,1) population applying the
  % univariate marginal CDFs to each observation of each variable in the
  % population.
  uniform_pop = zeros(num_individuals, num_vars);
  marginal_cdf = params.learning_params.marginal_cdf;
  for k = 1:num_vars
    uniform_pop(:,k) = feval(marginal_cdf, ...
                             population(:,ordering(k)), ...
                             population(:,ordering(k)));
  end
  
  % Calculate the starting values for the parameters of the copulas needed for
  % the numerical maximization of the log-likelihood function.
  copula_fit = params.learning_params.copula_fit;
  h_function = params.learning_params.h_function;
  parameters = starting_parameters(uniform_pop, copula_fit, h_function);
  
  % Run a local optimization method for the log-likehood.
  
  % Set the information of the model.
  model = struct();
  model.ordering = ordering;
  model.parameters = parameters;
end

function parameters = starting_parameters(uniform_pop, copula_fit, h_function)
  % Calculate starting parameters of the copulas in a canonical vine.
  
  % WARNING: The way the first dimension of v is indexed here differs from the
  % Algorithm 3 in SAMBA/24/06 because of MATLAB 1-based indexing.
  
  n = size(uniform_pop, 2);
  v = cell(n, n);
  parameters = cell(n, n);

  for i = 1:n
    v{1,i} = uniform_pop(:,i);
  end

  for j = 1:n-1
    for i = 1:n-j
      parameters{j,i} = feval(copula_fit, v{j,1}, v{j,i+1});
    end
    
    if j ~= n-1
      % Compute observations for the next tree.
      for i = 1:n-j
        v{j+1,i} = feval(h_function, v{j,i+1}, v{j,1}, parameters{j,i});
      end
    end
  end
end
