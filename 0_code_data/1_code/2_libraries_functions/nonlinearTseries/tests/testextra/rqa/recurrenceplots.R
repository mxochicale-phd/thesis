#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:
# source(paste(getwd(),"/recurrenceplots.R", sep=""), echo=TRUE)
#
# DESCRIPTION:



#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#################
# Start the clock!
start.time <- Sys.time()


################################################################################
# Loading Functions and Libraries and Setting up digits
library(devtools)
load_all('~/mxochicale/github/nonlinearTseries')


# library(data.table) # for manipulating data
# # source('~/mxochicale/github/r-code_repository/functions/ollin_cencah.R')

# require(ggplot2)
# require(scales)#for muted function
# library(latex2exp)


################################################################################
# (1) Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()


rossler.ts =  rossler(time=seq(0, 10, by = 0.01),do.plot=FALSE)$x
p1 <- recurrencePlot(takens = NULL, time.series = rossler.ts, embedding.dim=3, time.lag=1,radius=1.01)

lorenz.ts = lorenz(time=seq(0,10,by=0.01), do.plot=FALSE)$x
p2 <- recurrencePlot(takens = NULL, time.series = lorenz.ts, embedding.dim=2, time.lag=1,radius=2)






#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time


################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
