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
setwd("../../../../../")
github_repo_path <- getwd()

libfun_path <- '/0_code_data/1_code/2_libraries_functions'
rfunctions_ollin_cencah_R <- '/rfunctions/ollin_cencah.R'



### Outcomes Data Path
outcomes_data_path <- paste(github_repo_path,'/0_code_data/0_data/1_datasets/hri/dataset', sep="")

#### Raw Data Path
rawdata_path <- paste(github_repo_path,'/0_code_data/0_data/0_raw-timeseries/hri',sep='')
setwd(file.path(rawdata_path))


#################################################################################
## (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(signal)# for butterworth filter and sgolay
source(paste(github_repo_path, libfun_path, rfunctions_ollin_cencah_R, sep='')) # Calling `functions_ollin_cencah` 


################################################################################
# (2) Reading raw tidied  interpolated data
xdata <- fread("hri-TidiedInterpolatedRawData.dt", header=TRUE)
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
#xdata <- xdata[.(c('p01'))]
#
### Two Participants
#xdata <- xdata[.(c('p01','p02'))]

### Three Participant
#xdata <- xdata[.(c('p01', 'p02', 'p03'))]

# ################################################################################
# ## Six Participants
# xdata <- xdata[.(c('p01','p02', 'p03', 'p04', 'p05', 'p06'
#                    ))]

################################################################################
## Twelve Participants
# xdata <- xdata[.(c('p01','p02', 'p03', 'p04', 'p05', 'p06','p07','p08', 'p09', 'p10', 'p11', 'p12'))]



###############################################################################
## Twenty Participants
xdata <- xdata[.(c('p01','p02', 'p03', 'p04', 'p05', 'p06','p07','p08', 'p09', 'p10',
                    'p11','p12', 'p13', 'p14', 'p15', 'p16','p17','p18', 'p19', 'p20'
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



#################################################################################
## (6) Selecting Axis after postprocessing 
#


####HORIZONTAL/VERTICAL

xpa <- xdata[,.(
	sg0zmuvGyroY, sg1zmuvGyroY, sg2zmuvGyroY,
	sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
	), by=. (Participant,Activity,Sensor,Sample,Time)]




################################################################################
# (7) Creating Preprossed Data Path
if (file.exists(outcomes_data_path)){
  setwd(file.path(outcomes_data_path))
} else {
  dir.create(outcomes_data_path, recursive=TRUE)
  setwd(file.path(outcomes_data_path))
}



################################################################################
####  (8)  Writing Data
file_ext <- paste('xdata', '.dt',sep='')
write.table(xpa, file_ext, row.name=FALSE)




#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
# message('Execution Time: ', end.time - start.time)

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
