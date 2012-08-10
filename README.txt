Basic MATLAB/Octave implementation of CVEDA and DVEDA
-----------------------------------------------------

CVEDA (C-Vine EDA) and DVEDA (D-Vine EDA) are two EDAs that belong to the class of
VEDAs (Vine EDAs). This class, introduced in (Soto and González-Fernández 2010;
González-Fernández 2011), contains EDAs that model the search distributions using
vines (Joe 1996; Bedford and Cooke 2001; Aas et al. 2009).

Vines are graphical models that represent high-dimensional distributions by
decomposing the multivariate density into bivariate copulas and one-dimensional
densities. These models can represent a rich variety of dependences, since all
bivariate copulas in a vine do not have to belong to the same family. C-vines and
D-vines are two types of vines, each of which determine a specific decomposition
of the multivariate density. CVEDA and DVEDA are based on C-vines and D-vines,
respectively.

At each generation of CVEDA and DVEDA, the selection of the structure of the vine
involves selecting the bivariate dependences that will be explicitly modeled in
the first tree. In this implementation this is accomplished by using greedy
heuristics based on the empirical Kendall’s tau between each pair of variables in
the selected population assigned to the edges of the tree. The selection of each
bivariate copula in both CVEDA and DVEDA starts with an independence test based on
Kendall's tau. The product copula is selected if there is not enough evidence
against the null hypothesis at a given significance level. In the other case, a
normal copula is used to model the dependence between the pair of variables.
The cost of the construction of C-vines and D-vines increases with the number of
variables. To simplify the construction, it is possible to apply a truncation
strategy. If a vine is truncated at a given tree, all the copulas in the rest of
the trees are assumed to be product copulas.

Consider using the copulaedas R package (González-Fernández and Soto 2012) which
provides a more flexible and up-to-date implementation of these algorithms.

References:

1. Aas K, Czado C, Frigessi A, Bakken H (2009). "Pair-Copula Constructions of
   Multiple Dependence." Insurance: Mathematics and Economics, 44(2), 182--198.
2. Bedford T, Cooke RM (2001). "Probability Density Decomposition for
   Conditionally Dependent Random Variables Modeled by Vines." Annals of
   Mathematics and Artificial Intelligence, 32(1), 245--268.
3. González-Fernández Y (2011). Algoritmos con estimación de distribuciones 
   basados en cópulas y vines. Bachelor thesis, University of Havana, Cuba.
4. González-Fernández Y, Soto M (2012). copulaedas: Estimation of Distribution
   Algorithms Based on Copulas. R package version 1.1.0,
   URL http://CRAN.R-project.org/package=copulaedas.
5. Joe H (1996). "Families of m-variate Distributions with Given Margins and
   m(m-1)/2 Bivariate Dependence Parameters." In L Rüschendorf, B Schweizer,
   MD Taylor (eds.), Distributions with fixed marginals and related topics,
   pp. 120--141.
6. Soto M, González-Fernández Y (2010). "Vine Estimation of Distribution
   Algorithms." Technical Report ICIMAF 2010-561, Institute of Cybernetics,
   Mathematics and Physics, Cuba. ISSN 0138-8916.

