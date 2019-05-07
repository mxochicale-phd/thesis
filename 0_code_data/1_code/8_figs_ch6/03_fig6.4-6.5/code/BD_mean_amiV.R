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
data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hri/utde', sep="")
setwd(file.path(data_path))




################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(ggplot2)
library(RColorBrewer) #for brewer.pal


################################################################################
# (2) Reading data


noparticipants <- 20


#AMI <- fread('AMI-w2.dt', header=TRUE)
#MTD <- fread('MTD-w2.dt', header=TRUE)
#windowl<-'w2'

#AMI <- fread('AMI-w5.dt', header=TRUE)
#MTD <- fread('MTD-w5.dt', header=TRUE)
#windowl<-'w5'
#

AMI <- fread('AMI-w10.dt', header=TRUE)
MTD <- fread('MTD-w10.dt', header=TRUE)
windowl<-'w10'

#AMI <- fread('AMI-w15.dt', header=TRUE)
#MTD <- fread('MTD-w15.dt', header=TRUE)
#windowl<-'w15'



mainaxis <- 'GyroY'
selaXX <- c(	
	paste('sg0zmuv',mainaxis,sep=''),
	paste('sg1zmuv',mainaxis,sep=''),
	paste('sg2zmuv',mainaxis,sep='')
	)

AMI <-  AMI[  axis %in% selaXX ]
MTD <-  MTD[  axis %in% selaXX ]







###################################################################
### Miminum Embedding Plots


VNMTD <- MTD[Activity=='VN', .SDcols=cols  ]
#HS01VNMTD <- VNMTD[sensor=='HS01', .SDcols=cols  ]
#RS01VNMTD <- VNMTD[sensor=='RS01', .SDcols=cols  ]



VFMTD <- MTD[Activity=='VF', .SDcols=cols  ]
#HS01VFMTD <- VFMTD[sensor=='HS01', .SDcols=cols  ]
#RS01VFMTD <- VFMTD[sensor=='RS01', .SDcols=cols  ]


mtVN <- round( mean( VNMTD$timedelays  ) ) 
mtVF <- round( mean( VFMTD$timedelays  ) ) 

total_mean <- round( mean(  c(mtVN, mtVF) )) 


message('window=', windowl, ' total mean minDelay=' , total_mean )





#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
