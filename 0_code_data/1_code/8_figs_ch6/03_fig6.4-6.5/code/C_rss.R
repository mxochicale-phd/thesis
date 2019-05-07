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
	# (3) Creating paths
	# (4) Selecting Variables in data.table
		# (4.1)	Selecting Participants
	# (5) Adding vectors
		# (5.1) Deleting some Magnetomer and quaternion data
		# (5.2) zero mean and unit variance
		# (5.3) Savitzky-Golay filter
	# (6) Selecting Axis after postprocessing
	# (7) Creating preprocessed data path
	# (8) Writing data.table object to a file



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
rfunctions_ollin_cencah_R <- '/rfunctions/ollin_cencah.R'

## Data Path
data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hri/dataset', sep="")
setwd(file.path(data_path))





################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(signal)# for butterworth filter and sgolay
source( paste(github_repo_path, libfun_path, rfunctions_ollin_cencah_R, sep='') )


################################################################################
# (2) Reading data
file_ext <- paste('xdata', '.dt',sep='')
data <- fread( file_ext, header=TRUE)





################################################################################
################################################################################
################################################################################
################################################################################
### (4.1) Windowing Data [xdata[,.SD[1:2],by=.(Participant,Activity,Sensor)]]


###########################
###### one window lenght
#windowsl <- c(100)
#windowsn <- c('w2')
#dimensions <- c(4)
#delays <- c(5)
#

##########################
##### one window lenght
windowsl <- c(500)
windowsn <- c('w10')
dimensions <- c(6)
delays <- c(8)



############################
###### four window lenghts
#windowsl <- c(100,250,500,750)
#windowsn <- c('w2', 'w5', 'w10', 'w15')
#




#######################################
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

#

################################################################################
################################################################################
################################################################################
################################################################################
	## (4.2.1) Activities Selection
	#activities <- c('HN','HF')
	activities <- c('HN','HF', 'VN', 'VF')

	#########################################################
	for (activity_k in 1:length(activities) ) {

	activityk <- activities[activity_k]
	message(activityk)
	awdata <- wdata

	if (activityk == 'HN' ) {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('HN'))]

	} else if (activityk == 'HF' ) {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('HF'))]

	} else if (activityk == 'VN') {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('VN'))]

	} else if (activityk == 'VF') {
	setkey(awdata, Activity)
	awdata <- awdata[.(c('VF'))]

	} else {
	message('no valid movement_variable')
	}

	#message(head(awdata)) ##show head of the activity windowed data table

################################################################################
################################################################################
################################################################################
################################################################################
		## (4.2.3) Participants Selection

		number_of_participants <- 1
		#number_of_participants <- 3
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

			#sensors <- c('HS01') # HumanSensor01
			sensors <- c('RS01','HS01')# RobotSensor01  and HumanSensor01	

			#########################################################
			for (sensor_k in 1:length(sensors) ) {

			sensork <- sensors[sensor_k]
			message(sensork)
			skpawdata <- kpawdata



			if (sensork == 'RS01' ) {
			setkey(skpawdata, Sensor)
			kskpawdata <- skpawdata[.(c('RS01'))]

			} else if (sensork == 'HS01' ) {
			setkey(skpawdata, Sensor)
			kskpawdata <- skpawdata[.(c('HS01'))]

			} else {
			message('no valid movement_variable')
			}

			##message(head(kskpawdata)) ##show head of sensok, particantk, activity, windowed datatable



#################################################################################
#################################################################################
#################################################################################
#################################################################################
				### (4.2.4) Axis Selection
				axis <- names(kskpawdata)[6: (  length(kskpawdata))  ]


				####### Axis
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

# lines copied to the window selection section
#dimensions <- c(6)
#delays <- c(8)

#dimensions <- c(5,6,7)
#delays <- c(5,10,15)


		################################################################################
		# (3) Outcomes Plots Path
		dimXXXtauXXX <- paste('dim', formatC(dimensions,digits=2,flag="0"), 'tau', formatC(delays,digits=2,flag="0"), sep="")
		utde_outcomes_plot_path <- paste( outcomes_plot_path, '/', windowksecs, '-', dimXXXtauXXX,sep='')

		if (file.exists(utde_outcomes_plot_path)){
		  setwd(file.path(utde_outcomes_plot_path))
		} else {
		  dir.create(utde_outcomes_plot_path, recursive=TRUE)
		  setwd(file.path(utde_outcomes_plot_path))
		}


################################################################################
for (dim_i in (1:100000)[dimensions]){
    	for (tau_j in (1:100000)[delays]){
		message('>> Embedding parameters:  m=',dim_i,' tau=',d=tau_j)

	
		xfile <- paste(windowksams, activityk, participantk,sensork, axisk ,sep='')
		
		filenameimage <- paste(xfile,
				"_m", formatC(dim_i,digits=2,flag="0"),"t",formatC(tau_j,digits=2,flag="0"), ".png",sep="")


	      	
       		Xmt <- UTDE(  xn,   dim_i,tau_j, print_Xdims = TRUE )
       		Ymt <- RSS( Xmt )
				
		### Save Picture
		image_width = 500
		image_height = 500
		image_bg = "transparent"
		text.factor = 1
		image_dpi <- text.factor * 100
		width.calc <- image_width / image_dpi
		height.calc <- image_height / image_dpi
			
		#png(filenameimage,width=width.calc, height=height.calc, units="px", res=image_dpi, bg=image_bg)
		png(filenameimage,width=image_width, height=image_height, units="px", res=image_dpi, bg=image_bg)
       	
		#plotRSS3D_rotateddata(Ymt, Nx, dim, tau, sample_rate)
		plotRSS3D_rotateddata(Ymt, length(xn), dim_i, tau_j, 50)
        	
		dev.off()


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



			}##end##for (sensor_k in 1:length(sensors) ) {
#################################################################################
#################################################################################
#################################################################################
#################################################################################





		}##end##for (participants_k in c(1:number_of_participants)) { 
################################################################################
################################################################################
################################################################################
################################################################################





	}##end## for (activity_k in 1:length(activities) ) {
################################################################################
################################################################################
################################################################################
################################################################################



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


