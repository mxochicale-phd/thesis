#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:
# FileDescription:
#
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
library(deSolve)
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
state <- c(X=1, Y=1, Z=1)
# state <- c(X=20, Y=41, Z=20)
# X=0.01; Y=0.01; Z=0.01


########################
### define integrations times
# dt=0.01
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




################################
### (4.2) Windowing Data
# framewindow <- 1000:5000;
windowstar <- 2000
windowend <- 4000
windowLenght <- windowend - windowstar


windowframe = windowstar:windowend
# windowframe = 2000:3000
# windowframe = 00:10000
lss <- lss[,.SD[windowframe]]


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

# plot(p)

write(lss$X, file="datafile",ncolumns=1)


################################################################################
################################################################################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
################################################################################
################################################################################

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
