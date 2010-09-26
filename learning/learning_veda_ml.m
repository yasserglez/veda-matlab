function model = learning_veda_ml(params, population, fitness)
  % Learn function of the Vine EDA (Maximum Likelihood).
  %
  % References:
  %
  % K. Aas, C. Czado, A. Frigessi, and H. Bakken. Pair-copula constructions of
  % multiple dependence. Note SAMBA/24/06, Norwegian Computing Center, NR, 2006.

  % Created by Yasser González Fernández (2010).

  pop_size = size(population, 1);
  num_vars = size(population, 2);
  max_trees = params.learning_params.max_trees;
  vine_type = params.learning_params.vine_type;
  cor_test_level = params.learning_params.cor_test_level;
  copulas = params.learning_params.copulas;
  
  % Select an ordering of the variables.
  ordering = feval(params.learning_params.ordering, vine_type, population);

  % Transform the population into an Uniform(0,1) population applying the
  % univariate marginal CDFs to each observation.
  uniform_pop = zeros(pop_size, num_vars);
  for k = 1:num_vars
    uniform_pop(:,k) = feval(params.learning_params.marginal_cdf, ...
                             population(:,ordering(k)), ...
                             population(:,ordering(k)));
  end
  
  % Learn the vine using the implementation of the vines R-package.
  callR('learnVine', vine_type, uniform_pop, max_trees, cor_test_level, copulas)

  % Only the ordering of the variables, everything else is done in R.
  model = struct();
  model.ordering = ordering;
end

function ordering = ordering_default(vine_type, population)
  % Default ordering of the variables of a C-vine.

  ordering = 1:size(population, 2);
end

function ordering = ordering_stronger(vine_type, population)
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
      taus(k) = abs(kendall_corr(population(:,i), population(:,j)));
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
