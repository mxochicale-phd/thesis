###############################################################################	
#
# Create TidiedInterpolatedTHENpreprocessedData-v06.datatable
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
	# (3) Filtering out variables from the data.table
		### (3.1) Selecting Participants
		### (3.5) Adding/Deleting postprocessing vectors
	# (4) Creating and Changing to Preprosseced Data Path
	# (5) Writing Data



#################
# Start the clock!
start.time <- Sys.time()



################################################################################
# (0) Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()

setwd("../../../../../")
github_repository_path <- getwd()

home_path <- Sys.getenv("HOME")
setwd(home_path)

main_data_path <- '/0_code_data/0_data/0_raw-timeseries/hri'
outcomes_data_path <- paste(github_repository_path, main_data_path, sep="")
tidinterdata <- '/phd/tmp/phdtmpdata/outcomes/preProcessedDataTable_p01_to_p22'
preprossededata_path <- paste(home_path, tidinterdata, sep="")
setwd(file.path(preprossededata_path))


################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data

################################################################################
# (2) Reading raw tidied  interpolated data
data <- fread("hri-TidiedInterpolatedData.datatable", header=TRUE)

################################################################################
# (3) Filtering out variables from the data.table
xdata <- data

### Renaming Activity Variables
xdata$Activity <- gsub('a01', 'HN', xdata$Activity)
xdata$Activity <- gsub('a02', 'VN', xdata$Activity)
xdata$Activity <- gsub('a03', 'HF', xdata$Activity)
xdata$Activity <- gsub('a04', 'VF', xdata$Activity)

## Renaming Sensor Variables
xdata$Sensor <- gsub('s01', 'HS01', xdata$Sensor)
xdata$Sensor <- gsub('s02', 'HS02', xdata$Sensor)
xdata$Sensor <- gsub('s03', 'RS01', xdata$Sensor)
xdata$Sensor <- gsub('s04', 'RS02', xdata$Sensor)


################################################################################
### (3.1) Selecting Participants
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
xdata <- xdata[.(c('p01','p02', 'p03', 'p04', 'p05', 'p06', 'p07', 'p08', 'p09', 'p10',
                   'p11','p12', 'p14', 'p15', 'p17', 'p18', 'p19', 'p20', 'p21', 'p22'
                   ))]
## Renaming Participant Names  p14p22 to p13p20 [http://stackoverflow.com/questions/24536771/]
xdata[, Participant := as.character(Participant)][Participant == 'p14', Participant := 'p13']
xdata[, Participant := as.character(Participant)][Participant == 'p15', Participant := 'p14']
xdata[, Participant := as.character(Participant)][Participant == 'p17', Participant := 'p15']
xdata[, Participant := as.character(Participant)][Participant == 'p18', Participant := 'p16']
xdata[, Participant := as.character(Participant)][Participant == 'p19', Participant := 'p17']
xdata[, Participant := as.character(Participant)][Participant == 'p20', Participant := 'p18']
xdata[, Participant := as.character(Participant)][Participant == 'p21', Participant := 'p19']
xdata[, Participant := as.character(Participant)][Participant == 'p22', Participant := 'p20']


################################################################################
## Twentytwo Participants
# xdata <- xdata[.(c('p01','p02', 'p03', 'p04', 'p05', 'p06','p07','p08', 'p09', 'p10',
#                    'p11','p12', 'p13', 'p14', 'p15', 'p16','p17','p18', 'p19', 'p20',
#                    'p21', 'p22'))]



################################################################################
### (3.5) Adding/Deleting postprocessing vectors

###  Deleting some Magnetomer and quaternion data
xdata <- xdata[, !c('Timestamp', 'MagnX', 'MagnY', 'MagnZ', 'qW', 'qX', 'qY', 'qZ') , with=FALSE]

setkey(xdata, Sensor)
xdata <- xdata[.(c('HS01','RS01'))]

################################################################################
# (4) Creating and Changing to Preprosseced Data Path
if (file.exists(outcomes_data_path)){
  setwd(file.path(outcomes_data_path))
} else {
  dir.create(outcomes_data_path, recursive=TRUE)
  setwd(file.path(outcomes_data_path))
}


################################################################################
####  (5)  Writing Data
write.table(xdata, "hri-TidiedInterpolatedRawData.dt", row.name=FALSE)

#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
# message('Execution Time: ', end.time - start.time)

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
