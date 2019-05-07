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
require(tseriesChaos)
library(data.table)
library(ggplot2)
library(latex2exp)
library(devtools)
load_all(paste(github_path, libfun_path, '/nonlinearTseries', sep=""))



##################################################################
# Time Domain setup

windowLenght <- 2000



# acq.freq <- 50  # 50 Hertz
# dt <- 1/acq.freq # 0.02 seconds or 20 miliseconds
#
# T <- 40   ## Maximum Time in seconds
# df <- 1/T
# n <- T/dt
# t <- seq(0,T,by=dt)



################################################################################
# Create Waveforms in a data.table object

allSDnoise <- 0.00

rts <- data.table(
  sample=0:windowLenght,
  X= rnorm(windowLenght+1)
  # xn= runif(windowLenght+1)
  )





################################################################################
## Plotting time series

plotlinewidth <- 3

# lenvec <- length(lss$time)
# colorvec <- inferno(lenvec)
# colorvec <- gnuplot(lenvec)

p <- ggplot(rts) +
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



filenameimage <- paste("random_timeseries_", "windowLenght", windowLenght, ".png",sep="")


ggsave(filename = filenameimage,
             dpi = dpi,
             width = width.calc,
             height = height.calc,
             units = 'in',
             bg = "transparent",
             device = "png"
             , p)







###############################################################################
## nTs method

inputtimseries <- rts$X


maxtau <- 100
numberOFpartitions <- 100

# tau-delay estimation based on the mutual information function
tau.ami <- timeLag(time.series = inputtimseries, technique = "ami",
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


width = 700
height = 400
text.factor = 1
dpi <- text.factor * 100
width.calc <- width / dpi
height.calc <- height / dpi


filenameimage <- paste("amis_randomTimeSeries", ".png",sep="")


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
