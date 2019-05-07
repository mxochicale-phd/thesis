#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           hii_BA_creating_TidiedInterpolatedDATA_p01p22.R
# FileDescription:
#
# Variables:
#     participantsNN number
#     aNN: activities
#     sNN: sensors
#
# NOTE: Before running the current script, make sure that you have run:
#           octave --no-gui
#          `/mscripts/hii_rawData_TO_TimeAlignedDataForSeparateActivities_p01_to_p22_octave_linux`


#################
# Start the clock!
start.time <- Sys.time()




#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Defining participants, activities and sensors to read


participantname <- c("p01","p02", "p06", "p07", "p08", "p09", "p10", "p11", "p13","p14","p15","p16","p17","p18","p19", "p21","p22")
participant_number <- c("p01_","p02_", "p06_", "p07_", "p08_", "p09_", "p10_", "p11_", "p13_","p14_","p15_","p16_","p17_","p18_","p19_", "p21_","p22_")
#participant_index <-  c( 3,     5,      7,      9,      11,     13,    15,   17,     19,    21,    23,    25,    27,    29,    31,     33,    35   )
#participant_index <-  c( 2,     3,      4,      5,      6,     7,     8,     9,     10,    11,    12,    13,    14,    15,    16,     17,    18   )
participant_index <-  c( 3,      4,      5,      6,     7,     8,     9,     10,    11,    12,    13,    14,    15,    16,     17,    18,    19  )

activityname <- c("a01","a02","a03","a04", "a05","a06","a07","a08")
activity_number <- c("a01_","a02_","a03_","a04_", "a05_","a06_","a07_","a08_")
aNN <- c(1,2,3,4,5,6,7,8) 

sensorname <- c("s01","s02","s03","s04")
sensor_number <- c("s01_","s02_","s03_","s04_")
sNN <- c(1,2,3,4)




#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(akima) # for interpolation function aspline()
options(digits=15)


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Defining paths for main_path, r_scripts_path, ..., etc.

r_scripts_path <- getwd()

home_path <- Sys.getenv("HOME")
setwd(home_path)

main_data_path=	'/phd/tmp/phdtmpdata/hii_time_aligned_timeseries'
data_path <-  paste(home_path,main_data_path,sep="")

main_outcomes_path = '/phd/tmp/phdtmpdata/outcomes'
outcomes_path <- paste(home_path, main_outcomes_path, sep="")

preProssecedData_path <- paste(outcomes_path,"/preProcessedDataTable_p01_to_p22",sep="")


#feature_path <- "xxxxxxxxxxxxxx"
###
##anthropometric_data_path <- "/anthropometric_data/"
##full_anthropometric_data_path <-  paste(main_path,anthropometric_data_path,sep="")
##full_anthropometric_path_filename <- paste( full_anthropometric_data_path, "data.csv", sep="")
##



#############################################################################
#############################################################################
#############################################################################
#############################################################################
####   Reading RAW Data from Participants
####
#
##+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Setting DataSets paths
setwd(data_path)
data_path_list <- list.dirs(path = ".", full.names = TRUE, recursive = TRUE)


#### UNCOMMENT THE FOLLOWING LINES TO SHOW THE LINES WHEN DATA IS BEING READ
##L76 message('+.........................................................+' )
##L77 message("Loading data from participant ", participant_number[pn_k] )
##L78 message(full_participant_NN_path)
##L88      #message('+ Activity ', aNN_k, ' +')
##L95 message(pNN_aNN_sNN_)
#


#forSTART......... to read data from participants paths
for(pn_k in 1:length(participant_number) )
{
  ######################################################
  # Extracting paths and reading files for the RAZOR sensor
	participant_NN_path <-  substring( (toString(data_path_list[ participant_index[pn_k] ])) , 2, last = 1000000L)
  	full_participant_NN_path <- paste(data_path,participant_NN_path, "/",sep="")
	setwd(full_participant_NN_path)

	message('+.........................................................+' )
	message("Loading data from participant ", participant_number[pn_k] )
	message(full_participant_NN_path)

	details = file.info(list.files(pattern=""))
	details = details[with(details, order(as.POSIXct(mtime))), ]
	files = rownames(details)
	#message(files )


	#forSTART..to extract actitivites
    	for( aNN_k in aNN )
		{
		aNN_files_index = ( ((aNN_k*4)-3) : (aNN_k*4) )# create an index to access files array
		#message('+ Activity ', aNN_k, ' : ', aNN_files_index)

		#forSTART to extract for sensors
		for( sNN_k in sNN)
			{
				
			pNN_aNN_sNN_ <-  paste(files[ aNN_files_index[sNN_k] ], "_", sep="")
			assign (pNN_aNN_sNN_, fread(files[ aNN_files_index[sNN_k] ], header = FALSE, sep=',') )
			message(pNN_aNN_sNN_)

			setnames( get(pNN_aNN_sNN_), c( 
				"Timestamp", "AccX", "AccY", "AccZ", 
						"MagnX","MagnY", "MagnZ",	
						"GyroX", "GyroY", "GyroZ",	
						"qW", "qX", "qY", "qZ"))
			}#forSTART to extract for sensors

		}#forEND..to extract actitivites




}#forEND.........to read data from participants paths











################################################################################
################################################################################
### Interpolating data with aspline(x,y, n= N, method="improved")

### FUNCTON TO DO THE INTERPOLATION
INTERPOLATION <- function(x,y,N){
  i = aspline(x,y, n= N, method="improved")

  # possible methods
  # spline(x, y, n=200)
  # aspline(x, y, n=200, method="improved")

  return(i$y)
}


# Create a data.table object called dataTable
dataTable <- NULL


#forSTART.................... Participants
for(pNN_k in 1:length(participant_number) )
{
######################################################
# Extracting paths and reading files for the RAZOR sensor
#
#message('+.........................................................+' )
#message('Interpolating data for:  ', participant_number[pNN_k] )


pNN_ <- paste(participant_number[pNN_k], sep="")
pNN_tmp <- NULL
aNN_tmp <- NULL ##Initialise data.table object to accumuldate s01 to s04


##################################
#####forSTART.........Activities
    for( aNN_k in aNN )
    {
      aNN_pNN_ <- paste(activity_number[aNN_k],participant_number[pNN_k], sep="")
      aNN_pNN_tmp <- NULL ## initialise the variable that accumulate sensor data per activity
      tmpSensorLength <- NULL ## initialise the tmplenght variable for the sensors
      #message('    ..  ', aNN_pNN_)


            ####
            #### Getting the lenght of each of the sensors
            #### and Setting the second sensor as the main lenght to
            #### interpolate each of the vectors
            ####
            #forSTART.........Sensors
            for( sNN_k in sNN)
		{
		pNN_aNN_sNN_ <- paste(activity_number[aNN_k],sensor_number[sNN_k],participant_number[pNN_k], sep="")
              	#message(pNN_aNN_sNN_);
		tmpsensor <- get(pNN_aNN_sNN_)
		tmpSensorLength <- cbind(tmpSensorLength, dim(tmpsensor)[1])
      		}
		#forEND.........Sensors


            indxSensorLengthOrder <- sort.int(tmpSensorLength,index.return=TRUE)
            ### For which I select the second length as there is a small difference
            ### between the first and the second lenght of the sensors
            InterpolationBasedOnSensorLength <- indxSensorLengthOrder$ix[2]
            ##### show the index of the second miminum length value
            #message(InterpolationBasedOnSensorLength)


            ####################################
            #forSTART.........to extract sensors
            for( sNN_k in sNN)
            {
              	tmpdtSensornew <- NULL
              #message('...Sensor ',  sensor_number[sNN_k] )
              #message('...Sensor Length',  tmpSensorLength[sNN_k] )
              #message('...InterpolationBasedOnSensorLength', tmpSensorLength[InterpolationBasedOnSensorLength])

              	pNN_aNN_sNN_ <- paste(activity_number[aNN_k],sensor_number[sNN_k],participant_number[pNN_k], sep="")
		message('                 : ',pNN_aNN_sNN_)

              tmpSensor <- get(pNN_aNN_sNN_)
              tmpdtSensor <- as.data.table(tmpSensor)

              ### add Sample column as the first column
              tmpdtSensor[,Sample:=seq(.N)]
              setcolorder(tmpdtSensor,c(15,1:14))

                #### Create an interpolated values for each of the vectors
                indx <- c(2:15)
                for(k in indx)
                {
                  tmpdtSensornew <- cbind(
                    tmpdtSensornew,
                    INTERPOLATION(tmpdtSensor[[1]],tmpdtSensor[[k]],tmpSensorLength[InterpolationBasedOnSensorLength])
                    )
                }
                ### convert interpolated data to a data.table object with
                ### their colnames
                tmpdtSensornew <- as.data.table(tmpdtSensornew)
                colnames(tmpdtSensornew) <- colnames(tmpdtSensor)[2:15]
                tmpdtSensornew[,Sample:=seq(.N)]
                setcolorder(tmpdtSensornew,c(15,1:14))


		#### adding sensor tags to each data.table
		sensornamek <- sensorname[sNN_k]
                fsNNtmp <-function(x) { sensornamek }

		tmpdtSensornew[,c("Sensor"):=fsNNtmp(), ]
		setcolorder(tmpdtSensornew,c(16,1:15) )


              #### accumulate sensors_k to aNN_PNN_ data.table
              aNN_pNN_tmp <- rbind(aNN_pNN_tmp,tmpdtSensornew)
              assign(aNN_pNN_,aNN_pNN_tmp )

            }
            #forEND.........to extract sensors
            ##################################




	#### adding activity tags to each data.table
	activitynamek <- activityname[aNN_k]
	faNNtmp <-function(x) { activitynamek }

   	aNN_tmp <- get(aNN_pNN_)
	aNN_tmp[,c("Activity"):=faNNtmp(), ]
	setcolorder(aNN_tmp,c(17,1:16) )
	pNN_tmp <- rbind(pNN_tmp,aNN_tmp) ## accumulate participant_k
	assign(pNN_,pNN_tmp)


}
###########################################
######forEND.........to extract actitivites


### adding activity tags to each data.table
participantnamek <- participantname[pNN_k]
fpNNtmp <-function(x) { participantnamek }

pNN_tmp <- get(pNN_)
pNN_tmp[,c("Participant"):=fpNNtmp(), ]
setcolorder(pNN_tmp,c(18,1:17) )

dataTable <- rbind(dataTable,pNN_tmp) ## accumulate participant_k


}#forEND.........to read data from participants paths











################################################################################
################################################################################
# Creating Preprossede Data Path
if (file.exists(preProssecedData_path)){
  setwd(file.path(preProssecedData_path))
} else {
  dir.create(preProssecedData_path, recursive=TRUE)
  setwd(file.path(preProssecedData_path))
}


## ################################################################################
## ################################################################################
## ####   Testing Data By Plotting
## library(ggplot2)
## Plot <- ggplot(dataTable)+
##   geom_line( aes(x=Sample,y=AccX, color=Sensor))+
##   # geom_line( aes(x=Sample,y=AccY, color=Sensor))+
##   # geom_line( aes(x=Sample,y=AccZ, color=Sensor))+
##   facet_grid(Participant~Activity)+
##   scale_y_continuous()+
##   # coord_cartesian(xlim=c(0,2000), ylim=c(-1500,1500))
##   coord_cartesian(xlim=NULL, ylim=c(-1500,1500))
##   # coord_cartesian(xlim=NULL, ylim=NULL)
##
## plot(Plot)
##
## ## In case you want to save the image
## # tiff(filename="ts_AccX_p01p22.tiff",
## #   width=2000, height=5000, units="px", res=200, bg="white")
## # Plot
## # dev.off()
#

################################################################################
################################################################################
####    Writing Data
write.table(dataTable, "hii-TidiedInterpolatedData.datatable", row.name=FALSE)

message(' hii-TidiedInterpolatedData.datatable ', 'has been created at '  )
message (preProssecedData_path)



#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
# message('Execution Time: ', end.time - start.time)


############################################
setwd(r_scripts_path) ## go back to the r-script source path
