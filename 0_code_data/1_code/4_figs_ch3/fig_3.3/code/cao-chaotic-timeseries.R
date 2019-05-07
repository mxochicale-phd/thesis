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
path_cao97_functions_R <- '/0_code_data/1_code/2_libraries_functions/rfunctions/embedding_parameters/withCao1997/cao97_functions.R'


################################################################################
# (1) Loading Functions and Libraries

library(deSolve)
library(data.table)
library(ggplot2)
require(tseriesChaos)
library(plot3D)
library(RColorBrewer)
require(pals) # for colours






# ################################################################################
# # Nyquist Theorem
# # said that the frequency of the signal
# # should be the double as the sampling frequency to recover the signal
# # and avoid problems with aliasing. For instance, for the
# # maximum hearning frequency of  20Hz, the
# # sampling rate for those signals should be 40 Hz.
# # FSampling > 2*F max
#
# # Fmax=5
# # 50 > 2*5
# # 50 > 10
#
# # For our case, the Maximum Frequencies shohould be
# # Fmapling/2 which is a maximum freqneices of 25
# #
#
#
#







######################
### Lorenz Function
###



time_series_name <- "chaotic-timeseries"

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

plot_path <- paste(figures_path, sep="")
if (file.exists(plot_path)){
    setwd(file.path(plot_path))
} else {
  dir.create(plot_path, recursive=TRUE)
  setwd(file.path(plot_path))
}




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



filenameimage <- paste(time_series_name, "_windowLenght", windowLenght, ".png",sep="")


ggsave(filename = filenameimage,
             dpi = dpi,
             width = width.calc,
             height = height.calc,
             units = 'in',
             bg = "transparent",
             device = "png"
             , p)


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
## CAO's Algorithm
##
source(paste(github_path, path_cao97_functions_R, sep=''))

maxtau <- 20
maxdim <- 21
delta_ee <- 0.05
inputtimeseries<-lss$X


E <- data.table()
for (tau_i in 1:maxtau){
    message( 'tau: ', tau_i )
    Et<- as.data.table(cao97sub(inputtimeseries,maxdim,tau_i) )
    func <-function(x) {list( tau_i )}
    Et[,c("tau"):=func(), ]
    Et[,dim:=seq(.N)]
    setcolorder(Et, c(3,4,1:2))
    E <- rbind(E, Et )
}

names(E) <- gsub("V1", "E1", names(E))
names(E) <- gsub("V2", "E2", names(E))




################################################################################
### Plot E values

e1 <- plotE1values(E,maxdim,maxtau,delta_ee)
e2 <- plotE2values(E,maxdim,maxtau)


## setting parameters for images
plotlinewidtg <- 0.7
image_width <- 3000
image_height <- 1700
image_dpi <- 300
# image_bg <- "white" #
image_bg <- "transparent"



filenameimage <- paste(time_series_name, "_e1_", "windowLenght", windowLenght, ".png",sep="")
png(filenameimage, width=image_width, height=image_height, units="px", res=image_dpi, bg=image_bg)
print(e1)
dev.off()

filenameimage <- paste(time_series_name, "_e2_", "windowLenght", windowLenght,  ".png",sep="")
png(filenameimage, width=image_width, height=image_height, units="px", res=image_dpi, bg=image_bg)
print(e2)
dev.off()








################################################################################
################################################################################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
################################################################################
################################################################################


################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
