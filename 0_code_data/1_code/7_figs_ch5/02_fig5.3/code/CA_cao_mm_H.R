###############################################################################	
#
# 
# 
#
#
#
#
###############################################################################	
	# TABLE OF CONTENT:
 	# (0) Definifing paths 
	# (1) Loading libraries and functions
	# (2) Reading data

	# (6) Plot E values
		# (6.1) main if for:
			# (6.1.0) Creating paths for plots
			# (6.1.1) E1 and E2 values
			# (6.1.2) Minimum Embedding Dimensions Plots


#################
# Start the clock!
start.time <- Sys.time()




################################################################################
# (0) Defining paths for main_path, r_scripts_path, ..., etc.




r_scripts_path <- getwd()
setwd("../../../../../")
github_repo_path <- getwd()

## Outcomes Data Path
outcomes_data_path <- paste(github_repo_path,'/0_code_data/0_data/1_datasets/hii/utde', sep="")
## Data Path
data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hii/utde', sep="")
setwd(file.path(data_path))




################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data

################################################################################
# (2) Reading data

#acts <- 'H'
#windowl<-'w2'
#wdata <- fread('MED-w2.dt', header=TRUE)
#

#acts <- 'H'
#windowl<-'w5'
#wdata <- fread('MED-w5.dt', header=TRUE)
#
acts <- 'H'
windowl<-'w10'
wdata <- fread('MED-w10.dt', header=TRUE)

#acts <- 'H'
#windowl<-'w15'
#wdata <- fread('MED-w15.dt', header=TRUE)
#

################################################################################
################################################################################
################################################################################
################################################################################
	## (4.2.1) Activities Selection

	ACPSAmdim <- NULL


	#activities <- c('HNnb', 'HNwb')
	#activities <- c('HFnb', 'HFwb')
	
	activities <- c('HNnb', 'HNwb', 'HFnb', 'HFwb')
	#activities <- c('VNnb', 'VNwb', 'VFnb', 'VFwb')

	##all activities
	#activities <- c('HNnb', 'HNwb', 'HFnb', 'HFwb', 'VNnb', 'VNwb', 'VFnb', 'VFwb')

	#########################################################
	for (activity_k in 1:length(activities) ) {

	activityk <- activities[activity_k]
	message(activityk)
	awdata <- wdata

	if (activityk == 'HNnb' ) {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('HNnb'))]

	} else if (activityk == 'HFnb' ) {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('HFnb'))]

	} else if (activityk == 'HNwb' ) {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('HNwb'))]

	} else if (activityk == 'HFwb' ) {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('HFwb'))]

	} else if (activityk == 'VNnb') {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('VNnb'))]

	} else if (activityk == 'VFnb') {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('VFnb'))]

	} else if (activityk == 'VNwb') {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('VNwb'))]

	} else if (activityk == 'VFwb') {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('VFwb'))]

	} else {
	message('no valid activityk')
	}



	#message(head(awdata)) ##show head of the activity windowed data table



################################################################################
################################################################################
################################################################################
################################################################################
		## (4.2.3) Participants Selection

			
		PSAmdim <- NULL
		

		#number_of_participants <- 1
		#number_of_participants <- 3
		number_of_participants <- 6
		#number_of_participants <- 12
		#number_of_participants <- 20

		if (number_of_participants == 1) {
		setkey(awdata, Participant)
		pNN <- c('p01')
		pawdata <- awdata[.(
				pNN
				)]

		} else if (number_of_participants == 3) {
		setkey(awdata, Participant)
		pNN <- c('p04', 'p05', 'p10')
		pawdata <- awdata[.(
				pNN
				)]

		} else if (number_of_participants == 6) {
		setkey(awdata, Participant)
		pNN <- c('p01', 'p04', 'p05', 'p10', 'p11', 'p15')
		pawdata <- awdata[.(
				pNN
				)]



		} else if  (number_of_participants == 12) {
		setkey(awdata, Participant)
		pNN <- c('p01', 'p02', 'p03', 'p04', 'p05', 'p06', 'p07', 'p08', 'p09', 'p10','p11', 'p12')
		pawdata <- awdata[.(
				pNN
				)]

		} else if  (number_of_participants == 20) {
		setkey(awdata, Participant)
		pNN <- 		c(	'p01', 'p02', 'p03', 'p04', 'p05', 'p06', 'p07', 'p08', 'p09', 'p10',
					'p11', 'p12', 'p13', 'p14', 'p15', 'p16', 'p17', 'p18', 'p19', 'p20')	
		pawdata <- awdata[.(
				pNN
				)]

		} else {
		message('not a valid number_of_participants')
		}


		for (participants_k in c(1:number_of_participants)) { ##for (participants_k in c(1:number_of_participants)) { 
		

		participantk <-  pNN[participants_k] 
		message('####################')
		message('# PARTICIPANT: ', participantk )
		setkey(pawdata, Participant)
		kpawdata <- pawdata[.( participantk )]


		##message(head(kpawdata)) ##show head of participant_k, activity, windowed, data table


				
#################################################################################
#################################################################################
################################################################################
#################################################################################
################################
			#### (4.2.2) Sensor Selection

		SAmdim <- NULL
		
			#sensors <- c('HS01') # HumanSensor01
			sensors <- c('HS01','HS02')# HumanSensor01  and HumanSensor02

			#########################################################
			for (sensor_k in 1:length(sensors) ) {

			sensork <- sensors[sensor_k]
			message(sensork)
			skpawdata <- kpawdata


			if (sensork == 'HS01' ) {
			setkey(skpawdata, Sensor)
			kskpawdata <- skpawdata[.(c('HS01'))]

			} else if (sensork == 'HS02' ) {
			setkey(skpawdata, Sensor)
			kskpawdata <- skpawdata[.(c('HS02'))]

			} else {
			message('no valid activityk')
			}

			##message(head(kskpawdata)) ##show head of sensok, particantk, activity, windowed datatable







#################################################################################
#################################################################################
#################################################################################
#################################################################################
				### (4.2.4) Axis Selection

	Amdim <- NULL


	mainaxis <- 'GyroZ'
	selaXX <- c(	
		paste('sg0zmuv',mainaxis,sep=''),
		paste('sg1zmuv',mainaxis,sep=''),
		paste('sg2zmuv',mainaxis,sep='')
		)

				axis <- names(kskpawdata)[5: (  length(kskpawdata))  ]
				
				####### Axis
				for (axis_k in c(1:length(selaXX)  )){ #for (axis_k in c(1:length(axis))){
				axisk<- selaXX[axis_k]
				message('#### axis:' , axisk )

				kakskpawdata  <-  kskpawdata[  axis %in% axisk ]




				mdim <-  as.data.table( round( mean(kakskpawdata$minEmdDim) ) ) 

	
				#axisk
                               	fak <- function(x) { axisk }
                               	mdim[,c("Axis"):= fak(), ]                               	
				Amdim <- rbind( Amdim, mdim)


#				######################## inputtimeseries
#				xn <- kskpawdata[,  get(axisk) ]
#	
#				xfile <- paste(windowksams, activityk, participantk,sensork, axisk ,sep='')
#		
#				filenameimage <- paste(xfile,
#					"_m", formatC(dim_i,digits=2,flag="0"),"t",formatC(tau_j,digits=2,flag="0"), ".png",sep="")
#
#				message(filenameimage)
#


				}##end##for (axis_k in c(1:length(axis)  )){ 
#################################################################################
#################################################################################
#################################################################################
#################################################################################




				#sensork
                               	fsk <- function(x) { sensork }
                               	Amdim[,c("Sensor"):= fsk(), ]                               	
				SAmdim <- rbind( SAmdim, Amdim)





			}##end##for (sensor_k in 1:length(sensors) ) {
#################################################################################
#################################################################################
#################################################################################
#################################################################################



			#participantk
                        fpk <- function(x) { participantk }
                        SAmdim[,c("Participant"):= fpk(), ]                               	
			PSAmdim <- rbind( PSAmdim, SAmdim)


	



		}##end##for (participants_k in c(1:number_of_participants)) { 
################################################################################
################################################################################
################################################################################
################################################################################



	#ACtivityk
        fACk <- function(x) { activityk }
        PSAmdim[,c('Activity'):= fACk(), ]                               	
	ACPSAmdim <- rbind( ACPSAmdim, PSAmdim)




	}##end## for (activity_k in 1:length(activities) ) {
################################################################################
################################################################################
################################################################################
################################################################################



setnames(ACPSAmdim, 'V1', 'aMED')
################################################################################
# (6) Creating Outcome Data Path


if (file.exists(outcomes_data_path)){
  setwd(file.path(outcomes_data_path))
} else {
  dir.create(outcomes_data_path, recursive=TRUE)
  setwd(file.path(outcomes_data_path))
}


###############################################################################
####  (7)  Writing Data

 

#acts <- 'H'
#windowl<-'w10'
tagfile <- paste('-',acts,'-', windowl, '.dt', sep='')
aMEDfilename <- paste ('aMED', tagfile, sep='')

write.table(ACPSAmdim, aMEDfilename, row.name=FALSE)












#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
