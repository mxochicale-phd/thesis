#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:
# FileDescription:
#
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#

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
require(tseriesChaos)
library(data.table)
library(ggplot2)
library(latex2exp)
library(devtools)
load_all(paste(github_path, libfun_path, '/nonlinearTseries', sep=""))


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


windowframe = windowstar:windowend
# windowframe = 2000:3000
# windowframe = 00:10000
lss <- lss[,.SD[windowframe]]



################################################################################
# (3) Plotting 




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
   xlab( TeX(' $\ n$ ') )+
   ylab( TeX(' $\ x(n)$ ') )+
   theme(axis.text=element_text(size=20),
         axis.title=element_text(size=25))+
   theme(legend.position="none")+
   theme(
         panel.grid.major = element_line(colour = 'gray'),
         panel.grid.minor = element_line(colour = 'gray'),
         panel.background = element_rect(fill = "transparent",colour = NA),
         plot.background = element_rect(fill = "transparent",colour = NA)
    )





#####################
#### Save Picture
plot_path <- paste(figures_path, sep="")
if (file.exists(plot_path)){
    setwd(file.path(plot_path))
} else {
  dir.create(plot_path, recursive=TRUE)
  setwd(file.path(plot_path))
}



width = 400
height = 400
text.factor = 1
dpi <- text.factor * 100
width.calc <- width / dpi
height.calc <- height / dpi



filenameimage <- paste("lorenz_timeseries_", "windowLenght", windowLenght, ".png",sep="")


ggsave(filename = filenameimage,
             dpi = dpi,
             width = width.calc,
             height = height.calc,
             units = 'in',
             bg = "transparent",
             device = "png"
             , p)


################################################################################
## nTs method

input_time_series <- lss$X
maxtau <- 100
numberOFpartitions <- 100

# tau-delay estimation based on the mutual information function
tau.ami <- timeLag(time.series = input_time_series, technique = "ami",
                  selection.method = "first.minimum", lag.max = maxtau,
                  do.plot = F, n.partitions = numberOFpartitions,
                  units = "Bits")

tauamilag <- tau.ami[[1]]
tauamifx <- tau.ami[[2]]

ami <- as.data.table(tauamifx)


fsNNtmp <-function(x) {list("nTs")}
ami[,c("source"):=fsNNtmp(), ]
ami[, tau := 0:(.N-1), ]
setcolorder(ami, c(3,2,1))
colnames(ami) <- c('tau', 'source', 'mi')





pmi <- ggplot(ami, aes(x=tau, y=mi))+
  geom_line(
      size=3)+
  # geom_point(aes(shape=source),   # Shape depends on Source
  #          fill = "white",    # White fill
  #          size = 2)  +       # Large points
  # scale_shape_manual(values=c(21,24))+  # Shapes: Filled circle, triangle
  xlab( TeX(' $\\tau$ ') )+
  ylab( TeX(' AMI ') )+
  # labs(x='TAU', y='AMI (bits)' )+
  theme(axis.text=element_text(size=20),
        axis.title=element_text(size=25))+
  theme(legend.position="none")+
  theme(
        panel.grid.major = element_line(colour = 'gray'),
        panel.grid.minor = element_line(colour = 'gray'),
        panel.background = element_rect(fill = "transparent",colour = NA),
        plot.background = element_rect(fill = "transparent",colour = NA)
   )


  #  theme_bw(20)+
  #  theme(legend.position = c(0.8, 0.8))



width = 700
height = 400
text.factor = 1
dpi <- text.factor * 100
width.calc <- width / dpi
height.calc <- height / dpi


filenameimage <- paste("amis_lorenzTimeSeries", ".png",sep="")


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
