function [population] = sampling_dvine(params, model, selected_population, ...
                                       selected_fitness)
  % Sample a D-vine learned from a population.
  %
  % PARAMS is a struct with the parameters of the EDA. MODEL is a struct
  % representing the D-vine, it should have two fields: "ordering", a vector for
  % the order of the variables and "parameters", a matrix with  the parameters
  % of each copula in the pair-copula decomposition. SELECTED_POPULATION is the
  % population from where the canonical vine was learned and SELECTED_FITNESS
  % its evaluation.
  %
  % The output variable POPULATION is the random population sampled from the
  % D-vine. The population is returned as a matrix with columns for variables
  % and rows for indiviluals. The number of individuals in the population is
  % given by PARAMS.seeding_params.population_size.
  %
  % See the following for more information:
  %
  % K. Aas, C. Czado, A. Frigessi, and H. Bakken. Pair-copula constructions of
  % multiple dependence. Note SAMBA/24/06, Norwegian Computing Center, NR, 2006.  
  
  % Created by Raúl José Arderí García (2007).
  % Modified by Yasser González Fernández (2010).
  
  % Simulate a population of dependent Uniform(0,1) variables variables) from
  % the given canonical vine.
    
  pop_size = params.seeding_params.population_size;
  n = params.objective_params.number_variables;
  h_inverse = params.sampling_params.h_inverse;
  h_function = params.sampling_params.h_function;
  parameters = model.parameters;

  uniform_pop = zeros(pop_size, n);
  W = unifrnd(0, 1, pop_size, n);
  v = sparse(n, n);

  for individual = 1:pop_size
    w = W(individual,:);
    v(1,1) = w(1);
    uniform_pop(individual,1) = v(1,1);   
    v(2,1) = feval(h_inverse, w(2), v(1,1), parameters{1,1});
    uniform_pop(individual,2) = v(2,1);
    v(2,2) = feval(h_function, v(1,1), v(2,1), parameters{1,1});
    
    for i = 3:n
      % Sampling the ith variable.
      v(i,1) = w(i);
      for k = i-1:-1:2
        v(i,1) = feval(h_inverse, v(i,1), v(i-1,2*k-2), parameters{k,i-k});
      end
      v(i,1) = feval(h_inverse, v(i,1), v(i-1,1), parameters{1,i-1});
      uniform_pop(individual,i) = v(i,1);
      
      % Compute the h-inverse values needed for sampling the (i+1)th variable.
      if i ~= n
        v(i,2) = feval(h_function, v(i-1,1), v(i,1), parameters{1,i-1});
        v(i,3) = feval(h_function, v(i,1), v(i-1,1), parameters{1,i-1});
        if i > 3
          for j = 2:i-2
            v(i,2*j) = feval(h_function, v(i-1,2*j-2), v(i,2*j-1), ...
                             parameters{j,i-j});
            v(i,2*j+1) = feval(h_function, v(i,2*j-1), v(i-1,2*j-2), ...
                               parameters{j,i-j});
          end
        end
        v(i,2*i-2) = feval(h_function, v(i-1,2*i-4), v(i,2*i-3), ...
                           parameters{i-1,1});
      end
    end
  end
 
  % Transform the simulated Uniform(0,1) population into a population of the
  % variables of the objective function applying the inverse of the univariate
  % marginal CDFs to each observation of each variable in the population.
  
  cdf_inverse = params.sampling_params.marginal_cdf_inverse;
  ordering = model.ordering;
  
  population = zeros(pop_size, n);
  for k = 1:n
    population(:,ordering(k)) = feval(cdf_inverse, ...
                                      selected_population(:,ordering(k)), ...
                                      uniform_pop(:,k));
  end
end
