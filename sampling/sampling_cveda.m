function population = ...
    sampling_cveda(params, model, selected_population, selected_fitness)
  % Sampling function of the C-Vine EDA.
  %
  % PARAMS is a struct with the parameters of the EDA. MODEL is a struct
  % representing the canonical vine, see the documentation of the
  % learning_cveda_ml function for information about the fields.
  % SELECTED_POPULATION is the population from where the canonical vine was
  % learned and SELECTED_FITNESS its evaluation.
  %
  % The output variable POPULATION is the random population sampled from the
  % canonical vine. The population is returned as a matrix with columns for
  % variables and rows for indiviluals. The number of individuals in the
  % population is given by PARAMS.seeding_params.population_size.
  %
  % References:
  %
  % K. Aas, C. Czado, A. Frigessi, and H. Bakken. Pair-copula constructions of
  % multiple dependence. Note SAMBA/24/06, Norwegian Computing Center, NR, 2006.  
  
  % Created by Raúl José Arderí García (2007).
  % Modified by Yasser González Fernández (2010).
  
  % Simulate a population of dependent Uniform(0,1) variables variables) from
  % the given canonical vine.

  pop_size = params.seeding_params.population_size;
  n = params.objective_params.number_variables;
  cdf_inverse = params.sampling_params.marginal_cdf_inverse;
  
  ordering = model.ordering;
  theta = model.theta;
  h_functions = model.h_functions;
  h_inverses = model.h_inverses;
  max_trees = model.max_trees;

  uniform_pop = zeros(pop_size, n);
  W = unifrnd(0, 1, pop_size, n);
  v = sparse(n, n);

  for individual = 1:pop_size
    w = W(individual,:);
    v(1,1) = w(1);
    uniform_pop(individual,1) = v(1,1);
    
    for i = 2:n
      % Sampling the ith variable.
      v(i,1) = w(i);
      for k = min(max_trees, i-1):-1:1
        v(i,1) = feval(h_inverses{k,i-k}, v(i,1), v(k,k), theta{k,i-k});
      end
      uniform_pop(individual,i) = v(i,1);
      
      % Compute the h-inverse values needed for sampling the (i+1)th variable.
      if i ~= n
        for j = 1:min(max_trees, i-1)
          v(i,j+1) = feval(h_functions{j,i-j}, v(i,j), v(j,j), theta{j,i-j});
        end
      end
    end
  end
 
  % Transform the simulated Uniform(0,1) population into a population of the
  % variables of the objective function applying the inverse of the univariate
  % marginal CDFs to each observation of each variable in the population.
  
  population = zeros(pop_size, n);
  for k = 1:n
    population(:,ordering(k)) = ...
      feval(cdf_inverse, selected_population(:,ordering(k)), uniform_pop(:,k));
  end
end
