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
	# (2) Reading raw tidied interpolated data
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
homepath <- Sys.getenv("HOME")
r_scripts_path <- getwd()

setwd("../../../../")
github_repo_path <- getwd()

libfun_path <- '/0_code_data/1_code/2_libraries_functions'
rfunctions_ollin_cencah_R <- '/rfunctions/ollin_cencah.R'

#/home/map479/phd/phd-thesis/0_code_data/0_data/0_raw-timeseries/hii 

#
###VERSION 
#version <- '00'
#feature_path <- '/dataset/hii'
#


### Outcomes Data Path
outcomes_data_path <- paste(github_repo_path,'/0_code_data/0_data/1_datasets/hii/dataset', sep="")

#### Raw Data Path
rawdata_path <- paste(github_repo_path,'/0_code_data/0_data/0_raw-timeseries/hii',sep='')
setwd(file.path(rawdata_path))



#################################################################################
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

# all sensors
xdataHS0102 <- merge(xdataHS01, xdataHS02, all=TRUE)
xdataHS0304 <- merge(xdataHS03, xdataHS04, all=TRUE)
xdata <- merge(xdataHS0102, xdataHS0304, all=TRUE)





#### HS01 and HS02 sensors
#xdata <- merge(xdataHS01, xdataHS02, all=TRUE)
#

#### HS03 and HS04 sensors
#xdata <- merge(xdataHS03, xdataHS04, all=TRUE)
#




###############################################################################
### (4.1) Selecting Participants
setkey(xdata, Participant)

### One Participants
#xdata <- xdata[.(c('p01'))]
#
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

###############################################################################
# Seventeenth Participants
xdata <- xdata[.(c(
		'p01','p02', 'p03', 'p04', 'p05', 'p06','p07','p08', 'p09', 'p10',
		'p11','p12', 'p13', 'p14', 'p15', 'p16','p17'
		))]





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

#
####HORIZONTAL#	sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
#xpa <- xdata[,.(
#	sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
#	), by=. (Participant,Activity,Sensor,Sample)]
#
#
#
####VERTICAL#	sg0zmuvGyroY, sg1zmuvGyroY, sg2zmuvGyroY
#xpa <- xdata[,.(
#	sg0zmuvGyroY, sg1zmuvGyroY, sg2zmuvGyroY
#	), by=. (Participant,Activity,Sensor,Sample)]
#


#### GyroY -- VERTICAL
#### GyroZ -- HORIZONTAL
#xpa <- xdata[,.(
#	sg0zmuvGyroY, sg1zmuvGyroY, sg2zmuvGyroY,
#	sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
#	), by=. (Participant,Activity,Sensor,Sample)]
#



### ALL
xpa <- xdata[,.(
	sg0zmuvGyroX, sg1zmuvGyroX, sg2zmuvGyroX,
	sg0zmuvGyroY, sg1zmuvGyroY, sg2zmuvGyroY,
	sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
	), by=. (Participant,Activity,Sensor,Sample)]



################################################################################
# (7) Creating Preprossed Data Path
if (file.exists(outcomes_data_path)){
  setwd(file.path(outcomes_data_path))
} else {
  dir.create(outcomes_data_path, recursive=TRUE)
  setwd(file.path(outcomes_data_path))
}



################################################################################
# (7.1) SHIFTING TIME SERIES BY PARTITICPANTS AND ACTIVITY for HORIZONTAL AND VERTICAL
#
##############################
##############################
##############################
###  ALL DATA 


##############################
##############################
##############################
##############################
## HORIZONTAL


shiftHNnb<-230
shiftHNwb<-200
shiftHFnb<-140
shiftHFwb<-180

# p01 H GyroX
xpa[Participant=='p01' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


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





shiftHNnb<-200
shiftHNwb<-450
shiftHFnb<-400
shiftHFwb<-170

# p02 H GyroX
xpa[Participant=='p02' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


# p02 H GyroY
xpa[Participant=='p02' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



# p02 H GyroZ
xpa[Participant=='p02' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ] 



shiftHNnb<-400
shiftHNwb<-350
shiftHFnb<-050
shiftHFwb<-300

# p03 H GyroX
xpa[Participant=='p03' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


# p03 H GyroY
xpa[Participant=='p03' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



# p03 H GyroZ
xpa[Participant=='p03' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ]
 





shiftHNnb<-200
shiftHNwb<-800
shiftHFnb<-150
shiftHFwb<-300

## p04 H GyroX
xpa[Participant=='p04' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p04 H GyroY
xpa[Participant=='p04' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p04 H GyroZ
xpa[Participant=='p04' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ] 




shiftHNnb<-200
shiftHNwb<-400
shiftHFnb<-200
shiftHFwb<-200

## p05 H GyroX
xpa[Participant=='p05' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p05 H GyroY
xpa[Participant=='p05' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p05 H GyroZ
xpa[Participant=='p05' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ] 



shiftHNnb<-100
shiftHNwb<-400
shiftHFnb<-000
shiftHFwb<-600

## p06 H GyroX
xpa[Participant=='p06' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p06 H GyroY
xpa[Participant=='p06' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p06 H GyroZ
xpa[Participant=='p06' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ]
 




shiftHNnb<-200
shiftHNwb<-200
shiftHFnb<-000
shiftHFwb<-600

## p07 H GyroX
xpa[Participant=='p07' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p07 H GyroY
xpa[Participant=='p07' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p07 H GyroZ
xpa[Participant=='p07' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ] 





shiftHNnb<-100
shiftHNwb<-800
shiftHFnb<-200
shiftHFwb<-200

## p08 H GyroX
xpa[Participant=='p08' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p08 H GyroY
xpa[Participant=='p08' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p08 H GyroZ
xpa[Participant=='p08' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ] 



shiftHNnb<-200
shiftHNwb<-200
shiftHFnb<-400
shiftHFwb<-200

## p09 H GyroX
xpa[Participant=='p09' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p09 H GyroY
xpa[Participant=='p09' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p09 H GyroZ
xpa[Participant=='p09' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ]
 




shiftHNnb<-150
shiftHNwb<-400
shiftHFnb<-100
shiftHFwb<-000

## p10 H GyroX
xpa[Participant=='p10' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p10 H GyroY
xpa[Participant=='p10' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p10 H GyroZ
xpa[Participant=='p10' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ] 





shiftHNnb<-200
shiftHNwb<-600
shiftHFnb<-100
shiftHFwb<-100

## p11 H GyroX
xpa[Participant=='p11' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p11 H GyroY
xpa[Participant=='p11' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p11 H GyroZ
xpa[Participant=='p11' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ] 



shiftHNnb<-350
shiftHNwb<-100
shiftHFnb<-050
shiftHFwb<-050

## p12 H GyroX
xpa[Participant=='p12' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p12 H GyroY
xpa[Participant=='p12' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p12 H GyroZ
xpa[Participant=='p12' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ]
 



shiftHNnb<-100
shiftHNwb<-100
shiftHFnb<-050
shiftHFwb<-100

## p13 H GyroX
xpa[Participant=='p13' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p13 H GyroY
xpa[Participant=='p13' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p13 H GyroZ
xpa[Participant=='p13' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ] 





shiftHNnb<-050
shiftHNwb<-050
shiftHFnb<-200
shiftHFwb<-100

## p14 H GyroX
xpa[Participant=='p14' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p14 H GyroY
xpa[Participant=='p14' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p14 H GyroZ
xpa[Participant=='p14' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ] 



shiftHNnb<-400
shiftHNwb<-400
shiftHFnb<-200
shiftHFwb<-200

## p15 H GyroX
xpa[Participant=='p15' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p15 H GyroY
xpa[Participant=='p15' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p15 H GyroZ
xpa[Participant=='p15' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ]
 




shiftHNnb<-200
shiftHNwb<-400
shiftHFnb<-200
shiftHFwb<-200

## p16 H GyroX
xpa[Participant=='p16' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p16 H GyroY
xpa[Participant=='p16' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p16 H GyroZ
xpa[Participant=='p16' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ] 





shiftHNnb<-350
shiftHNwb<-200
shiftHFnb<-200
shiftHFwb<-200

## p17 H GyroX
xpa[Participant=='p17' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='HNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNwb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='HFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFnb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='HFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHFwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHFwb, type='lead'), ] 


## p17 H GyroY
xpa[Participant=='p17' & Activity=='HNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNnb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='HNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHNwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHNwb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='HFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFnb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='HFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftHFwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftHFwb, type='lead'), ] 



## p17 H GyroZ
xpa[Participant=='p17' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNnb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='HNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHNwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHNwb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='HFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFnb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='HFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftHFwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='HFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftHFwb, type='lead'), ] 






###############################
###############################
###############################
###############################
### VERTICAL

shiftVNnb<-150
shiftVNwb<-150
shiftVFnb<-075
shiftVFwb<-000

# p01 V GyroX
xpa[Participant=='p01' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p01' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


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





shiftVNnb<-200
shiftVNwb<-250
shiftVFnb<-100
shiftVFwb<-250

# p02 V GyroX
xpa[Participant=='p02' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p02 H GyroY
xpa[Participant=='p02' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p02 H GyroZ
xpa[Participant=='p02' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p02' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p02' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 




shiftVNnb<-200
shiftVNwb<-600
shiftVFnb<-150
shiftVFwb<-150

# p03 H GyroX
xpa[Participant=='p03' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p03 H GyroY
xpa[Participant=='p03' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p03 H GyroZ
xpa[Participant=='p03' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p03' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p03' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 




shiftVNnb<-150
shiftVNwb<-125
shiftVFnb<-200
shiftVFwb<-250

# p04 H GyroX
xpa[Participant=='p04' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p04 H GyroY
xpa[Participant=='p04' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p04 H GyroZ
xpa[Participant=='p04' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p04' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p04' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 





shiftVNnb<-300
shiftVNwb<-400
shiftVFnb<-025
shiftVFwb<-100

# p05 H GyroX
xpa[Participant=='p05' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p05 H GyroY
xpa[Participant=='p05' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p05 H GyroZ
xpa[Participant=='p05' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p05' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p05' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 




shiftVNnb<-000
shiftVNwb<-200
shiftVFnb<-000
shiftVFwb<-700

# p06 H GyroX
xpa[Participant=='p06' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p06 H GyroY
xpa[Participant=='p06' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p06 H GyroZ
xpa[Participant=='p06' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p06' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p06' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 





shiftVNnb<-100
shiftVNwb<-300
shiftVFnb<-000
shiftVFwb<-300

# p07 H GyroX
xpa[Participant=='p07' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p07 H GyroY
xpa[Participant=='p07' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p07 H GyroZ
xpa[Participant=='p07' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p07' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p07' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 





shiftVNnb<-000
shiftVNwb<-300
shiftVFnb<-000
shiftVFwb<-300

# p08 H GyroX
xpa[Participant=='p08' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p08 H GyroY
xpa[Participant=='p08' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p08 H GyroZ
xpa[Participant=='p08' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p08' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p08' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 




shiftVNnb<-300
shiftVNwb<-400
shiftVFnb<-400
shiftVFwb<-100

# p09 H GyroX
xpa[Participant=='p09' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p09 H GyroY
xpa[Participant=='p09' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p09 H GyroZ
xpa[Participant=='p09' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p09' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p09' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 






shiftVNnb<-200
shiftVNwb<-100
shiftVFnb<-050
shiftVFwb<-200

# p10 H GyroX
xpa[Participant=='p10' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p10 H GyroY
xpa[Participant=='p10' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p10 H GyroZ
xpa[Participant=='p10' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p10' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p10' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 





shiftVNnb<-000
shiftVNwb<-800
shiftVFnb<-100
shiftVFwb<-100

# p11 H GyroX
xpa[Participant=='p11' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p11 H GyroY
xpa[Participant=='p11' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p11 H GyroZ
xpa[Participant=='p11' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p11' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p11' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 




shiftVNnb<-300
shiftVNwb<-200
shiftVFnb<-075
shiftVFwb<-100

# p12 H GyroX
xpa[Participant=='p12' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p12 H GyroY
xpa[Participant=='p12' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p12 H GyroZ
xpa[Participant=='p12' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p12' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p12' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 





shiftVNnb<-075
shiftVNwb<-100
shiftVFnb<-000
shiftVFwb<-175

# p13 H GyroX
xpa[Participant=='p13' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p13 H GyroY
xpa[Participant=='p13' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p13 H GyroZ
xpa[Participant=='p13' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p13' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p13' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 





shiftVNnb<-100
shiftVNwb<-150
shiftVFnb<-100
shiftVFwb<-300

# p14 H GyroX
xpa[Participant=='p14' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p14 H GyroY
xpa[Participant=='p14' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p14 H GyroZ
xpa[Participant=='p14' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p14' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p14' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 




shiftVNnb<-300
shiftVNwb<-200
shiftVFnb<-100
shiftVFwb<-100

# p15 H GyroX
xpa[Participant=='p15' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p15 H GyroY
xpa[Participant=='p15' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p15 H GyroZ
xpa[Participant=='p15' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p15' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p15' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 



shiftVNnb<-200
shiftVNwb<-200
shiftVFnb<-300
shiftVFwb<-200

# p16 H GyroX
xpa[Participant=='p16' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p16 H GyroY
xpa[Participant=='p16' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p16 H GyroZ
xpa[Participant=='p16' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p16' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p16' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 





shiftVNnb<-200
shiftVNwb<-150
shiftVFnb<-200
shiftVFwb<-250

# p17 H GyroX
xpa[Participant=='p17' & Activity=='VNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNnb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='VNwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VNwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVNwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VNwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVNwb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='VFnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VFnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VFnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFnb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='VFwb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VFwb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftVFwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VFwb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftVFwb, type='lead'), ] 


# p17 H GyroY
xpa[Participant=='p17' & Activity=='VNnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VNnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VNnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNnb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='VNwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VNwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVNwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VNwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVNwb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='VFnb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VFnb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VFnb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFnb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='VFwb', sg0zmuvGyroY:=shift(sg0zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VFwb', sg1zmuvGyroY:=shift(sg1zmuvGyroY, shiftVFwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VFwb', sg2zmuvGyroY:=shift(sg2zmuvGyroY, shiftVFwb, type='lead'), ] 



# p17 H GyroZ
xpa[Participant=='p17' & Activity=='VNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VNnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VNnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNnb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='VNwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VNwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVNwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VNwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVNwb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='VFnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VFnb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFnb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VFnb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFnb, type='lead'), ] 

xpa[Participant=='p17' & Activity=='VFwb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VFwb', sg1zmuvGyroZ:=shift(sg1zmuvGyroZ, shiftVFwb, type='lead'), ] 
xpa[Participant=='p17' & Activity=='VFwb', sg2zmuvGyroZ:=shift(sg2zmuvGyroZ, shiftVFwb, type='lead'), ] 









################################################################################
####  (8)  Writing Data

file_ext <- paste('xdata_all', '.dt',sep='')
write.table(xpa, file_ext, row.name=FALSE)





#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
# message('Execution Time: ', end.time - start.time)

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
