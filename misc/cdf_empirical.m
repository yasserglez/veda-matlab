function [u] = cdf_empirical(sample, x)
  % Univariate empirical cumulative distribution function.
  %
  % Calculates the empirical CDF from the column vector SAMPLE and returns in
  % the output variable U its evaluation on each element of the column vector X.
  %
  % See the following for more information:
  %
  % R. de Matteis. Fitting copulas to data. Diploma Thesis, Institute of
  % Mathematics of the University of Zurich, 2001.
  
  % Created by Raúl José Arderí García (2007).
  % Modified by Yasser González Fernández (2010).
  
  sample = sort(sample);
  n = size(sample, 1);
  if abs(sample(n) - sample(1)) > 100
    epsilon = abs(sample(n) - sample(1));
  else
    epsilon = 100;
  end
  z = zeros(n + 1, 1);
  z(1) = sample(1) - epsilon;
  z(n + 1) = sample(n) + epsilon;

  for i = 1:n - 1
    z(i + 1) = (sample(i) + sample(i + 1)) / 2;
  end

  u = zeros(size(x, 1), 1);
  for i = 1:size(x, 1)
    k = 1;
    while (x(i) > z(k)) && (k < (n + 1))
      k = k + 1;
    end
    if k == 1
      u(i) = 0;
    elseif x(i) >= z(n + 1)
      u(i) = 1;
    else
      u(i) = ((k - 2) / n) + (x(i) - z(k - 1)) / (n * (z(k) - z(k - 1)));
    end
  end
end
