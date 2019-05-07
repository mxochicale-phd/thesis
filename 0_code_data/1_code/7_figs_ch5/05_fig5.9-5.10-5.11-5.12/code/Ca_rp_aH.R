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


libfun_path <- '/0_code_data/1_code/2_libraries_functions'
rfunctions_extra_rqa_R <- '/rfunctions/extra_rqa.R'


## Data Path
data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hii/dataset', sep="")
setwd(file.path(data_path))



################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(signal)# for butterworth filter and sgolay
library(ggplot2)
library(RColorBrewer)

library(devtools)
load_all(paste(github_repo_path, libfun_path, '/nonlinearTseries', sep=""))
source( paste(github_repo_path, libfun_path, rfunctions_extra_rqa_R, sep='') )



################################################################################
# (2) Reading data
file_ext <- paste('xdata', '.dt',sep='')
data <- fread( file_ext, header=TRUE)



# axis for horizontal movments
data <- data[,.(
	sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
	), by=. (Participant,Activity,Sensor,Sample,Time)]




################################################################################
################################################################################
################################################################################
################################################################################
### (4.1) Windowing Data [xdata[,.SD[1:2],by=.(Participant,Activity,Sensor)]]

W<-NULL#rqas for all windows


###########################
###### one window lenght
#windowsl <- c(100)
#windowsn <- c('w2')
#
#

##########################
##### one window lenght
windowsl <- c(500)
windowsn <- c('w10')


############################
###### four window lenghts
#windowsl <- c(100,250,500,750)
#windowsn <- c('w2', 'w5', 'w10', 'w15')
########################################
#### w2, 2-second window (100 samples) ## 100 to 200
########################################
#### w5, 5-second window (250 samples) # 100 to 350
#######################################
#### w10, 10-second window (500 samples) ## 100 to 600
########################################
#### w15, 15-second window (750 samples) ## 100 to 850


for ( wk in 1:(length(windowsl)) ) {

xdata <- data

windowlengthnumber <- windowsl[wk]

windowksams <- paste('w', windowlengthnumber, sep='')
windowksecs <- windowsn[wk]

message('****************')
message('****************')
message('****************')
message('****************')
message('*** window:', windowksams)



# general variables for window legnth
wstar=100
wend=wstar+windowlengthnumber
windowlength=wend-wstar
windowframe =wstar:wend
wdata <- xdata[,.SD[windowframe],by=.(Participant,Activity,Sensor)];



################################################################################
################################################################################
################################################################################
################################################################################
	## (4.2.1) Activities Selection
		
	A<-NULL#rqas for all activities
	main_activity_tag <- 'H'
	activities <- c('HNnb', 'HNwb', 'HFnb', 'HFwb')


	#########################################################
	for (activity_k in 1:length(activities) ) {

	activityk <- activities[activity_k]
	message(activityk)
	awdata <- wdata

	if (activityk == 'HNnb' ) {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('HNnb'))]

	} else if (activityk == 'HNwb' ) {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('HNwb'))]

	} else if (activityk == 'HFnb') {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('HFnb'))]

	} else if (activityk == 'HFwb') {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('HFwb'))]

	} else {
	message('no valid movement_variable')
	}

	#message(head(awdata)) ##show head of the activity windowed data table

###############################################################################
################################################################################
################################################################################
################################################################################
		## (4.2.3) Participants Selection

		P<-NULL#rqas for all participants

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
		pNN <- c('p01', 'p02', 'p03')
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




		for(participants_k in c(1:number_of_participants)){##for(participants_k in c(1:number_of_participants)) { 
		

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

			S<-NULL#rqas for all sensors
			
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
			message('no valid movement_variable')
			}

			##message(head(kskpawdata)) ##show head of sensok, particantk, activity, windowed datatable



#################################################################################
#################################################################################
#################################################################################
#################################################################################
				### (4.2.4) Axis Selection
				
				a<-NULL# rqas for one axis
				
	
				axis <- names(kskpawdata)[6: (  length(kskpawdata))  ]
				####### Axisk
				for (axis_k in c(1:length(axis)  )){ #for (axis_k in c(1:length(axis))){
				
				
				axisk<- axis[axis_k]
				message('#### axis:' , axisk )

				######################## inputtimeseries
				xn <- kskpawdata[,  get(axisk) ]


################################################################################
################################################################################
#  UNIFORM TIME DELAY EMBEDDING
################################################################################
################################################################################

dimensions <- c(6)
delays <- c(10)


################################################################################
for (dim_i in (1:100000)[dimensions]){
    	for (tau_j in (1:100000)[delays]){
		message('>> Embedding parameters:  m=',dim_i,' tau=',d=tau_j)
      	

		################################################################################
		# (3) Outcomes Plots Path
		if (file.exists(outcomes_plot_path)){
		  setwd(file.path(outcomes_plot_path))
		} else {
		  dir.create(outcomes_plot_path, recursive=TRUE)
		  setwd(file.path(outcomes_plot_path))
		}


		xfile <- paste(windowksams, activityk, participantk,sensork, axisk ,sep='')		
		filename_ext <- paste(xfile,
				"_m", formatC(dim_i,digits=2,flag="0"),"t",formatC(tau_j,digits=2,flag="0"), ".png",sep="")

		message(filename_ext)

		epsilon <- 1
		rqaa=rqa(time.series = xn, embedding.dim= dim_i, time.lag=tau_j,
                                   radius=epsilon,lmin=2,vmin=2,do.plot=FALSE,distanceToBorder=2)


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
#
#	rqas <- as.data.table(  t(	c(  
#		rqaa$REC, rqaa$RATIO, rqaa$DET, rqaa$DIV, 
#		rqaa$Lmax, rqaa$Lmean, rqaa$LmeanWithoutMain,
#		rqaa$ENTR, rqaa$LAM, 
#		rqaa$Vmax, rqaa$Vmean
#					)
#				)
#			     )
#	fa <- function(x) { axisk  }
#       	rqas[,c("Axis"):= fa(), ]
#
#	fs <- function(x) { sensork  }
#       	rqas[,c("Sensor"):= fs(), ]
# 
#	fp <- function(x) { participantk  }
#       	rqas[,c("Participant"):= fp(), ]
#
#	fac <- function(x) { activityk  }
#       	rqas[,c("Activity"):= fac(), ]
#
#	fw <- function(x) { windowksams  }
#       	rqas[,c("Window"):= fw(), ]
#
#
#	a <- rbind(a,rqas) #rqas with axisk
#

	
	

		########################
		#plottingRecurrencePlots
		rm <- as.matrix(rqaa$recurrence.matrix)
		#message('dim rm: ', dim(rm)[1],' ' , dim(rm)[2] )
		maxsamplerp <- dim(rm)[1]
		RM <- as.data.table( melt(rm, varnames=c('a','b'),value.name='Recurrence') )
		#message('dim RM: ', dim(RM)[1],' ' , dim(RM)[2] )
		

		N <- length(xn) 
		LXn <-	N - ((dimensions-1)*(delays))
		diffL<-N-LXn


		ai<-c()	
		bi<-c()	
		A<-(1+diffL):(LXn+diffL)
		for (i in (1:LXn)){
			aa<-as.data.table(A)
			ai<-rbind(ai,aa)	
			rr<-  as.data.table(rep(A[i],LXn ) )
			bi<- rbind( bi,rr )  
		}

		sample_rate<-50
		RM$a<-ai/sample_rate
		RM$b<-bi/sample_rate

		#RM$a<-ai
		#RM$b<-bi



		################################################################################
		# (5.0) Creating  and Changing to PlotPath
		plot_path <- paste(outcomes_plot_path, '/rp_plots', '/', main_activity_tag, sep="")
		if (file.exists(plot_path)){
		    setwd(file.path(plot_path))
		} else {
		  dir.create(plot_path, recursive=TRUE)
		  setwd(file.path(plot_path))
		}



		sample_rate <- 50
		rpo <- plotRecurrencePlot(RM, maxsamplerp)

		width = 500
		height = 500
		saveRP(filename_ext,width,height,rpo)




	} # for (dim_i in (1:500)[dimensions]){
} # for (tau_j in (1:500)[delays]){
#################################################################################



################################################################################
################################################################################
#  UNIFORM TIME DELAY EMBEDDING
################################################################################
################################################################################




				}##end##for (axis_k in c(1:length(axis)  )){ 
#################################################################################
#################################################################################
#################################################################################
#################################################################################


S <- rbind(S,a) # rqa values with axisk, sensork


			}##end##for (sensor_k in 1:length(sensors) ) {
#################################################################################
#################################################################################
#################################################################################
#################################################################################


P <- rbind(P,S) # rqa values with axisk, sensork, particantsk 


		}##end##for (participants_k in c(1:number_of_participants)) { 
################################################################################
################################################################################
################################################################################
################################################################################


A <- rbind(A,P) # rqa values with axisk, sensork, particantsk, activityk


	}##end## for (activity_k in 1:length(activities) ) {
################################################################################
################################################################################
################################################################################
################################################################################

W <- rbind(W,A) # rqa values with axisk, sensork, particantsk, activityk, windowksams

} ##end## for ( wk in 1:(length(windowsl)) ) { 
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
