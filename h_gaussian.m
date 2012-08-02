function results = h_gaussian(u1, u2, rho)
  % h-function of the Gaussian or normal copula.

  u1(u1 <= 0) = eps;
  u1(u1 >= 1) = 1 - eps;
  u2(u2 <= 0) = eps;
  u2(u2 >= 1) = 1 - eps;
  rho(rho == -1) = -1 + eps;
  rho(rho == 1) = 1 - eps;

  x1 = norminv(u1, 0, 1);
  x2 = norminv(u2, 0, 1);
  results = normcdf((x1 - (rho .* x2)) ./ sqrt(1 - (rho .^ 2)), 0, 1);
end
