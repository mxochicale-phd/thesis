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
library(data.table) # for manipulating data

library(ggplot2)
library(RColorBrewer) #for brewer.pal


################################################################################
# (2) Reading data


#
#AMI <- fread('AMI-w2.dt', header=TRUE)
#MTD <- fread('MTD-w2.dt', header=TRUE)
#windowl<-'w2'
#

#
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



VNnbMTD <- MTD[Activity=='VNnb', .SDcols=cols  ]
VNwbMTD <- MTD[Activity=='VNwb', .SDcols=cols  ]
VNnbMTD <- MTD[Activity=='VNnb', .SDcols=cols  ]
VNwbMTD <- MTD[Activity=='VNwb', .SDcols=cols  ]




mtVNnb <- round( mean( VNnbMTD$timedelays  ) ) 
mtVNwb <- round( mean( VNwbMTD$timedelays  ) ) 
mtVNnb <- round( mean( VNnbMTD$timedelays  ) ) 
mtVNwb <- round( mean( VNwbMTD$timedelays  ) ) 




total_mean <- round( mean(  c(mtVNnb, mtVNwb, mtVNnb, mtVNwb) )) 
message('window=', windowl, ' total mean minDelay=' , total_mean )









#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
