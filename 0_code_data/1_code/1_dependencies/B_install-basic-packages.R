
mirror_repo <- 'https://www.stats.bris.ac.uk/R/'

## OTHER UK MIRRORS
#  https://www.stats.bris.ac.uk/R/
#  http://www.stats.bris.ac.uk/R/
#  https://mirrors.ebi.ac.uk/CRAN/
#  http://mirrors.ebi.ac.uk/CRAN/
#  https://cran.ma.imperial.ac.uk/
#  http://cran.ma.imperial.ac.uk/
#  http://mirror.mdx.ac.uk/R/



### devtools
install.packages("devtools", repos=mirror_repo, dependencies = TRUE)

#### [data.table]([https://github.com/Rdatatable/data.table/wiki/Installation)
#[MORE](https://github.com/Rdatatable/data.table/wiki/Installation#why-we-recommend-installpackages-above-rather-than-devtoolsinstall_github)
library(devtools)
install_github("Rdatatable/data.table", build_vignettes=FALSE)


# for timeseries
#### Interpolation of Irregular and Regularly Spaced Data
install.packages("akima", repos=mirror_repo, dependencies = TRUE)

####  for savitzly-golay filter
install.packages("signal", repos=mirror_repo, dependencies = TRUE)

### ggplot2
install.packages("ggplot2", repos=mirror_repo, dependencies = TRUE)

### RColorBrewer) #for brewer.pal
install.packages("RColorBrewer", repos=mirror_repo, dependencies = TRUE)




##for rfunctions
### plot3D
.packages <- c('car', 'scatterplot3d', 'plot3D')
lapply(.packages, install.packages, dependencies = TRUE, repos=mirror_repo)


####  for deSolve
install.packages("deSolve", repos=mirror_repo, dependencies = TRUE)


### tseriesChaos
install.packages("tseriesChaos", repos=mirror_repo, dependencies = TRUE)



### pals for colors functions in scatter3D plots
install.packages("pals", repos=mirror_repo, dependencies = TRUE)


## Latex 
install.packages("latex2exp", repos=mirror_repo, dependencies = TRUE)



