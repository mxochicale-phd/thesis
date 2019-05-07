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
setwd("../../../../../../")
github_path <- getwd()
libfun_path <- '/0_code_data/1_code/2_libraries_functions'

plots_path <- paste(r_scripts_path,"/plots_path",sep="")



### Load libraries
library(deSolve)
library(data.table)
library(ggplot2)
library(devtools)
load_all(paste(github_path, libfun_path, '/nonlinearTseries', sep=""))



### Orginal source code for Plotting
# old.par = par(mfrow = c(1, 2))
# # tau-delay estimation based on the autocorrelation function
# tau.acf = timeLag(inputtimseries, technique = "acf",
#                  lag.max = 100, do.plot = T)
# # tau-delay estimation based on the mutual information function
# tau.ami = timeLag(inputtimseries, technique = "ami",
#                  lag.max = 100, do.plot = T)



####TESTING

# lagmax <- 50

# tau-delay estimation based on the autocorrelation function
tau.acf <- timeLag(time.series = inputtimseries, technique = "acf", selection.method = "first.minimum", lag.max = 100, do.plot = F)
# tau.acf = 56 with lag.max = NULL
# tau.acf = 56 with lag.max = 100

# tau-delay estimation based on the mutual information function
tau.ami <- timeLag(time.series = inputtimseries, technique = "ami", selection.method = "first.minimum", lag.max = 50, do.plot = F, n.partitions = 1000, units = "Bits")
# with lag.max = NULL
# tau.ami = 17
# with lag.max = 100
# tau.ami = 17
# with lag.max = 100, , n.partitions = 10
# tau.ami = 17
# with lag.max = 100, , n.partitions = 1000 (it takes around 2.2 seconds)
# tau.ami = 15
# with lag.max = 100, , n.partitions = 10000   (it takes more time for computing the parameter (~1.7minutes))
# tau.ami = 4

tauamilag <- tau.ami[[1]]
tauamifx <- tau.ami[[2]]

#### Plotting


########################
### Lorenz State Space lss DATA TABLE
amis <- as.data.table(tauamifx)



# fsNNtmp <-function(x) {list("Lorenz")}
# lss[,c("type"):=fsNNtmp(), ]
amis[,tau:=seq(.N)]
setcolorder(amis, c(2,1))





pmi <- ggplot(amis, aes(x=tau, y=tauamifx) )+
  geom_line(
      size=3)+
  geom_point( aes(),   # Shape depends on Source
           fill = "white",    # White fill
           size = 2)  +       # Large points
  labs(x='TAU', y='AMI' )+
  theme_bw(20)+
  theme(legend.position = c(0.8, 0.8))



plot(pmi)

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
#filenameimage <- paste("ami_", ".png",sep="")
#
#
#ggsave(filename = filenameimage,
#             dpi = dpi,
#             width = width.calc,
#             height = height.calc,
#             units = 'in',
#             bg = "transparent",
#             device = "png"
#             , pmi)
#





################################################################################
################################################################################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
################################################################################
################################################################################

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
