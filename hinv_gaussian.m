function results = hinv_gaussian(u1, u2, rho)
  % Inverse of the h-function of the Gaussian or normal copula.

  u1(u1 <= 0) = 0 + eps;
  u1(u1 >= 1) = 1 - eps;
  u2(u2 <= 0) = 0 + eps;
  u2(u2 >= 1) = 1 - eps; 

  x1 = norminv(u1, 0, 1);
  x2 = norminv(u2, 0, 1);
  results = normcdf((x1 .* sqrt(1 - (rho .^ 2))) + (rho .* x2), 0, 1);
end
