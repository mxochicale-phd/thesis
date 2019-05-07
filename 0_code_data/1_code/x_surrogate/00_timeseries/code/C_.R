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

library(ggplot2)
library(data.table)
library(devtools)
load_all(paste(github_path, libfun_path, '/nonlinearTseries', sep=""))

################################################################################
#  Logistic Map

signal_source<-'logisticmap'
a<-NULL# rqas


logistic.map <- function(r, x, N, M){
  ## r: bifurcation parameter
  ## x: initial value
  ## N: Number of iteration
  ## M: Number of iteration points to be returned
  z <- 1:N
  z[1] <- x
  for(i in c(1:(N-1))){
    z[i+1] <- r *z[i]  * (1 - z[i])
  }
  ## Return the last M iterations 
  z[c((N-M):N)]
}
#REF: https://www.r-bloggers.com/logistic-map-feigenbaum-diagram/

r <- 4
x <- 0.617
N <- 350
M <- 278
lm <- logistic.map(r, x, N, M)
lm <- lm  +  0.01*(1:(1+M))
sn <- lm

tsn <- as.data.table(sn)
tsn [,n:= 0:(.N-1),]
setcolorder(tsn, c(2,1))

xn <- tsn$sn







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
pts <- ggplot(tsn, aes(x = n, y = sn)) + 
	geom_line(size = 1)+
	labs(x = "Samples, n", y = 'x(n)')+
	theme_bw(18) 
	

### Save Picture
width = 800
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
        device = "png",
	pts)




#
##################################################################################
##################################################################################
##################################################################################
#### Surrogate Data Testing
#### https://rdrr.io/cran/nonlinearTseries/man/surrogateTest.html
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
