function verbose_populations(params, generation, population, fitness, ...
                             selected_population, selected_fitness, ...
                             sampled_population, sampled_fitness)
  % Creates files with the populations of each generation. 
  %
  % For each generation, this will create six files: the population and its
  % evaluation, the selected population and its evaluation and the sampled
  % population and its evaluation.
  
  % Created by Yasser González Fernández (2010).
  variables = {'population', 'fitness', ...
               'selected_population', 'selected_fitness', ...
               'sampled_population', 'sampled_fitness'};
  for i = 1:numel(variables)
    save(sprintf('%s_%d.dat', variables{i}, generation), variables{i}, '-ascii');
  end
end
