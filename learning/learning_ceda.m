function model = learning_ceda(params, population, fitness)
  % Learning function of the Copula EDA.
  
  % Created by Yasser González Fernández (2010).
  
  pop_size = size(population, 1);
  num_vars = size(population, 2);  
  
  % Transform the population into an Uniform(0,1) population applying the
  % univariate marginal CDFs to each observation of each variable in the
  % population.
  uniform_pop = zeros(pop_size, num_vars);
  for k = 1:num_vars
    uniform_pop(:,k) = feval(params.learning_params.marginal_cdf, ...
                             population(:,k), population(:,k));
  end
  
  % Fit the multivariate copula to the transformed population.
  sigma = copulafit(params.learning_params.copula_family, uniform_pop);
  
  model = struct();
  model.family = params.learning_params.copula_family;
  model.theta = sigma;

end

