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


### Data Path
#data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hii', sep="")
#setwd(file.path(data_path))



rawdata_path <- paste(github_repo_path,'/0_code_data/0_data/0_raw-timeseries/hii',sep='')
setwd(file.path(rawdata_path))


################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(signal)# for butterworth filter and sgolay
library(ggplot2)


## (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(signal)# for butterworth filter and sgolay
source(paste(github_repo_path, libfun_path, rfunctions_ollin_cencah_R, sep='')) # Calling `functions_ollin_cencah` 




#################################################################################
## (2) Reading raw tidied  interpolated data
xdataHS01 <- fread("hii-HS01-TidiedInterpolatedRawData.dt", header=TRUE)
xdataHS02 <- fread("hii-HS02-TidiedInterpolatedRawData.dt", header=TRUE)
xdataHS03 <- fread("hii-HS03-TidiedInterpolatedRawData.dt", header=TRUE)
xdataHS04 <- fread("hii-HS04-TidiedInterpolatedRawData.dt", header=TRUE)

## all sensors
#xdataHS0102 <- merge(xdataHS01, xdataHS02, all=TRUE)
#xdataHS0304 <- merge(xdataHS03, xdataHS04, all=TRUE)
#xdata <- merge(xdataHS0102, xdataHS0304, all=TRUE)
#

#### HS01 and HS02 sensors
#xdata <- merge(xdataHS01, xdataHS02, all=TRUE)

#### HS03 and HS04 sensors
#xdata <- merge(xdataHS03, xdataHS04, all=TRUE)

### HS01  sensor
xdata <- xdataHS01




# add time variable
xdata[, Time:=Sample/50, ]
# add one sample to start at 0 instead of 0.2
xdata[, Time:=Time-0.02, ]
# reorder 
setcolorder(xdata, c(1:4, 11, 5:10))






###############################################################################
### (4.1) Selecting Participants
setkey(xdata, Participant)

### One Participants
xdata <- xdata[.(c('p01'))]

### Two Participants
#xdata <- xdata[.(c('p01','p02'))]


### Three Participant
#xdata <- xdata[.(c('p01', 'p02', 'p03'))]
#xdata <- xdata[.(c('p04', 'p05', 'p06'))]
#xdata <- xdata[.(c('p07', 'p08', 'p09'))]
#xdata <- xdata[.(c('p10', 'p11', 'p12'))]
#xdata <- xdata[.(c('p13', 'p14', 'p15'))]
#xdata <- xdata[.(c('p15','p16', 'p17' ))]
#

#################################################################################
### Six Participants
#xdata <- xdata[.(c(
#		'p01','p02', 'p03', 'p04', 'p05', 'p06'
#		))]
#

################################################################################
## Twelve Participants
#xdata <- xdata[.(c(
#		'p01','p02', 'p03', 'p04', 'p05', 'p06','p07','p08', 'p09', 'p10',
#		'p11','p12'
#		))]
#

################################################################################
## Seventeenth Participants
#xdata <- xdata[.(c(
#		'p01','p02', 'p03', 'p04', 'p05', 'p06','p07','p08', 'p09', 'p10',
#		'p11','p12', 'p13', 'p14', 'p15', 'p16','p17'
#		))]
#


#
################################################################################
#
## FILTERED DATA FOR HORIZOTAL/VERTICAL
## Participants because of offphase is very notable
#xdata <- xdata[.(c(
#		'p01', 'p04', 'p05', 'p10', 'p11', 'p15'
#		))]
#
#

#################################################################################
#### (5) postprocessing vectors
#


################################################################################
### (5.2) Zero mean and unit Variance
###
xdata[,c('sg0zmuvAccX', 'sg0zmuvAccY', 'sg0zmuvAccZ','sg0zmuvGyroX', 'sg0zmuvGyroY', 'sg0zmuvGyroZ'
	) :=
       lapply(.(
		AccX, AccY, AccZ, GyroX, GyroY, GyroZ
		), 
	function(x) ( zeromean_unitvariance(x)  ) )]




################################################################################
### (5.3) Smoothing data with Savitzky-Golay Filter
###

### FUNCTON TO SMOOTH THE DATA
SGolay <- function(xinput,sgCoeffs){
  output <- filter(sgCoeffs, xinput)
  return(output)
}

polynomial_degree <- 5
SavitzkyGolayCoeffs1 <- sgolay(p=polynomial_degree, n=29 ,m=0)
SavitzkyGolayCoeffs2 <- sgolay(p=polynomial_degree, n=159 ,m=0)


xdata[,c('sg1AccX', 'sg1AccY', 'sg1AccZ', 'sg1GyroX', 'sg1GyroY', 'sg1GyroZ',
	 'sg1zmuvAccX', 'sg1zmuvAccY', 'sg1zmuvAccZ', 'sg1zmuvGyroX', 'sg1zmuvGyroY', 'sg1zmuvGyroZ'
	) :=
	lapply(.(
		AccX, AccY, AccZ, GyroX, GyroY, GyroZ,
		sg0zmuvAccX, sg0zmuvAccY, sg0zmuvAccZ, sg0zmuvGyroX, sg0zmuvGyroY, sg0zmuvGyroZ
		), 
	function(x) ( SGolay(x,SavitzkyGolayCoeffs1)  ))
	]

xdata[,c('sg2AccX', 'sg2AccY', 'sg2AccZ', 'sg2GyroX', 'sg2GyroY', 'sg2GyroZ',
	 'sg2zmuvAccX', 'sg2zmuvAccY', 'sg2zmuvAccZ', 'sg2zmuvGyroX', 'sg2zmuvGyroY', 'sg2zmuvGyroZ'
	) :=
	lapply(.(
		AccX, AccY, AccZ, GyroX, GyroY, GyroZ,
		sg0zmuvAccX, sg0zmuvAccY, sg0zmuvAccZ, sg0zmuvGyroX, sg0zmuvGyroY, sg0zmuvGyroZ
		), 
	function(x) ( SGolay(x,SavitzkyGolayCoeffs2)  ))
	]



################################################################################
# (6) Selecting Axis after postprocessing 


### GyroY -- VERTICAL
### GyroZ -- HORIZONTAL
xpa <- xdata[,.(
	sg0zmuvGyroY, sg1zmuvGyroY, sg2zmuvGyroY,
	sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
	), by=. (Participant,Activity,Sensor,Sample,Time)]






################################################################################
# (7.1) SHIFTING TIME SERIES BY PARTITICPANTS AND ACTIVITY for HORIZONTAL AND VERTICAL

##############################
##############################
##############################
#
#
###  HS01 and HS02 sensor   xdata <- merge(xdataHS01, xdataHS02, all=TRUE)
#
#
###  ELIMINATED DATA: GyroX



##############################
##############################
##############################
##############################
## HORIZONTAL


shiftHNnb<-250
shiftHNwb<-200
shiftHFnb<-140
shiftHFwb<-180

# p01 H GyroY
xpa[Participant=='p01' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



# p01 H GyroZ
xpa[Participant=='p01' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ] 







###############################
###############################
###############################
###############################
### VERTICAL

shiftVNnb<-150
shiftVNwb<-275
shiftVFnb<-075
shiftVFwb<-000


# p01 V GyroY
xpa[Participant=='p01' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p01 V GyroZ
xpa[Participant=='p01' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 





























#################################################################################
#################################################################################
# PLOT





################################################################################
################################################################################
################################################################################
################################################################################
### (4.1) Windowing Data [xdata[,.SD[1:2],by=.(Participant,Activity,Sensor)]]


#########################
#### one window lenght
windowsl <- c(3000)
windowsn <- c('w10')


##########################
##### one window lenght
#windowsl <- c(750)
#windowsn <- c('w15')
#

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

xdata <- xpa
windowlengthnumber <- windowsl[wk]
windowksams <- paste('w', windowlengthnumber, sep='')
windowksecs <- windowsn[wk]

message('****************')
message('****************')
message('****************')
message('****************')
message('*** window:', windowksams)



# general variables for window legnth
wstar=000
wend=wstar+windowlengthnumber
windowlength=wend-wstar
windowframe =wstar:wend
wkdata <- xdata[,.SD[windowframe],by=.(Participant,Activity,Sensor)];





############################
#### (4.2.3) Activities and Axis
##
#



##HORIZONTAL
movementtag <- 'H' 
setkey(wkdata, Activity)
awkdata <- wkdata[.(c('HNnb', 'HFnb','HNwb','HFwb'))]
setkey(awkdata, Sensor)
awkdata <- awkdata[.(c('HS01'))]
### GyroZ -- HORIZONTAL
awkdata <- awkdata[,.(
	sg1zmuvGyroZ
	), by=. (Participant,Activity,Sensor,Sample,Time)]
	#sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ





################# Reorder Factor:
awkdata$Activity <- factor(awkdata$Activity)
awkdata$Activity <- factor(awkdata$Activity, levels= levels (awkdata$Activity)[c(3,4,1,2)] )













###HORIZONTAL and VERTICAL
#movementtag <- 'A' 
#setkey(wkdata, Activity)
#awkdata <- wkdata[.(c('HNnb', 'HFnb','HNwb','HFwb','VNnb', 'VFnb','VNwb','VFwb'))]
#



#HNnb # 1 horizontal_arm_movement_at_normal_speed (no beat)
#HFnb # 3 horizontal_arm_movement_at_faster_speed (no beat)
#HNwb # 5 horizontal_arm_movement_at_normal_speed (with beat)
#HFwb # 7 horizontal_arm_movement_at_faster_speed (with beat)

#VNnb # 2 vertical_arm_movement_at_normal_speed   (no beat)
#VFnb # 4 vertical_arm movement_at_faster_speed   (no beat)
#VNwb # 6 vertical_arm_movement_at_normal_speed   (with beat)
#VFwb # 8 vertical_arm movement_at_faster_speed   (with beat)





#################################################################################
#################################################################################
#################################################################################
#################################################################################
				### (4.2.4) Axis Selection
			
	
		################################################################################
		# (3) Outcomes Plot Path
		if (file.exists(outcomes_plot_path)){
		  setwd(file.path(outcomes_plot_path))
		} else {
		  dir.create(outcomes_plot_path, recursive=TRUE)
		  setwd(file.path(outcomes_plot_path))
		}

	
				axis <- names(awkdata)[6: (  length(awkdata))  ]
				####### Axisk
				for (axis_k in c(1:length(axis)  )){ #for (axis_k in c(1:length(axis))){
				
				
				axisk<- axis[axis_k]
				message('#### axis:' , axisk )
	


	plotlinewidtg <- 1.5
	basefontsize <- 18
	p <- ggplot(awkdata)+ geom_line( aes(x=Time, y=get(axisk), color=Sensor), size=plotlinewidtg )+
   	facet_grid(Participant~Activity)+
   	scale_y_continuous()+

	 geom_vline(xintercept = 2)+
	 geom_vline(xintercept = 4)+
	 geom_vline(xintercept = 7)+
	 geom_vline(xintercept = 12)+
	 geom_vline(xintercept = 17)+


	#geom_segment(aes(x = 100, y = -125, xend = 100, yend = 125)) +
   	#coord_cartesian(xlim=c(wstar,wend), ylim=c(-7,7)) +
   	#coord_cartesian(   ylim=c(-7,7)) +
   	coord_cartesian(   ylim=c(-7,7), x=c(0,60)) +
	theme_bw(base_size=basefontsize)+
	theme(legend.position='none')+
	#labs(y=axisk, x='Sample')
	labs(y=axisk, x='Time (secs)')

	### Save Picture
	width = 1600 #1600 #600
	height = 400 #1600 #800 
	text.factor = 1
	dpi <- text.factor * 100
	width.calc <- width / dpi
	height.calc <- height / dpi

	file_ext <- paste(axisk,'-', windowksams, '-m', movementtag, '.png', sep='')
	ggsave(filename = file_ext,
		dpi = dpi,
		width = width.calc,
		height = height.calc,
		units = 'in',
		bg = "transparent",
		device = "png",
		p,
		limitsize=FALSE
		)







				}##end##for (axis_k in c(1:length(axis)  )){ 
#################################################################################
#################################################################################
#################################################################################
#################################################################################




} ##end## for ( wk in 1:(length(windowsl)) ) { 
################################################################################
################################################################################
################################################################################
################################################################################


#######LABELS
#	plotlinewidtg <- 1.5
#	basefontsize <- 18
#	p <- ggplot(awkdata)+ geom_line( aes(x=Sample,y=get(axisk), color=Sensor), size=plotlinewidtg )+
#   	facet_grid(Participant~Activity)+
#   	scale_y_continuous()+
#	#geom_segment(aes(x = 100, y = -125, xend = 100, yend = 125)) +
#   	coord_cartesian(xlim=c(wstar,wend), ylim=c(-7,7)) +
#	theme_bw(base_size=basefontsize)+
#	#	theme(legend.position='none')+
#	labs(y=axisk, x='Sample')
#
#
#	### Save Picture
#	width = 600
#	height = 800
#	text.factor = 1
#	dpi <- text.factor * 100
#	width.calc <- width / dpi
#	height.calc <- height / dpi
#
#	
#	file_ext <- paste('labels-', windowksams, '-m', movementtag, '.png', sep='')
#	ggsave(filename = file_ext,
#		dpi = dpi,
#		width = width.calc,
#		height = height.calc,
#		units = 'in',
#		bg = "transparent",
#		device = "png",
#		p)
#






#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
# message('Execution Time: ', end.time - start.time)

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
