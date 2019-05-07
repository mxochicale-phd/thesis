# Getting started
For a quick introduction to `nonlinearTseries`, see its
[vignette](https://cran.r-project.org/web/packages/nonlinearTseries/vignettes/nonlinearTseries_quickstart.html) 
or the [package documentation](https://cran.r-project.org/web/packages/nonlinearTseries/nonlinearTseries.pdf).

## Dependencies

Install the following dependencies

```
R
mirror_repo <- 'https://www.stats.bris.ac.uk/R/'
install.packages("tseries", repos=mirror_repo, dependencies = TRUE)
install.packages("TSA", repos=mirror_repo, dependencies = TRUE)
install.packages("RcppArmadillo", repos=mirror_repo, dependencies = TRUE)

```


## Developing Debugging and Testing with nonlinearTseries

```
cd ~/mxochicale/github/nonlinearTseries
R
library(roxygen2); library("devtools")
install('nonlinearTseries')
library('nonlinearTseries')
buildTakens(1:20,embedding.dim=5,time.lag=3)
```


## Loading nonlinearTseries from a given path

```
library(devtools)
load_all('~/mxochicale/github/nonlinearTseries')
buildTakens(1:20,embedding.dim=5,time.lag=3)
```

## You can also install the library from a given path as follows
```
library(devtools)
install('~/mxochicale/github/nonlinearTseries')
library('nonlinearTseries')
buildTakens(1:20,embedding.dim=5,time.lag=3)
```


