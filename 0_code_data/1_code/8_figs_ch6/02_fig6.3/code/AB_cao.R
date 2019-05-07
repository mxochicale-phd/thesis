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
	
	# (4) Filtering data.table variables
		# (4.1) Windowing data
		# (4.2) Filtering variables
			# (4.2.1) Activities Selection
			# (4.2.2) Sensor Selection
			# (4.2.3) Participant Selection
			# (4.2.4) Axis Selection

	# (5) Average Mutual Information 
		# (5.1) Parameter selections
		# (5.2) MAIN LOOP for CAOS 

	# (6) Creating Outcome Data Path
	# (7)  Writing Data


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

# cao
path_cao97_functions_R <- '/0_code_data/1_code/2_libraries_functions/rfunctions/embedding_parameters/withCao1997/cao97_functions.R'


## Outcomes Data Path
outcomes_data_path <- paste(github_repo_path,'/0_code_data/0_data/1_datasets/hri/utde', sep="")
## Data Path
data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hri/dataset', sep="")
setwd(file.path(data_path))





################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data


################################################################################
# (2) Reading data

file_ext <- paste('xdata', '.dt',sep='')
data <- fread( file_ext, header=TRUE)


################################################################################
# (4) Filtering out variables in xdata data.table


data <- data[,.(
	sg0zmuvGyroY, sg1zmuvGyroY, sg2zmuvGyroY,
	sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
	), by=. (Participant,Activity,Sensor,Sample,Time)]




################################################################################
### (4.1) Windowing Data [xdata[,.SD[1:2],by=.(Participant,Activity,Sensor)]]


##########################
##### one window lenght
#windowsl <- c(100)
#windowsn <- c('w2')
#

##########################
#### one window lenght
windowsl <- c(500)
windowsn <- c('w10')


###########################
##### four window lenghts
#windowsl <- c(100,   250,  500,   750)
#windowsn <- c('w2', 'w5', 'w10', 'w15')
#

#######################################
### w2, 2-second window (100 samples) ## 100 to 200
#######################################
### w5, 5-second window (250 samples) # 100 to 350
######################################
### w10, 10-second window (500 samples) ## 100 to 600
#######################################
### w15, 15-second window (750 samples) ## 100 to 850




for ( wk in 1:(length(windowsl)) ) {

xdata <- data


EEE <- NULL # contains E1E2 values for movement, part, axis, sensor
MMMED <- NULL # contains minembdimvals for movement, part, axis, sensor

windowlengthnumber <- windowsl[wk]
windowltag <- windowsn[wk]

message('****************')
message('****************')
message('****************')
message('*** window:', windowltag)


# general variables for window legnth
wstar=100
wend=wstar+windowlengthnumber
windowlength=wend-wstar
windowframe =wstar:wend
xdata <- xdata[,.SD[windowframe],by=.(Participant,Activity,Sensor)];




###############################################################################
#### (4.2) Filtering variables in data table


##########################
## (4.2.1) Activities Selection
#movement_variables <- c('HN','HF')
#movement_variables <- c('VN','VF')
movement_variables <- c('HN', 'HF', 'VN', 'VF')


#########################################################
for (movement_k in 1:length(movement_variables) ) {

EE <- NULL # contains E1E2 values for partiicpants, axis, sensor
MED <- NULL # contains minembdimvals for movement, part, axis, sensor

movement_variable <- movement_variables[movement_k]
message(movement_variable)

xdatam <- xdata

if (movement_variable == 'HN' ) {
setkey(xdatam, Activity)
xdatam <- xdatam[.(c('HN'))]

} else if (movement_variable == 'HF' ) {
setkey(xdatam, Activity)
xdatam <- xdatam[.(c('HF'))]

} else if (movement_variable == 'VN') {
setkey(xdatam, Activity)
xdatam <- xdatam[.(c('VN'))]

} else if (movement_variable == 'VF') {
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

#number_of_participants <- 1
#number_of_participants <- 2
#number_of_participants <- 3
#number_of_participants <- 5
#number_of_participants <- 6
#number_of_participants <- 10
#number_of_participants <- 12
number_of_participants <- 20


if (number_of_participants == 1) {
setkey(xdatam, Participant)
pNN <- c('p01')
xdatap <- xdatam[.(
		pNN
		)]

} else if (number_of_participants == 2) {
setkey(xdatam, Participant)
pNN <- c('p01', 'p02')
xdatap <- xdatam[.(
		pNN
		)]

} else if (number_of_participants == 3) {
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
#

axis <- names(xdatap)[6: (  length(xdatap))  ]
xpa <- xdatap




##############################################################################
##############################################################################
###############################################################################
# (5) CAO's algorithm
source(paste(github_repo_path, path_cao97_functions_R, sep=''))


# (5.1) Parameter selections
delta_ee<-0.1

#maxtau <- 2
#maxdim <- 2

maxtau <- 10
maxdim <- 10

#maxtau <- 20
#maxdim <- 20




##############################################################################
##############################################################################
###############################################################################
# (5.2) MAIN LOOP for CAOS 


for (participants_k in c(1:number_of_participants)) { ##for (participants_k in c(1:number_of_participants)) { 
message('####################')
message('# PARTICIPANT: ', participants_k)
setkey(xpa, Participant)
xpak <- xpa[.( pNN[participants_k] )]


#### Sensors
hs01xpak <- xpak[Sensor=='HS01', .SDcols=cols  ]
rs01xpak <- xpak[Sensor=='RS01', .SDcols=cols  ]



Ep <- NULL
MEDp <- NULL
###### Axis
for (axis_k in c(1:length(axis)  )){ #for (axis_k in c(1:length(axis))){
	message('#### axis:' , axis[axis_k])

	########################
	message('     #HS01')
	inputtimeseries <- hs01xpak[,  get(axis[axis_k]) ]
	eemin_h <- data.table()
	MinEmdDim_h <- data.table()


	E <- data.table()
	for (tau_i in 1:maxtau){
	    ##message( 'tau: ', tau_i )
	    Et<- as.data.table(cao97sub(inputtimeseries,maxdim,tau_i) )
	  
	    	
		########################################    	
		## Minimum Embedding Dimension
		e <- Et# e for the same tau and mi= 1:maxdim	
		ee <- data.table()
			
		fi <- 0
		for (di in 1:(maxdim-2) ){ ##start##for (di in 1:(maxdim-2) ){
			##message( 'dim: ', (di+1), 'diff:', (abs(e$V1[di+1] - e$V1[di]) < delta_ee)    )
			ee <- rbind(ee,  cbind( abs( e$V1[di+1] - e$V1[di] )  , (abs( e$V1[di+1]-e$V1[di]))< delta_ee )  )
			

			if (   ( ( abs( e$V1[di+1]-e$V1[di]) )< delta_ee  ) # absolute substraction betweent the e[di+1] and e[di]
				&&  (   (  e$V1[di] > (1-delta_ee)  )  &&  ( e$V1[di] < (1+delta_ee) )   )    # is e[di] between 1 +/- delta_ee
				&&  (   (  e$V1[di+1] > (1-delta_ee)  )  &&  ( e$V1[di+1] < (1+delta_ee) )   )    # is e[di+1] between 1 +/- delta_ee
	   			) 
				{
				fi <- fi+1
				if (fi == 1)#return the first minimum dimension that is between the threshold
					{
					minEmdDim_h <- as.data.table(di+1)	
					}
				}
			if (fi==0)#otherwhise return zero in case none has been found
				{
				minEmdDim_h <- as.data.table(0)	
				}
			
			##message('fi',fi)	
		
		} ##end##for (di in 1:(maxdim-2) ){

		#create data table for diff and mindim[true/false]
		ee[,dim:=seq(2,(maxdim-1))]
		names(ee) <- gsub("V1", "diff", names(ee))
		names(ee) <- gsub("V2", "mindim", names(ee))

		#add tau column, reorder and accumudlate with other ee values
		func <-function(x) {list( tau_i )}
    		ee[,c("tau"):=func(), ]
 		setcolorder(ee, c(3,4,1,2))
    		eemin_h<- rbind(eemin_h, ee )##  is accumaltion of dim, tau, diff, mindim[true/false]


		##message('minEmdDim_h:',minEmdDim_h)
    		minEmdDim_h[,c("tau"):=func(), ]
		MinEmdDim_h <- rbind(MinEmdDim_h, minEmdDim_h)

		##
		########################################    	

 	    
	    
	    func <-function(x) {list( tau_i )}
	    Et[,c("tau"):=func(), ]
	    Et[,dim:=seq(.N)]
	    setcolorder(Et, c(3,4,1:2))
	    E <- rbind(E, Et )
	}
	names(E) <- gsub("V1", "E1", names(E))
	names(E) <- gsub("V2", "E2", names(E))

	fs <-function(x) {list("HS01")}
	E[,c("Sensor"):=fs(), ]
	Ehs01 <- E
	E <- NULL

	MinEmdDim_h[ ,c('Sensor'):=fs()]		


	########################
	message('     #RS01')
	inputtimeseries <- rs01xpak[,  get(axis[axis_k]) ]
	eemin_r <- data.table()
	MinEmdDim_r <- data.table()


	E <- data.table()
	for (tau_i in 1:maxtau){
	    ##message( 'tau: ', tau_i )
	    Et<- as.data.table(cao97sub(inputtimeseries,maxdim,tau_i) )
	    


  	
		########################################    	
		## Minimum Embedding Dimension
		e <- Et# e for the same tau and mi= 1:maxdim	
		ee <- data.table()
			
		fi <- 0
		for (di in 1:(maxdim-2) ){ ##start##for (di in 1:(maxdim-2) ){
			##message( 'dim: ', (di+1), 'diff:', (abs(e$V1[di+1] - e$V1[di]) < delta_ee)    )
			ee <- rbind(ee,  cbind( abs( e$V1[di+1] - e$V1[di] )  , (abs( e$V1[di+1]-e$V1[di]))< delta_ee )  )
			

			if (   ( ( abs( e$V1[di+1]-e$V1[di]) )< delta_ee  ) # absolute substraction betweent the e[di+1] and e[di]
				&&  (   (  e$V1[di] > (1-delta_ee)  )  &&  ( e$V1[di] < (1+delta_ee) )   )    # is e[di] between 1 +/- delta_ee
				&&  (   (  e$V1[di+1] > (1-delta_ee)  )  &&  ( e$V1[di+1] < (1+delta_ee) )   )    # is e[di+1] between 1 +/- delta_ee
	   			) 
				{
				fi <- fi+1
				if (fi == 1)#return the first minimum dimension that is between the threshold
					{
					minEmdDim_r <- as.data.table(di+1)	
					}
				}
			if (fi==0)#otherwhise return zero in case none has been found
				{
				minEmdDim_r <- as.data.table(0)	
				}
			
			##message('fi',fi)	
		
		} ##end##for (di in 1:(maxdim-2) ){

		#create data table for diff and mindim[true/false]
		ee[,dim:=seq(2,(maxdim-1))]
		names(ee) <- gsub("V1", "diff", names(ee))
		names(ee) <- gsub("V2", "mindim", names(ee))

		#add tau column, reorder and accumudlate with other ee values
		func <-function(x) {list( tau_i )}
    		ee[,c("tau"):=func(), ]
 		setcolorder(ee, c(3,4,1,2))
    		eemin_r<- rbind(eemin_r, ee )##  is accumaltion of dim, tau, diff, mindim[true/false]


		##message('minEmdDim_r:',minEmdDim_r)
    		minEmdDim_r[,c("tau"):=func(), ]
		MinEmdDim_r <- rbind(MinEmdDim_r, minEmdDim_r)

		##
		########################################    	




	    func <-function(x) {list( tau_i )}
	    Et[,c("tau"):=func(), ]
	    Et[,dim:=seq(.N)]
	    setcolorder(Et, c(3,4,1:2))
	    E <- rbind(E, Et )
	}
	names(E) <- gsub("V1", "E1", names(E))
	names(E) <- gsub("V2", "E2", names(E))

	fs <-function(x) {list("RS01")}
	E[,c("Sensor"):=fs(), ]
	Ers01 <- E
	E <- NULL
	
	MinEmdDim_r[ ,c('Sensor'):=fs()]		


	Ea <- rbind(Ehs01,Ers01)
	MEDa <- rbind(MinEmdDim_h,MinEmdDim_r)

	names(MEDa) <- gsub("V1", "minEmdDim", names(MEDa))



	## function for axis
	fa <-function(x) {  axis[axis_k]  }
	Ea[,c("axis"):=fa(), ]
	Ep <- rbind(Ep,Ea)

	MEDa[,c('axis'):=fa(), ]
	MEDp <- rbind(MEDp, MEDa)



} ## for (axis_k in c(1:length(axis)  )){ 



# function for Particpant Number
fp <-function(x) {  pNN[participants_k]   }
Ep[,c("Participant"):=fp(), ]
EE <- rbind(EE, Ep)

MEDp[,c('Participant'):=fp(), ]
MED <- rbind(MED,MEDp)



}##end##for (participants_k in c(1:number_of_participants)) 




##movement_variable <- movement_variables[movement_k]
## function for Movement 
fm <-function(x) {  movement_variable   }
EE[, c('Activity'):=fm() ]
EEE <- rbind(EEE, EE)

MED[, c('Activity'):=fm() ]
MMMED <- rbind(MMMED, MED)



}##end##(L150)for (movement_k in 1:length(movement_variables) ) {



#
#
#

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

 
tagfile <- paste('-', windowltag, '.dt', sep='')
EEEfilename <- paste ('EE', tagfile, sep='')
MMMEDfilename <- paste ('MED', tagfile, sep='')


write.table(EEE, EEEfilename, row.name=FALSE)
write.table(MMMED, MMMEDfilename, row.name=FALSE)





} ##end## for ( wk in 1:(length(windowsl)) ) { 





#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
