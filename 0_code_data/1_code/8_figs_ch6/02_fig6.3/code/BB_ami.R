###############################################################################	
#
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
	
	# (4) Filtering data.table variables
		# (4.1) Windowing data
		# (4.2) Filtering variables
			# (4.2.1) Sensor Selection
			# (4.2.2) Activities Selection
			# (4.2.3) Participant Selection
			# (4.2.4) Axis Selection

	# (5) Average Mutual Information 
		# (5.1) Plot Avarage Mutual Information 
		# (5.2) Creating and Changing to Preprosseced Data Path



#################
# Start the clock!
start.time <- Sys.time()




################################################################################
# (0) Defining paths for main_path, r_scripts_path, ..., etc.


r_scripts_path <- getwd()
setwd("../../../../../")
github_repo_path <- getwd()
libfun_path <- '/0_code_data/1_code/2_libraries_functions'



#### Data Path
data_path <- data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hri/dataset', sep="")
setwd(file.path(data_path))
#### Outcomes Data Path
outcomes_data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hri/utde', sep="")




#################################################################################
## (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data

library(devtools)
load_all(paste(github_repo_path, libfun_path, '/nonlinearTseries', sep=""))

################################################################################
# (2) Reading data
file_ext <- paste('xdata', '.dt',sep='')
data <- fread( file_ext, header=TRUE)


################################################################################
# (4) Filtering out variables in xdata data.table
xdata <- data


################################################################################
### (4.1) Windowing Data [xdata[,.SD[1:2],by=.(Participant,Activity,Sensor)]]

######################################
## w2, 2-second window (100 samples) ## 100 to 200
#wstar=100
#windowlengthnumber=100
#windowltag <- 'w2'
#
#####################################
## w5, 5-second window (250 samples) # 100 to 350
#wstar=100
#windowlengthnumber=250
#windowltag <- 'w5'
#
#####################################
## w10, 10-second window (500 samples) ## 100 to 600
wstar=100
windowlengthnumber=500
windowltag <- 'w10'

######################################
## w15, 15-second window (750 samples) ## 100 to 850
#wstar=100
#windowlengthnumber=750
#windowltag <- 'w15'
#




wend=wstar+windowlengthnumber
windowlength=wend-wstar
windowframe =wstar:wend
xdata <- xdata[,.SD[windowframe],by=.(Participant,Activity,Sensor)];





###############################################################################
#### (4.2) Filtering variables in data table


##########################
## (4.2.1) Activities Selection
#movementtag <- 'H' 

#movement_variables <- c('HN','HF')
movement_variables <- c('HN', 'HF', 'VN', 'VF')

AMIS <- NULL
TIMEDELAYS <- NULL

#########################################################
for (movement_k in 1:length(movement_variables) ) {

movement_variable <- movement_variables[movement_k]
message(movement_variable)

xdatam <- xdata

if (movement_variable == 'HN' ) {
###>>>>>> HORIZONTAL <<<<<<<
movement <- '-horizontal-movements-' 
setkey(xdatam, Activity)
xdatam <- xdatam[.(c('HN'))]

} else if (movement_variable == 'HF' ) {
###>>>>>> HORIZONTAL <<<<<<<
	movement <- '-horizontal-movements-' 
setkey(xdatam, Activity)
xdatam <- xdatam[.(c('HF'))]

} else if (movement_variable == 'VN') {
###>>>>>> VERTICAL <<<<<<<
movement <- '-vertical-movements-' 
setkey(xdatam, Activity)
xdatam <- xdatam[.(c('VN'))]

} else if (movement_variable == 'VF') {
###>>>>>> VERTICAL <<<<<<<
movement <- '-vertical-movements-' 
setkey(xdatam, Activity)
xdatam <- xdatam[.(c('VF'))]

} else {
message('no valid movement_variable')
}









#################################
#### (4.2.2) Sensor Selection
setkey(xdatam, Sensor)
#xdata <- xdata[.(c(   'RS01'   ))] # RobotSensor01
xdatam <- xdatam[.(c('RS01', 'HS01'))] # RobotSensor01  and HumanSensor01


###############################
## (4.2.3) Participants Selection
#number_of_participants <- 3
#number_of_participants <- 5
#number_of_participants <- 6
#number_of_participants <- 10
#number_of_participants <- 12
number_of_participants <- 20


if (number_of_participants == 3) {
setkey(xdatam, Participant)
pNN <- c('p01', 'p02', 'p03')
xdatap <- xdatam[.(
		pNN
		)]

} else if (number_of_participants == 5) {
setkey(xdatam, Participant)
pNN <- c('p01', 'p02', 'p03', 'p04', 'p05')
xdatap <- xdatam[.(	
		pNN
		)]


} else if (number_of_participants == 6) {
setkey(xdatam, Participant)
pNN <- c('p01', 'p02', 'p03', 'p04', 'p05', 'p06')
xdatap <- xdatam[.(	
		pNN
		)]


} else if  (number_of_participants == 10) {
setkey(xdatam, Participant)
pNN <- c('p01', 'p02', 'p03', 'p04', 'p05', 'p06', 'p07', 'p08', 'p09', 'p10')
xdatap <- xdatam[.(
		pNN
		)]


} else if  (number_of_participants == 12) {
setkey(xdatam, Participant)
pNN <- c('p01', 'p02', 'p03', 'p04', 'p05', 'p06', 'p07', 'p08', 'p09', 'p10','p11', 'p12')
xdatap <- xdatam[.(
		pNN
		)]

} else if  (number_of_participants == 20) {
setkey(xdatam, Participant)
pNN <- 		c(	'p01', 'p02', 'p03', 'p04', 'p05', 'p06', 'p07', 'p08', 'p09', 'p10',
			'p11', 'p12', 'p13', 'p14', 'p15', 'p16', 'p17', 'p18', 'p19', 'p20')	
xdatap <- xdatam[.(
		pNN
		)]

} else {
message('not a valid number_of_participants')
}






###############################
## (4.2.4) Axis Selection

axis <- names(xdatap)[6: (  length(xdatap))  ]
xpa <- xdatap







##############################################################################
##############################################################################
###############################################################################
# (5) Average Mutual Information
maxtau <- 100
number_of_partitions <- 100

#Method used for selecting a concrete time lag. 
#Available methods are "first.zero", "first.e.decay" (default), 
#"first.minimum" and "first.value".
ami_timelag_selection_method <- 'first.minimum'
#ami_timelag_selection_method <- 'first.value' 

##Numeric value indicating the value that the autocorrelation/AMI function 
#must cross in order to select the time lag. 
#It is used only with the "first.value" selection method.
ami_numeric_value <- 1/exp(0)

AMI <- NULL
time_lags <- NULL

for (participants_k in c(1:number_of_participants)) { ##for (participants_k in c(1:number_of_participants)) { 
message('####################')
message('# PARTICIPANT: ', participants_k)
setkey(xpa, Participant)
xpak <- xpa[.( pNN[participants_k] )]


#### Sensors
hs01xpak <- xpak[Sensor=='HS01', .SDcols=cols  ]
rs01xpak <- xpak[Sensor=='RS01', .SDcols=cols  ]

###### Axis
time_lags_p <- NULL
amip<-NULL
for (axis_k in c(1:length(axis)  )){ #for (axis_k in c(1:length(axis))){
	message('#### axis:' , axis[axis_k])

	########################
	message('     #HS01')
	inputtimeseries <- hs01xpak[,  get(axis[axis_k]) ]

	## tau-delay estimation based on the mutual information function
	tau.ami <- timeLag(time.series = inputtimeseries, technique = "ami",
                selection.method = ami_timelag_selection_method, value = ami_numeric_value,
		lag.max = maxtau,
                do.plot = F, n.partitions = number_of_partitions,
                units = "Bits")


	tauamilag_hs01 <- as.data.table(tau.ami[[1]])
	ami <- tau.ami[[2]]

	amidt <- as.data.table(ami)
	amidt[, tau := 0:(.N-1), ]
	
	ftag <-function(x) {list("HS01")}
	amidt[,c("sensor"):=ftag(), ]
	amihs01 <- amidt

	tauamilag_hs01[,c("sensor"):=ftag(), ]
	


	########################
	message('     #RS01')
	inputtimeseries <- rs01xpak[,  get(axis[axis_k]) ]

	## tau-delay estimation based on the mutual information function
	tau.ami <- timeLag(time.series = inputtimeseries, technique = "ami",
                selection.method = ami_timelag_selection_method, value = ami_numeric_value,
		lag.max = maxtau,
                do.plot = F, n.partitions = number_of_partitions,
                units = "Bits")

	tauamilag_rs01 <- as.data.table(tau.ami[[1]])
	ami <- tau.ami[[2]]

	amidt <- as.data.table(ami)
	amidt[, tau := 0:(.N-1), ]
	
	ftag <-function(x) {list("RS01")}
	amidt[,c("sensor"):=ftag(), ]
	amirs01 <- amidt

	tauamilag_rs01[,c("sensor"):=ftag(), ]
	

	time_lags_a <- rbind(tauamilag_hs01, tauamilag_rs01)
	amis<-rbind(amihs01, amirs01)

	## function for axis
	fa <-function(x) {  axis[axis_k]  }

	time_lags_a[,c("axis"):=fa(), ]
	time_lags_p <- rbind(time_lags_p,time_lags_a)

	amis[,c("axis"):=fa(), ]
	amip <- rbind(amip,amis)



} ## for (axis_k in c(1:length(axis)  )){ 





# function for Particpant Number
fp <-function(x) {  pNN[participants_k]   }

amip[,c("participant"):=fp(), ]
AMI <- rbind(AMI, amip)

time_lags_p[,c("participant"):=fp(), ]
time_lags <- rbind(time_lags,time_lags_p)


} ### for (participants_k in c(1:number_of_participants)) 




# function for movement variable
fa <-function(x) {  movement_variable   }

AMI[,c("Activity"):=fa(), ]
AMIS <- rbind(AMIS, AMI)


time_lags[,c("Activity"):=fa(), ]
TIMEDELAYS <- rbind( TIMEDELAYS, time_lags )  


} #(L150)for (movement_k in 1:length(movement_variables) ) {



setcolorder(AMIS,c(5,6,4,3,2,1) )
setcolorder(TIMEDELAYS,c(4,5,2,3,1) )
names(TIMEDELAYS)[5] <- 'timedelays'




################################################################################
# (6) Creating Outcome Data Path


if (file.exists(outcomes_data_path)){
  setwd(file.path(outcomes_data_path))
} else {
  dir.create(outcomes_data_path, recursive=TRUE)
  setwd(file.path(outcomes_data_path))
}


################################################################################
#####  (7)  Writing Data
 
tagfile <- paste('-', windowltag, '.dt', sep='')
AMIfilename <- paste ('AMI', tagfile, sep='')
MTDfilename <- paste ('MTD', tagfile, sep='')


write.table(AMIS, AMIfilename, row.name=FALSE)
write.table(TIMEDELAYS, MTDfilename, row.name=FALSE)






#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
