mirror_repo <- 'https://www.stats.bris.ac.uk/R/'

## OTHER UK MIRRORS
#  https://www.stats.bris.ac.uk/R/
#  http://www.stats.bris.ac.uk/R/
#  https://mirrors.ebi.ac.uk/CRAN/
#  http://mirrors.ebi.ac.uk/CRAN/
#  https://cran.ma.imperial.ac.uk/
#  http://cran.ma.imperial.ac.uk/
#  http://mirror.mdx.ac.uk/R/

#xml2 for roxygen2
install.packages("xml2", repos=mirror_repo, dependencies = TRUE)

#### roxygen2 for load_all()
install.packages("roxygen2", repos=mirror_repo, dependencies = TRUE)

# dependencies for nonlinearTseries

install.packages("tseries", repos=mirror_repo, dependencies = TRUE)
install.packages("TSA", repos=mirror_repo, dependencies = TRUE)
install.packages("RcppArmadillo", repos=mirror_repo, dependencies = TRUE)

install.packages("nonlinearTseries", repos=mirror_repo, dependencies = TRUE)

