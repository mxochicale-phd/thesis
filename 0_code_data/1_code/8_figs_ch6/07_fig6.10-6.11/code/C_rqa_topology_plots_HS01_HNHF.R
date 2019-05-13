###############################################################################	
#
# 
#
#
#
#
#
###############################################################################	
	# OUTLINE:
 	# (0) Definifing paths 
	# (1) Loading libraries and functions
	# (2) Reading 


#################
# Start the clock!
start.time <- Sys.time()




################################################################################
# (0) Defining paths for main_path, r_scripts_path, ..., etc.



r_scripts_path <- getwd()
setwd("../")
main_path <- getwd()
outcomes_plot_path <- paste(main_path,'/src',sep="")
setwd("../../../../")
github_repo_path <- getwd()


## Data Path
data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hri/3Drqa', sep="")
setwd(file.path(data_path))





################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(plot3D)



################################################################################
# (2) Reading data
#
#file_ext <- paste('RQAs_p01w100.dt',sep='')
#W100 <- fread( file_ext, header=TRUE)
#
#file_ext <- paste('RQAs_p01w250.dt',sep='')
#W250 <- fread( file_ext, header=TRUE)
#
#file_ext <- paste('RQAs_p01w500.dt',sep='')
#W500 <- fread( file_ext, header=TRUE)
#
#file_ext <- paste('RQAs_p01w750.dt',sep='')
#W750 <- fread( file_ext, header=TRUE)
#
#W <- rbind(W100, W250, W500, W750)
#

#file_ext <- paste('RQAs_p02w500.dt',sep='')
#W <- fread( file_ext, header=TRUE)
#




file_ext <- paste('RQAs_p01w500_HS01_HNHF.dt',sep='')
#file_ext <- paste('RQAs_p03w500_H.dt',sep='')
W <- fread( file_ext, header=TRUE)


################################################################################
################################################################################
################################################################################
################################################################################
## (x.x.x) RQA Metric Selection
#rqas <- c('ENTR')
rqas <- c('REC','DET', 'RATIO', 'ENTR')


#########################################################
for (rqas_k in 1:length(rqas) ) {

rqask <- rqas[rqas_k]
message(rqask)



if (rqask == 'REC'){
	zlim_max<-1
	} else if (rqask=='DET'){
	zlim_max<-1
	} else if (rqask=='RATIO'){	
	zlim_max<-1000
	} else if (rqask=='ENTR'){
	zlim_max<-10
	} else {
	message('not defined')
	}





Wk <- W[,.(
	get(rqask)
	), by=. (Participant, Window, Activity, Sensor, Axis, dim, tau, eps)]



selectParticipant <- 'p01'
#selectParticipant <- 'p02'
#selectParticipant <- 'p03'
Wk <-  Wk[ Participant %in% selectParticipant ]

#selectWindow <- 'w100'
#selectWindow <- 'w250'
selectWindow <- 'w500'
#selectWindow <- 'w750'
Wkw <-  Wk[ Window %in% selectWindow ]


################################################################################
################################################################################
################################################################################
################################################################################
	## (4.2.1) Activities Selection
	#activities <- c('HN')
	activities <- c('HN','HF')
	#activities <- c('VN','VF')


	#########################################################
	for (activity_k in 1:length(activities) ) {

	activityk <- activities[activity_k]
	message('+',activityk)
	#awdata <- wdata

	Wkak <-  Wkw[ Activity %in% activityk ]
	


				
#################################################################################
#################################################################################
################################################################################
#################################################################################
################################
			#### (4.2.2) Sensor Selection

			sensors <- c('HS01') # HumanSensor01
			#sensors <- c('RS01','HS01')# RobotSensor01  and HumanSensor01	

			#########################################################
			for (sensor_k in 1:length(sensors) ) {

			sensork <- sensors[sensor_k]
			message('++',sensork)


			Wkaksk <-  Wkak[ Sensor %in% sensork ]




#################################################################################
#################################################################################
#################################################################################
#################################################################################
				### (4.2.4) Axis Selection

				axis <- c('sg0zmuvGyroZ')
				#axis <- c('sg0zmuvGyroZ', 'sg1zmuvGyroZ', 'sg2zmuvGyroZ')
				#axis <- c('sg0zmuvGyroY', 'sg1zmuvGyroY', 'sg2zmuvGyroY')

				####### Axis
				for (axis_k in c(1:length(axis)  )){ #for (axis_k in c(1:length(axis))){
				axisk<- axis[axis_k]
				message('+++',axisk)



Wk <-  Wkaksk[ Axis %in% axisk ]






Leps <- length( seq(0.2,3.0,0.1) )
epsilons <- Wk$eps[1:Leps]

epsi_j <- length(epsilons)
dims_i <- dim(Wk)[1]/epsi_j


## RQA metric column with: REC, DET, RATIO, ENTR
m<-as.matrix(Wk[,9])
mm<-matrix(m,dims_i,epsi_j, byrow=TRUE)



################################################################################
# (5.0) Creating  and Changing to PlotPath

plots_path <- paste( outcomes_plot_path, '/', selectParticipant   ,sep='')
if (file.exists(plots_path)){
    setwd(file.path(plots_path))
} else {
  dir.create(plots_path, recursive=TRUE)
  setwd(file.path(plots_path))
}







### Save Picture
image_width = 2000
image_height = 2000
#image_bg = "transparent"
image_bg = "white"
text.factor = 1
image_dpi <- text.factor * 100
width.calc <- image_width / image_dpi
height.calc <- image_height / image_dpi
	
#filenameimage <- paste(xfile,
#		"_m", formatC(dim_i,digits=2,flag="0"),"t",formatC(tau_j,digits=2,flag="0"), ".png",sep="")


filenameimage <- paste(selectWindow, '_', rqask, '_', sensork, '_', activityk, '_', axisk, '.png', sep='')
png(filenameimage,width=image_width, height=image_height, units="px", res=image_dpi, bg=image_bg)

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
	cex.lab = 3,# change font size of the labels 
	cex.axis = 3# change axis tick size to a very low size
	#contour = list(col = "grey", side = c("z"))
)




#
################################
###### CREATING AND ADDING AXIS
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



				}##end##for (axis_k in c(1:length(axis)  )){ 
#################################################################################
#################################################################################
#################################################################################
#################################################################################





			}##end##for (sensor_k in 1:length(sensors) ) {
#################################################################################
#################################################################################
#################################################################################
#################################################################################







	}##end## for (activity_k in 1:length(activities) ) {
################################################################################
################################################################################
################################################################################
################################################################################





	}##end## for (rqas_k in 1:length(rqas) ) {
################################################################################
################################################################################
################################################################################
################################################################################






#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
# message('Execution Time: ', end.time - start.time)

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
