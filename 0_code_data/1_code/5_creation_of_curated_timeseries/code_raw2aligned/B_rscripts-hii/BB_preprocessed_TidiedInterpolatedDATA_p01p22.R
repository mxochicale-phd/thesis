###############################################################################	
#
# Create TidiedInterpolatedTHENpreprocessedData-v03.datatable
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


main_data_path <- '/0_code_data/0_data/0_raw-timeseries/hii'
outcomes_data_path <- paste(github_repository_path, main_data_path, sep="")
tidinterdata <- '/phd/tmp/phdtmpdata/outcomes/preProcessedDataTable_p01_to_p22'
preprossededata_path <- paste(home_path, tidinterdata, sep="")
setwd(file.path(preprossededata_path))


################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data

################################################################################
# (2) Reading raw tidied  interpolated data
data <- fread("hii-TidiedInterpolatedData.datatable", header=TRUE)


################################################################################
# (3) Filtering out variables from the data.table
xdata <- data

### Renaming Activity Variables
xdata$Activity <- gsub('a01', 'HNnb', xdata$Activity) # 1 horizontal_arm_movement_at_normal_speed (no beat)
xdata$Activity <- gsub('a02', 'VNnb', xdata$Activity) # 2 vertical_arm_movement_at_normal_speed   (no beat)
xdata$Activity <- gsub('a03', 'HFnb', xdata$Activity) # 3 horizontal_arm_movement_at_faster_speed (no beat)
xdata$Activity <- gsub('a04', 'VFnb', xdata$Activity) # 4 vertical_arm movement_at_faster_speed   (no beat)
xdata$Activity <- gsub('a05', 'HNwb', xdata$Activity) # 5 horizontal_arm_movement_at_normal_speed (with beat)
xdata$Activity <- gsub('a06', 'VNwb', xdata$Activity) # 6 vertical_arm_movement_at_normal_speed   (with beat)
xdata$Activity <- gsub('a07', 'HFwb', xdata$Activity) # 7 horizontal_arm_movement_at_faster_speed (with beat)
xdata$Activity <- gsub('a08', 'VFwb', xdata$Activity) # 8 vertical_arm movement_at_faster_speed   (with beat)



### Renaming Sensor Variables
xdata$Sensor <- gsub('s01', 'HS01', xdata$Sensor)
xdata$Sensor <- gsub('s02', 'HS02', xdata$Sensor)
xdata$Sensor <- gsub('s03', 'HS03', xdata$Sensor)
xdata$Sensor <- gsub('s04', 'HS04', xdata$Sensor)


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
##  Participants

selectedparticipants <- c(	
			"p01", "p02", "p06", "p07", "p08", 
			"p09", "p10", "p11", "p13", "p14",
			"p15", "p16", "p17", "p18", "p19", 
			"p21","p22")

xdata <- xdata[.(  selectedparticipants )]


## Renaming Participant Names  p14p22 to p13p20 [http://stackoverflow.com/questions/24536771/]
xdata[, Participant := as.character(Participant)][Participant == 'p01', Participant := 'p01']
xdata[, Participant := as.character(Participant)][Participant == 'p02', Participant := 'p02']
xdata[, Participant := as.character(Participant)][Participant == 'p06', Participant := 'p03']
xdata[, Participant := as.character(Participant)][Participant == 'p07', Participant := 'p04']
xdata[, Participant := as.character(Participant)][Participant == 'p08', Participant := 'p05']
xdata[, Participant := as.character(Participant)][Participant == 'p09', Participant := 'p06']
xdata[, Participant := as.character(Participant)][Participant == 'p10', Participant := 'p07']
xdata[, Participant := as.character(Participant)][Participant == 'p11', Participant := 'p08']
xdata[, Participant := as.character(Participant)][Participant == 'p13', Participant := 'p09']
xdata[, Participant := as.character(Participant)][Participant == 'p14', Participant := 'p10']
xdata[, Participant := as.character(Participant)][Participant == 'p15', Participant := 'p11']
xdata[, Participant := as.character(Participant)][Participant == 'p16', Participant := 'p12']
xdata[, Participant := as.character(Participant)][Participant == 'p17', Participant := 'p13']
xdata[, Participant := as.character(Participant)][Participant == 'p18', Participant := 'p14']
xdata[, Participant := as.character(Participant)][Participant == 'p19', Participant := 'p15']
xdata[, Participant := as.character(Participant)][Participant == 'p21', Participant := 'p16']
xdata[, Participant := as.character(Participant)][Participant == 'p22', Participant := 'p17']





################################################################################
# (4) Creating and Changing to Preprosseced Data Path
if (file.exists(outcomes_data_path)){
  setwd(file.path(outcomes_data_path))
} else {
  dir.create(outcomes_data_path, recursive=TRUE)
  setwd(file.path(outcomes_data_path))
}



###############################################################################
## (3.5) Adding/Deleting postprocessing vectors

###  Deleting some Magnetomer and quaternion data
xdata <- xdata[, !c('Timestamp', 'MagnX', 'MagnY', 'MagnZ', 'qW', 'qX', 'qY', 'qZ') , with=FALSE]

setkey(xdata, Sensor)



##### HS01
#xdata <- xdata[.(c('HS01'))]
#write.table(xdata, "hii-HS01-TidiedInterpolatedRawData.dt", row.name=FALSE)
#

##### HS02
#xdata <- xdata[.(c('HS02'))]
#write.table(xdata, "hii-HS02-TidiedInterpolatedRawData.dt", row.name=FALSE)


##### HS03
#xdata <- xdata[.(c('HS03'))]
#write.table(xdata, "hii-HS03-TidiedInterpolatedRawData.dt", row.name=FALSE)

##### HS04
xdata <- xdata[.(c('HS04'))]
write.table(xdata, "hii-HS04-TidiedInterpolatedRawData.dt", row.name=FALSE)




#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
# message('Execution Time: ', end.time - start.time)

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
