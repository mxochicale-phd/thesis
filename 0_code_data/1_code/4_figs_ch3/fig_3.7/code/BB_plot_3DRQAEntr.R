###############################################################################	
#
# plot_3DRQAEntr for openface landmarks 
# 
#
#
#
###############################################################################	
	# OUTLINE:
	# (0) Defining paths for main_path, r_scripts_path, ..., etc.
	# (1) Loading Functions and Libraries and Setting up digits
	# (2) Setting DataSets paths and reading data
	# (3) Reading data

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



###############################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(plot3D)

#################################################################################
## (2) Setting DataSets paths and reading data
setwd(data_path)

################################################################################
# (3) Reading data
signal_source<-'sinewaves'
file_ext <- paste('RQA3D_', signal_source, '.dt',sep='')
RQA <- fread( file_ext, header=TRUE)


################################################################################
################################################################################
################################################################################
################################################################################
## RQA Metric Selection
rqas <- c('ENTR')
#rqas <- c('REC','DET', 'RATIO', 'ENTR')



zlim_max<-10


for (rqas_k in 1:length(rqas) ) {

rqask <- rqas[rqas_k]
message('############')
message('RQA: ',rqask)

Rk <- RQA[,.(
	get(rqask)
	), by=. (source, dim, tau, eps)]


################################################################################
# (3.0) Creating  and Changing to PlotPath
if (file.exists(figures_path)){
    setwd(file.path(figures_path))
} else {
  dir.create(figures_path, recursive=TRUE)
  setwd(file.path(figures_path))
}


Leps <- length( seq(0.2,3.0,0.1) )
epsilons <- Rk$eps[1:Leps]

epsi_j <- length(epsilons)
dims_i <- dim(Rk)[1]/epsi_j

## RQA metric column with ENTR
m<-as.matrix(Rk[,5])
mm<-matrix(m,dims_i,epsi_j, byrow=TRUE)

### Save Picture
image_width = 2000
image_height = 2000
#image_bg = "transparent"
image_bg = "white"
text.factor = 1
image_dpi <- text.factor * 100
width.calc <- image_width / image_dpi
height.calc <- image_height / image_dpi


filenameimage <- paste(signal_source, '_3D_RQA', rqask, '.png', sep='')
png(filenameimage, width=image_width, height=image_height, units="px", res=image_dpi, bg=image_bg)

persp3D(
	x = 1:nrow(mm),
	y = 1:ncol(mm),
	z = mm,
	xlab = "", 
	ylab = "", 
	zlab = "", 
	zlim = c(0,zlim_max),

	#phi = 0, 
	phi = 30, 

	#theta = 0,
	#theta = 20,
	theta = 30,
	#theta = 60,
	#theta = 90,
	#theta = 120,
	#theta = 140,
	#theta = 160,
	#theta = 190,


	ticktype = "detailed",
	nticks = 9,
	colkey = list(
		dist = -0.06, # distance from the main plot
		side=4,
		length = 0.3, 
		width = 0.8, 
		shift = 0.0,
		line.clab = 2,
		cex.axis =7, # font size for numbers
		cex.clab = 4,
		addlines=FALSE),
	lighting = FALSE,  #If notFALSEthe facets will be illuminated, and colors may appear more bright
	#lphi = 90,
	clab = rqask,
	bty = "b2", 
	plot = TRUE,
	#space = 5, 
	#d = 10, 
	cex.lab = 7,# change font size of the labels 
	#cex.axis = 5# change axis tick size to a very low size
	cex.axis = 1e-9# change axis tick size to a very low size
	#contour = list(col = "grey", side = c("z"))
)



#
#dimensions <- seq(1,10)
#delays <- seq(1,10)
#xk<-NULL
#for (dk in 1:length(dimensions)  ) {
#	for (tk in 1:length(delays) ) {
#	pk <- paste( '(', dimensions[dk], ',', delays[tk], ')', sep='' )
#	xk <- cbind( xk, pk)	
#	}
#}
#
#
#yk<-NULL
#for ( k in 1:length(epsilons)  ){
#	yk <- cbind(yk, as.character(epsilons[k]) )
#	}
#
#
#text3D(x = rep( nrow(mm) , ncol(mm) ), y= 1:ncol(mm), z = rep(0.16, ncol(mm) ),
#	cex=2,
#	labels = yk,
#	add = TRUE, adj = 0)
#
#text3D(x = 1:nrow(mm), y = rep(0.6, nrow(mm) ), z = rep(0.18, nrow(mm)),
#	cex=1,
#	labels = xk,
#	add = TRUE, adj = 1)
#

dev.off()








#############################
#############################
##
##
## INDIVIDUAL RECURRENCE THRESHODLS 
##
##
### Save Picture
image_width = 2000
image_height = 2000
#image_bg = "transparent"
image_bg = "white"
text.factor = 1
image_dpi <- text.factor * 100
width.calc <- image_width / image_dpi
height.calc <- image_height / image_dpi
	

EPS<-c (0.2,0.5,0.7,1.0,
	1.2,1.5,1.7,2.0,
	2.2,2.5,2.7,3.0)



message('Plotting different 3DRQA with different eps')
for (eps_k in 1:length(EPS) ) {

	recurrence_threshold<-EPS[eps_k]
	message(recurrence_threshold)


	A<-Rk[, range:= (eps== recurrence_threshold ), by=. (source, dim, tau, eps)]
	A<-A[range == TRUE] # filter only true values for the condition "eps== recurrence_threshold"
	A<-A[,range:=NULL] # delete range column

	tau_i <- length(1:10)
	dim_j <- length(1:10)
	m<-as.matrix(A[,5])
	mm<-matrix(m,tau_i,dim_j, byrow=TRUE)


filenameimage <- paste(signal_source, '_', rqask, '_', 'eps_', recurrence_threshold, '.png', sep='')
png(filenameimage,width=image_width, height=image_height, units="px", res=image_dpi, bg=image_bg)

persp3D(
	x = 1:nrow(mm),
	y = 1:ncol(mm),
	z = mm,
	xlab = "", 
	ylab = "", 
	zlab = "", 
	zlim = c(0,zlim_max),
	#col=color,
	#col=color[zcol],
	#col=color[zcol2],
	#col.palette = heat.colors,
	#colvar = mm,
#	#phi = 0, 
	phi = 30, 
#
#	#theta = 0,
#	#theta = 20,
	theta = 30,
#	#theta = 60,
#	theta = 90,
#	#theta = 120,
#	#theta = 140,
#	theta = 160,
#	#theta = 190,
#
#
	ticktype = "detailed",
	nticks = 9,
	colkey = list(
		dist = -0.06, # distance from the main plot
		side=4,
		length = 0.3, 
		width = 0.8, 
		shift = 0.0,
		line.clab = 2,
		cex.axis =7, # font size for numbers
		cex.clab = 4,
		addlines=FALSE), 
	lighting = FALSE,  #If notFALSEthe facets will be illuminated, and colors may appear more bright
#	#lphi = 90,
	clab = rqask,# label for col key
	bty = "b2", 
#	#space = 5, 
#	#d = 10, 
	cex.lab = 7,# change font size of the labels 
	cex.axis = 5,# change axis tick size to a very low size
#	#contour = list(col = "grey", side = c("z"))
	add=FALSE,
	plot=TRUE
)


dev.off()






	}
	#for (eps_k in 1:length(EPS) ) {
################################################################################
##
##
##
## INDIVIDUAL RECURRENCE THRESHODLS 
##
##
#############################
#############################


	}##end## for (rqas_k in 1:length(rqas) ) {
################################################################################
################################################################################
################################################################################
################################################################################







#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path


