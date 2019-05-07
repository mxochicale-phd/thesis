#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:
# FileDescription:
# The following times series are generated using /timeseries/periodicTimeSeries/periodic03.R
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
#
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



#################
# Start the clock!
start.time <- Sys.time()


#################
### Load libraries
require(tseriesChaos)
library(deSolve)
library(devtools)
load_all('~/mxochicale/github/nonlinearTseries')

library(data.table)
library(ggplot2)




################################################################################
# (1) Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()
plots_path <- paste(r_scripts_path,"/plots_path",sep="")


###################
## Main R Script




######################
### Lorenz Function
###
Lorenz <- function(t, state, parameters){
          with(as.list( c(state,parameters)),
              {
              #rate of change
              dX <- sigma*(Y-X)
              dY <- rho*X - X*Z - Y
              dZ <- X*Y - beta*Z

              # return the rate of change
              list( c(dX, dY, dZ) )
              }
          )# end with(as.list...
}

########################
### define controlling parameters
# rho     - Scaled Rayleigh number.
# sigma   - Prandtl number.
# beta   - Geometry ascpet ratio.
parameters <- c(rho=28, sigma= 10, beta=8/3)

########################
### define initial state
# state <- c(X=1, Y=1, Z=1)
state <- c(X=20, Y=41, Z=20)

########################
### define integrations times
# times <- seq(0,100, by=0.001)
times <- seq(0,100, by=0.01)

########################
### perform the integration and assign it to variable 'out'
out <- ode(y=state, times= times, func=Lorenz, parms=parameters)

########################
### Lorenz State Space lss DATA TABLE
lss <- as.data.table(out)

fsNNtmp <-function(x) {list("Lorenz")}
lss[,c("type"):=fsNNtmp(), ]
lss[,sample:=seq(.N)]
setcolorder(lss, c(5,6,1:4))

inputtimseries <- lss$X

################################
### (4.2) Windowing Data

windowstar <- 2000
windowend <- 4000
windowLenght <- windowend - windowstar


windowframe = windowstar:windowend
# windowframe = 2000:3000
# windowframe = 00:10000
lss <- lss[,.SD[windowframe]]



write(lss$X, file="timeseries_com-3methods",ncolumns=1)


################################################################################
## Plotting time series

plotlinewidth <- 3

# lenvec <- length(lss$time)
# colorvec <- inferno(lenvec)
# colorvec <- gnuplot(lenvec)

p <- ggplot(lss) +
  #  geom_line(aes(x=sample,y=X ), colour=colorvec, lwd = plotlinewidth,alpha=0.75)+
   geom_line(     aes(x=sample,y=X), lwd = 2, alpha=0.7)+      # line
   geom_point(    aes(x=sample,y=X), shape=21, size=2.5, stroke =0.5 ) + # stem type end
    # facet_wrap(~type, scales = 'free', nrow = 4)+
   labs( x = 'n', y='x(n)' )+
   theme(axis.text=element_text(size=20),
         axis.title=element_text(size=25))+
   theme(legend.position="none")+
   theme(
         panel.grid.major = element_line(colour = 'gray'),
         panel.grid.minor = element_line(colour = 'gray'),
         panel.background = element_rect(fill = "transparent",colour = NA),
         plot.background = element_rect(fill = "transparent",colour = NA)
    )





####################
### Save Picture

## Setting up plots_path
if (file.exists(plots_path)){
   setwd(file.path(plots_path))
} else {
 dir.create(plots_path, recursive=TRUE)
 setwd(file.path(plots_path))
}


width = 500
height = 500
text.factor = 1
dpi <- text.factor * 100
width.calc <- width / dpi
height.calc <- height / dpi



filenameimage <- paste("timeseries_", "windowLenght", windowLenght, "_comparison-3methods", ".png",sep="")


ggsave(filename = filenameimage,
             dpi = dpi,
             width = width.calc,
             height = height.calc,
             units = 'in',
             bg = "transparent",
             device = "png"
             , p)



################################################################################
setwd(r_scripts_path) ## go back to the r-script source path


################################################################################
## tseriesChaos method

input_timeseries <- lss$X

maxtau <- 100
numberOFpartitions  <- 1000

tsmitemp <- mutual(input_timeseries, partitions= numberOFpartitions , lag.max = maxtau, plot=FALSE)
mi <- as.data.table(unname(tsmitemp[]))

fsNNtmp <-function(x) {list("tseriesChaos")}
mi[,c("source"):=fsNNtmp(), ]
mi[, tau := 0:(.N-1), ]
setcolorder(mi, c(3,2,1))
colnames(mi) <- c('tau', 'source', 'mi')


################################################################################
## nonlinearTseries method

# tau-delay estimation based on the mutual information function
tau.ami <- timeLag(time.series = inputtimseries, technique = "ami",
                 selection.method = "first.minimum", lag.max = maxtau,
                 do.plot = F, n.partitions = numberOFpartitions,
                 units = "Bits")

tauamilag <- tau.ami[[1]]
tauamifx <- tau.ami[[2]]

ami <- as.data.table(tauamifx)


fsNNtmp <-function(x) {list("nonlinearTseries")}
ami[,c("source"):=fsNNtmp(), ]
ami[, tau := 0:(.N-1), ]
setcolorder(ami, c(3,2,1))
colnames(ami) <- c('tau', 'source', 'mi')


################################################################################
## Weeks methodow with miinfo.c
# ./minfo timeseries_com-3methods -b 100 -t 100 > weeksmethod.mi


ctsmi <- fread("weeksmethod.mi", header=FALSE)
fsNNtmp <-function(x) {list("weeksMethod")}
ctsmi[,c("source"):=fsNNtmp(), ]
setcolorder(ctsmi,c(    1,(ncol(ctsmi)),(ncol(ctsmi)-1)   ))
colnames(ctsmi) <- c('tau', 'source', 'mi')


MI <- rbind(mi,ami,ctsmi)




####################
### Save Picture

## Setting up plots_path
if (file.exists(plots_path)){
   setwd(file.path(plots_path))
} else {
 dir.create(plots_path, recursive=TRUE)
 setwd(file.path(plots_path))
}


pmi <- ggplot(MI, aes(x=tau, y=mi, colour=source, group=source))+
  geom_line(
      size=3)+
  geom_point(aes(shape=source),   # Shape depends on Source
           fill = "white",    # White fill
           size = 2)  +       # Large points
  scale_shape_manual(values=c(21,24,25))+  # Shapes: Filled circle, triangle
  labs(x='TAU', y='AMI' )+
  theme_bw(20)+
  theme(legend.position = c(0.8, 0.8))


width = 500
height = 500
text.factor = 1
dpi <- text.factor * 100
width.calc <- width / dpi
height.calc <- height / dpi

filenameimage <- paste("mi_comparison-3methods",".png",sep="")

ggsave(filename = filenameimage,
             dpi = dpi,
             width = width.calc,
             height = height.calc,
             units = 'in',
             bg = "transparent",
             device = "png"
             , pmi)






################################################################################
################################################################################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
################################################################################
################################################################################

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
