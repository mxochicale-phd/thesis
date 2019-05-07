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
library(data.table)
library(ggplot2)


################################################################################
# (1) Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()
plots_path <- paste(r_scripts_path,"/plots_path",sep="")


###################
## Main R Script


################################################################################
## tseriesChaos method


temp <- NULL;
temp<-read.csv("datafile", header=FALSE, sep=' ');
lts <-temp[,]
temp <- NULL;

maxtau <- 100
b  <- 100

tsmitemp <- mutual(lts, partitions= b , lag.max = maxtau, plot=FALSE)
tsmi <- as.data.table(unname(tsmitemp[]))

fsNNtmp <-function(x) {list("tseriesChaos")}
tsmi[,c("Source"):=fsNNtmp(), ]
tsmi[, TAU := 0:(.N-1), ]
setcolorder(tsmi, c(3,2,1))
colnames(tsmi) <- c('TAU', 'Source', 'mi')

################################################################################
## Weeks methodow with miinfo.c
ctsmi <- fread("r.mi", header=FALSE)
fsNNtmp <-function(x) {list("weeksMethod")}
ctsmi[,c("Source"):=fsNNtmp(), ]
setcolorder(ctsmi,c(    1,(ncol(ctsmi)),(ncol(ctsmi)-1)   ))
colnames(ctsmi) <- c('TAU', 'Source', 'mi')

MI <- rbind(ctsmi,tsmi)


pmi <- ggplot(MI, aes(x=TAU, y=mi, colour=Source, group=Source))+
  geom_line(
      size=3)+
  geom_point(aes(shape=Source),   # Shape depends on Source
           fill = "white",    # White fill
           size = 2)  +       # Large points
  scale_shape_manual(values=c(21,24))+  # Shapes: Filled circle, triangle
  labs(x='TAU', y='AMI' )+
  theme_bw(20)+
  theme(legend.position = c(0.8, 0.8))


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



filenameimage <- paste("mi_comparison-2methods",".png",sep="")

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
