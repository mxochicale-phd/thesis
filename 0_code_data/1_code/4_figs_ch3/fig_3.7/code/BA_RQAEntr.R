###############################################################################	
#
# 3D surface plots of RQAEntr 
# 
#
#
#
#
###############################################################################	
	# OUTLINE:
	# (0) Defining paths for main_path, r_scripts_path, ..., etc.
	# (1) Loading libraries and functions

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
data_path <- paste(main_path,'/data',sep="")
setwd("../../../../")
github_path <- getwd()
libfun_path <- '/0_code_data/1_code/2_libraries_functions'


################################################################################
# (1) Loading Functions and Libraries
library(data.table) # for manipulating data
library(ggplot2) # for plotting 
library(signal)# for butterworth filter and sgolay
library(RColorBrewer)

library(devtools)
load_all(paste(github_path, libfun_path, '/nonlinearTseries', sep=""))

################################################################################
# Sine waves 

signal_source<-'sinewaves'
a<-NULL# rqas

N <- 278
tn <- 0:N
tsn <- sin ( (1/5)*tn ) * sin ( (5/100)*tn  )
tsn <- as.data.table(tsn)

tsn [,n:= 0:(.N-1),]
setcolorder(tsn, c(2,1))
names(tsn) <- c('n', 'sn')

xn <- tsn$sn


################################################################################
################################################################################
#  UNIFORM TIME DELAY EMBEDDING
################################################################################
################################################################################

#dimensions <- c(6)
#delays <- c(8)

#dimensions <- c(6,7)
#delays <- c(8,9)

#dimensions <- c(5, 6, 7)
#delays <- c(7, 8, 9)
#
#dimensions <- c(5, 6, 7, 8, 9, 10)
#delays <- c(5, 6, 7, 8, 9, 10)
#

dimensions <- seq(1,10)
delays <- seq(1,10)


################################################################################
for (dim_i in (1:100000)[dimensions]){
    	for (tau_j in (1:100000)[delays]){
		message('>> Embedding parameters:  m=',dim_i,' tau=',d=tau_j)
      	


################################################################################
# Recurrence Quantification Analysis
################################################################################

		#epsilons <- c(0.9, 1.0, 1.1)
		#epsilons <- c(0.9, 1.0, 1.1, 1.2)
		#epsilons <- seq(0.1,5.0,0.1)
		epsilons <- seq(0.2,3.0,0.1)


		for (epsilon_idx in 1:(length(epsilons)) ){

		epsilon_k <- epsilons[ epsilon_idx ] 
		message('                                        epsilon_k: ', epsilon_k )
      	

		rqaa=rqa(
			time.series = xn, 
			embedding.dim= dim_i, time.lag=tau_j, radius=epsilon_k,
			lmin=2, vmin=2, do.plot=FALSE, distanceToBorder=2
			)


#####################################################
#$recurrence.matrix (matrix of N*(m-1)T x N(m-1)T  )
#$diagonalHistogram (vector of N*(m-1)T length  )
#$recurrenceRate  (vector of N*(m-1)T length   )
#####################
#$REC (single value)
#$RATIO (single value)
#$DET (single value)
#$DIV (single value)
#$Lmax (single value)
#$Lmean (single value)
#$LmeanWithoutMain (single value)
#$ENTR (single value)
#$LAM (single value)
#$Vmax (single value)
#$Vmean (single value)

	rqas <- as.data.table(  
		t(	
			c(  
				#rqaa$REC, rqaa$RATIO, rqaa$DET, rqaa$DIV, 
				#rqaa$Lmax, rqaa$Lmean, rqaa$LmeanWithoutMain,
				#rqaa$ENTR, rqaa$LAM, 
				#rqaa$Vmax, rqaa$Vmean
				#rqaa$REC
				rqaa$ENTR
			)
		)
		)

	fss <- function(x) { signal_source }
       	rqas[,c("source"):= fss(), ]

	fD <- function(x) { dim_i }
       	rqas[,c("dim"):= fD(), ]

	fT <- function(x) { tau_j }
       	rqas[,c("tau"):= fT(), ]

	fEp <- function(x) { epsilon_k }
       	rqas[,c("eps"):= fEp(), ]

	a <- rbind(a,rqas) #accumulating

		}#for (epsilon_k in (1:100000)[epsilons]){
################################################################################
# Recurrence Quantification Analysis
################################################################################


	} # for (dim_i in (1:500)[dimensions]){
} # for (tau_j in (1:500)[delays]){
#################################################################################

################################################################################
################################################################################
#  UNIFORM TIME DELAY EMBEDDING
################################################################################
################################################################################



















#################################################################################
## () Rename col names and change order
#
rqacn <- c('ENTR')
names(a)[1] <- rqacn
setcolorder(  a,c( 2,3,4,5, 1)  )



################################################################################
####  (8)  Writing Data 
###############################################################################
if (file.exists(data_path)){
    setwd(file.path(data_path))
} else {
  dir.create(data_path, recursive=TRUE)
  setwd(file.path(data_path))
}

file_ext <- paste('RQA3D_', signal_source, '.dt',sep='')
write.table(a, file_ext, row.name=FALSE)



################################################################################
# Creating  and Changing to PlotPath
if (file.exists(figures_path)){
    setwd(file.path(figures_path))
} else {
  dir.create(figures_path, recursive=TRUE)
  setwd(file.path(figures_path))
}


#############################
##### TIME SERIES
pts <- ggplot(tsn,aes(x = n, y = sn)) + 
	geom_line(size = 1)+
	labs(x = "Samples, n", y = 'x(n)')+
	theme_bw(18) 
	

### Save Picture
width = 800
height = 400
text.factor = 1
dpi <- text.factor * 100
width.calc <- width / dpi
height.calc <- height / dpi

file_ext <- paste(signal_source,'_ts.png', sep='')
ggsave(filename = file_ext, 
	dpi = dpi, 
	width = width.calc, 
	height = height.calc, 
	units = 'in', 
	bg = "transparent",
        device = "png",
	pts)



#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path

