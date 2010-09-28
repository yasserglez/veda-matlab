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
  
  n = size(population, 2);
  taus = abs(corr(population, 'type', 'Kendall'));
  taus = triu(taus) + diag(repmat(-Inf, 1, n)) + tril(taus);
  
  [tk, k] = max(taus(:));
  [i, j] = ind2sub(size(taus), k);
  all = 1:n;
  rest = all(all ~= i & all ~= j);
  ordering = [i, j, rest];
end

function ordering = ordering_greedy(vine_type, population)
  % Select an ordering using a greedy algorithm that builds the vine adding the
  % bivariate relationships with the greater absolute value of Kendall's tau.
  
  n = size(population, 2);
  taus = abs(corr(population, 'type', 'Kendall'));
  taus = triu(taus) + diag(repmat(-Inf, 1, n)) + tril(taus);
  
  [tk, k] = max(taus(:));
  [i, j] = ind2sub(size(taus), k);
  taus(i,j) = -Inf; 
  taus(j,i) = -Inf;
  
  if strcmpi(vine_type, 'cvine');
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
  
  if strcmpi(vine_type, 'dvine')
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
end
