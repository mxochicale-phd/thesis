r_scripts_path <- getwd()
setwd("../../../../../")
github_repo_path <- getwd()


library(data.table)
library(deSolve)
library(ggplot2)



################################################################################
# Lorenz Function
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


################################################################################
# Lorenz time-series

#define controlling parameters
# rho     - Scaled Rayleigh number.
# sigma   - Prandtl number.
# beta   - Geometry ascpet ratio.
parameters <- c(rho=28, sigma= 10, beta=8/3)

#define initial state
state <- c(X=1, Y=1, Z=1)
# yini <- c(X = 0.01, Y = 0.001, Z = 0.001)
# state <- c(X=20, Y=41, Z=20)


# define integrations times
# times <- seq(0,100, by=0.001)
times <- seq(0,150, by=0.1)
# timeserie <- seq(0, 150, by = 0.1)

#perform the integration and assign it to variable 'out'
out <- ode(y=state, times= times, func=Lorenz, parms=parameters)
maxLength <- dim(out)[1]


# Lorenz Time series as data.table object
lts <- as.data.table(out)
func <-function(x) {list("Lorenz")}
lts[,c("type"):=func(), ]
lts[,n:=seq(.N)]
setcolorder(lts, c(5,6,1:4))



################################################################################
### (4.1) Windowing Data
###
windowframe = 1000:maxLength;
lts <- lts[,.SD[windowframe],by=.(type)];


################################################################################
### Plot time series
p <- ggplot(lts) +
   geom_line(aes(x=n,y=X,col='x'),lwd = 1,alpha=0.8)+
   geom_line(aes(x=n,y=Y,col='y'),lwd = 1,alpha=0.8)+
   geom_line(aes(x=n,y=Z,col='z'),lwd = 1,alpha=0.8)+
   facet_wrap(~type, scales = 'free', nrow = 4)+
   theme_bw(20)

# p



################################################################################
## CAO's Algorithm
##
source(paste(github_repo_path,'/code/rfunctions/embedding_parameters/withCao1997/cao97_functions.R', sep=''))


maxdim <- 31
maxtau <- 15

E <- data.table()
for (tau_i in 1:maxtau){
    Et<- as.data.table(cao97sub(lts$X,maxdim,tau_i) )
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

delta_ee<-0.1
e1<-plotE1values(E,maxdim,maxtau,delta_ee)
#e1

e2 <- plotE2values(E,maxdim,maxtau)
#e2



#############################################
setwd(r_scripts_path) ## go back to the r-script source path


