###############################################################################	
# 
# 
#
#
#
###############################################################################	



#################
# Start the clock!
start.time <- Sys.time()

################################################################################
# (0) Defining paths for main_path, r_scripts_path, ..., etc.
homepath <- Sys.getenv("HOME")
r_scripts_path <- getwd()
setwd("../")
main_path <- getwd()
figures_path <- paste(main_path,'/src',sep="")
setwd("../../../../")
github_path <- getwd()

libfun_path <- '/0_code_data/1_code/2_libraries_functions'



################################################################################
# (1) Loading Functions and Libraries

library(deSolve)
library(data.table)
library(ggplot2)
require(tseriesChaos)
library(plot3D)
library(RColorBrewer)
require(pals) # for colours


library(devtools)
load_all(paste(github_path, libfun_path, '/nonlinearTseries', sep=""))



signal_source<-'lorenz_timeseries'

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



################################
### (4.2) Windowing Data

windowstar <- 2000
windowend <- 4000
windowLenght <- windowend - windowstar
N <- windowLenght

windowframe = windowstar:windowend
# windowframe = 2000:3000
# windowframe = 00:10000
lss <- lss[,.SD[windowframe]]


xn = lss$X






#############################################################
##  Create Plot Output Path
##
plot_path <- paste(figures_path, '/', signal_source, sep="")
if (file.exists(plot_path)){
    setwd(file.path(plot_path))
} else {
  dir.create(plot_path, recursive=TRUE)
  setwd(file.path(plot_path))
}


#############################################################
##  Plotting 
##



lenvec <- length(lss$time)
colorvec <- gnuplot(lenvec)
plotlinewidth <- 3
# colorvec <- inferno(lenvec)


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




# # # dev.new(xpos=10,ypos=1100,width=11, height=8)
# dev.new(xpos=1000,ypos=200,width=20, height=8)
# plot(p)


### Save Picture
width = 500
height = 500
text.factor = 1
dpi <- text.factor * 100
width.calc <- width / dpi
height.calc <- height / dpi


ts_filename_extension <-  paste('ts_', signal_source, '_window_length_', N, '.png', sep='')  
ggsave(filename = ts_filename_extension,
             dpi = dpi,
             width = width.calc,
             height = height.calc,
             units = 'in',
             bg = "transparent",
             device = "png"
             , p)





#pts <- ggplot(tsn, aes(x = n, y = sn)) + 
#	geom_line(size = 1)+
#	labs(x = "Samples, n", y = 'x(n)')+
#	theme_bw(18) 
#	
#
#### Save Picture
#width = 800
#height = 500
#text.factor = 1
#dpi <- text.factor * 100
#width.calc <- width / dpi
#height.calc <- height / dpi
#
#
#ts_filename_extension <-  paste('ts_', signal_source, '_window_length_', N, '.png', sep='')  
#ggsave(filename = ts_filename_extension,
#        dpi = dpi,
#        width = width.calc,
#        height = height.calc,
#        units = 'in',
#        bg = "transparent",
#        device = "png",
#	pts)
#



#
##################################################################################
##################################################################################
##################################################################################
#### Surrogate Data Testing
#### https://rdrr.io/cran/nonlinearTseries/man/surrogateTest.html
#


#
##################################################################################
##################################################################################
##################################################################################
#### Surrogate Example from 
#### https://rdrr.io/cran/nonlinearTseries/man/surrogateTest.html
#
#
sdt = surrogateTest(	time.series = xn,
			significance = 0.05,
                     	K=5, 
			one.sided = FALSE, 
			FUN=timeAsymmetry,
			do.plot=FALSE
		) 



###############################
## saving  surrogate data testing plot
#`surrogate.data.R` at 
#$HOME/phd/phd-thesis/0_code_data/1_code/2_libraries_functions/nonlinearTseries/R 


  surrogates.statistics = sdt$surrogates.statistics 
  data.statistic = sdt$data.statistic 

xlab = "Values of the statistic"
ylab = ""
main="Surrogate data testing"
type = "h"
lwd = 2
xlim = NULL
ylim = NULL
 
  
  if (is.null(xlim)) {
    xlim = range(data.statistic, surrogates.statistics)
  }
  if (is.null(ylim)) {
    ylim = c(0, 3)
  } 
 

  
sdt_filename_extension <-  paste('sdt_', signal_source, '_window_length_', N, '.png', sep='')  
png(sdt_filename_extension, width = 500, height = 500)

 
 plot(surrogates.statistics, rep(1, length(surrogates.statistics)), 
       xlim = xlim, ylim = ylim, 
       type = type, lwd = lwd, main = main, xlab = xlab, ylab = ylab, 
       col = 1, lty = 1)
 lines(data.statistic,2, type = type, lwd = lwd, col = 2, lty = 2)
 legend("top",bty = "n", legend = c("Surrogate data", "Original data"), col = 1:2,  lty = c(1, 2), lwd = lwd)
 



 
dev.off() 









#################################################################################
## (3) Plotting 
#
#plot_path <- paste(figures_path, sep="")
#if (file.exists(plot_path)){
#    setwd(file.path(plot_path))
#} else {
#  dir.create(plot_path, recursive=TRUE)
#  setwd(file.path(plot_path))
#}
#
#
#
#
#lenvec <- length(lss$time)
#colorvec <- gnuplot(lenvec)
#plotlinewidth <- 3
## colorvec <- inferno(lenvec)
#
#
#p <- ggplot(lss) +
#  #  geom_line(aes(x=sample,y=X ), colour=colorvec, lwd = plotlinewidth,alpha=0.75)+
#   geom_line(     aes(x=sample,y=X), lwd = 2, alpha=0.7)+      # line
#   geom_point(    aes(x=sample,y=X), shape=21, size=2.5, stroke =0.5 ) + # stem type end
#    # facet_wrap(~type, scales = 'free', nrow = 4)+
#   labs( x = 'n', y='x(n)' )+
#   theme(axis.text=element_text(size=20),
#         axis.title=element_text(size=25))+
#   theme(legend.position="none")+
#   theme(
#         panel.grid.major = element_line(colour = 'gray'),
#         panel.grid.minor = element_line(colour = 'gray'),
#         panel.background = element_rect(fill = "transparent",colour = NA),
#         plot.background = element_rect(fill = "transparent",colour = NA)
#    )
#
#
#
#
## # # dev.new(xpos=10,ypos=1100,width=11, height=8)
## dev.new(xpos=1000,ypos=200,width=20, height=8)
## plot(p)
#
#
#### Save Picture
#width = 500
#height = 500
#text.factor = 1
#dpi <- text.factor * 100
#width.calc <- width / dpi
#height.calc <- height / dpi
#
#
#
#filenameimage <- paste(time_series_name, "_windowLenght", windowLenght, ".png",sep="")
#
#
#ggsave(filename = filenameimage,
#             dpi = dpi,
#             width = width.calc,
#             height = height.calc,
#             units = 'in',
#             bg = "transparent",
#             device = "png"
#             , p)
#
#
#
#################################################################################
#################################################################################
#################################################################################
### Plotting time series with colors
#
#
#
#lenvec <- length(lss$time)
#colorvec <- gnuplot(lenvec)
#plotlinewidth <- 3
## colorvec <- inferno(lenvec)
#
#
#p <- ggplot(lss) +
#   geom_line(aes(x=sample,y=X ), colour=colorvec, lwd = plotlinewidth,alpha=0.75)+
#  #  geom_line(aes(x=sample,y=Y ), colour=colorvec, lwd = plotlinewidth,alpha=0.7)+
#  # geom_line(aes(x=sample,y=Z ), colour=colorvec, lwd = plotlinewidth,alpha=0.7)+
#    # facet_wrap(~type, scales = 'free', nrow = 4)+
#   labs( x = 't', y='x(t)' )+
#   theme(axis.text=element_text(size=20),
#         axis.title=element_text(size=25))+
#   theme(legend.position="none")+
#   theme(
#      panel.grid.major = element_blank(),
#      panel.grid.minor = element_blank(),
#      panel.background = element_rect(fill = "transparent",colour = NA),
#      plot.background = element_rect(fill = "transparent",colour = NA)
#      # axis.line = element_line(colour = "black")
#      )
#
#
#
## # # dev.new(xpos=10,ypos=1100,width=11, height=8)
## dev.new(xpos=1000,ypos=200,width=20, height=8)
## plot(p)
#
#
#### Save Picture
#width = 1000
#height = 500
#text.factor = 1
#dpi <- text.factor * 100
#width.calc <- width / dpi
#height.calc <- height / dpi
#
#ggsave(filename = "timeseries.png",
#             dpi = dpi,
#             width = width.calc,
#             height = height.calc,
#             units = 'in',
#             bg = "transparent",
#             device = "png"
#             , p)
#
### Plotting time series with colors
#################################################################################
#################################################################################
#################################################################################






################################################################################
################################################################################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
################################################################################
################################################################################


################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
