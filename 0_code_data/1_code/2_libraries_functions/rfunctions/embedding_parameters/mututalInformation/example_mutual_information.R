library(data.table)
library(deSolve)
library(ggplot2)

# Parameters for the solver
parameters <- c(s = 10, r = 28, b = 8/3)

##
# In initial state
yini <- c(X = 0.01, Y = 0.001, Z = 0.001)

Lorenz <- function(t, state, parameters) {
  with(as.list(c(state, parameters)), {
    dX <- s * (Y - X)
    dY <- X * (r - Z) - Y
    dZ <- X * Y - b * Z
    list(c(dX, dY, dZ))
  })
}

timeserie <- seq(0, 150, by = 0.1)
out <- ode(y = yini, times = timeserie, func = Lorenz, parms = parameters)


# Lorenz Time series as data.table object
lts.dt <- as.data.table(out)
func <-function(x) {list("Lorenz")}
lts.dt[,c("type"):=func(), ]
lts.dt[,n:=seq(.N)]
setcolorder(lts.dt, c(5,6,1:4))



################################
### (4.1) Windowing Data
windowframe = 200:1200;
lts.dt <- lts.dt[,.SD[windowframe],by=.(type)];



# #########################################
# ### Plot time series
# p <- ggplot(lts.dt) +
#    geom_line(aes(x=n,y=X,col=type),lwd = 1,alpha=0.8)+
#    facet_wrap(~type, scales = 'free', nrow = 4)+
#    theme_bw(20)
#
# dev.new(xpos=0,ypos=0,width=18, height=6)
# p



################################################################################
## Mutual information
##


library('nonlinearTseries')
# suppose that we have only measured the x-component of the Lorenz system
lor.x = lts.dt$X



# tau-delay estimation based on the mutual information function
tau.ami = timeLag(lor.x, technique = "ami",
                  selection.method = "first.e.decay",
                  lag.max = 100, do.plot = F)



# emb.dim = estimateEmbeddingDim( lor.x,
#                                 time.lag = tau.ami,
#                                 max.embedding.dim = 15,
#                                 threshold=0.95)
#                                 #0.95 is the default




# library('tseriesChaos')
# maxlag <- 20
# mi <- mutual(ts, partitions=16, lag.max=maxlag, plot=FALSE)
# MI <- as.data.table(mi[])
#
#
#
# # func <-function(x) {list( tau_i )}
# # Et[,c("tau"):=func(), ]
# MI[,n:=seq(.N)]
# names(MI) <- gsub("V1", "MI", names(MI))
# setcolorder(MI, c(2,1))
#
#
# p <- ggplot(MI) +
#    geom_line(aes(x=n,y=MI),lwd = 1,alpha=0.8)+
#    theme_bw(20)
#
# dev.new(xpos=0,ypos=0,width=18, height=6)
# p
#
#
