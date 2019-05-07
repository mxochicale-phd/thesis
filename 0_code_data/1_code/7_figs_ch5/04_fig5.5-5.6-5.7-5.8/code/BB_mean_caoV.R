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


#################
# Start the clock!
start.time <- Sys.time()




################################################################################
# (0) Defining paths for main_path, r_scripts_path, ..., etc.

r_scripts_path <- getwd()
setwd("../../../../../")
github_repo_path <- getwd()

## Data Path
data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hii/utde', sep="")
setwd(file.path(data_path))



################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(ggplot2)
library(data.table) # for manipulating data
library(RColorBrewer) #for brewer.pal

################################################################################
# (2) Reading data


#windowl<-'w2'
#aMED <- fread('aMED-V-w2.dt', header=TRUE)
#MED <- fread('MED-w2.dt', header=TRUE)
#EE <- fread('EE-w2.dt', header=TRUE)
#

#windowl<-'w5'
#aMED <- fread('aMED-V-w5.dt', header=TRUE)
#MED <- fread('MED-w5.dt', header=TRUE)
#EE <- fread('EE-w5.dt', header=TRUE)
#

windowl<-'w10'
aMED <- fread('aMED-V-w10.dt', header=TRUE)
MED <- fread('MED-w10.dt', header=TRUE)
EE <- fread('EE-w10.dt', header=TRUE)


#windowl<-'w15'
#aMED <- fread('aMED-V-w15.dt', header=TRUE)
#MED <- fread('MED-w15.dt', header=TRUE)
#EE <- fread('EE-w15.dt', header=TRUE)
#














#################################
# () filtering participants/axis/ etc


#selpNN <- c('p01', 'p02', 'p03')

noparticipants <- 6
selpNN <- c('p01', 'p04', 'p05', 'p10', 'p11', 'p15')


#noparticipants <- 20
#selpNN <- c('p01', 'p02', 'p03', 'p04', 'p05', 'p06', 'p07', 'p08', 'p09', 'p10',
#	    'p11', 'p12', 'p13', 'p14', 'p15', 'p16', 'p17', 'p18', 'p19', 'p20')	


mainaxis <- 'GyroY'
selaXX <- c(	
	paste('sg0zmuv',mainaxis,sep=''),
	paste('sg1zmuv',mainaxis,sep=''),
	paste('sg2zmuv',mainaxis,sep='')
	)

aee <-  EE[ Participant %in% selpNN & axis %in% selaXX ]
me <-  MED[ Participant %in% selpNN & axis %in% selaXX ]

##### Reorder Factor for axis sensors in the ggplot data.table
me$axis <- factor(me$axis)
me$axis <- factor(me$axis, levels= levels (me$axis)[c(5,1,2,3,4)] )

##### Reorder Factor for axis sensors in the ggplot data.table
aee$axis <- factor(aee$axis)
aee$axis <- factor(aee$axis, levels= levels (aee$axis)[c(5,1,2,3,4)] )



# mean values for min embedding dimesitons
MA <- NULL




##########################
## (4.2.1) Activities Selection
movement_variables <- c('VNnb', 'VNwb', 'VFnb', 'VFwb')


#########################################################
for (movement_k in 1:length(movement_variables) ) {

EE <- NULL # contains E1E2 values for partiicpants, axis, sensor
MED <- NULL # contains minembdimvals for movement, part, axis, sensor



movement_variable <- movement_variables[movement_k]
message(movement_variable)

mem <- me
aeem <- aee

###
amed<- aMED


if (movement_variable == 'VNnb' ) {

setkey(mem, Activity)
mem <- mem[.(c('VNnb'))]
setkey(aeem, Activity)
aeem <- aeem[.(c('VNnb'))]
setkey(amed, Activity)
amed <- amed[.(c('VNnb'))]



} else if (movement_variable == 'VNwb' ) {
setkey(mem, Activity)
mem <- mem[.(c('VNwb'))]
setkey(aeem, Activity)
aeem <- aeem[.(c('VNwb'))]
setkey(amed, Activity)
amed <- amed[.(c('VNwb'))]



} else if (movement_variable == 'VFnb') {
setkey(mem, Activity)
mem <- mem[.(c('VFnb'))]
setkey(aeem, Activity)
aeem <- aeem[.(c('VFnb'))]
setkey(amed, Activity)
amed <- amed[.(c('VFnb'))]



} else if (movement_variable == 'VFwb') {
setkey(mem, Activity)
mem <- mem[.(c('VFwb'))]
setkey(aeem, Activity)
aeem <- aeem[.(c('VFwb'))]
setkey(amed, Activity)
amed <- amed[.(c('VFwb'))]



} else {
message('no valid movement_variable')
}













amedh <- amed[Sensor=='HS01', .SDcols=cols  ]
mah <- round( mean( amedh$aMED  ) ) 
message('HS01 ',  mah  )

amedr <- amed[Sensor=='HS02', .SDcols=cols  ]
mar <- round( mean( amedr$aMED  ) ) 
message('HS02 ',  mar )

ma<-c(mah,mar)
MA<-c(MA,ma)



}##end##for (movement_k in 1:length(movement_variables) ) {



mMA <- round( mean(MA) )
message('window=', windowl, ' mean minEmdDim=' , mMA )





#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
