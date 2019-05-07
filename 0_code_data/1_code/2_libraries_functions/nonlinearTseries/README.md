## What is `nonlinearTseries`

[`nonlinearTseries`](https://github.com/constantino-garcia/nonlinearTseries)
provides functions for nonlinear time series analysis. This package permits the
computation of the most-used nonlinear statistics/algorithms including
generalized correlation dimension, information dimension, largest Lyapunov
exponent, sample entropy and Recurrence Quantification Analysis (RQA),
among others. Basic routines for surrogate data testing are also included.
The package is largely inspired by the book [Nonlinear time series analysis](https://www.amazon.com/Nonlinear-Time-Analysis-Holger-Kantz/dp/0521529026)
by Holger Kantz and Thomas Schreiber.

## Getting started
For a quick introduction to `nonlinearTseries`, see its
[vignette](https://cran.r-project.org/web/packages/nonlinearTseries/vignettes/nonlinearTseries_quickstart.html) 
or the [package documentation](https://cran.r-project.org/web/packages/nonlinearTseries/nonlinearTseries.pdf).

# Installation
You can install the he latest released version from 
[CRAN](https://cran.r-project.org/web/packages/nonlinearTseries/index.html) with:
```
install.packages("nonlinearTseries")
```

## Dependencies

You might also require to install the following dependencies
```
R
mirror_repo <- 'https://www.stats.bris.ac.uk/R/'
install.packages("tseries", repos=mirror_repo, dependencies = TRUE)
install.packages("TSA", repos=mirror_repo, dependencies = TRUE)
install.packages("RcppArmadillo", repos=mirror_repo, dependencies = TRUE)
```

## Citation
You can get information about citing `nonlinearTseries` using `citation('nonlinearTseries')` in an `R` session.

 
