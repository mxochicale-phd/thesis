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




mainaxis <- 'GyroZ'
selaXX <- c(	
	paste('sg0zmuv',mainaxis,sep=''),
	paste('sg1zmuv',mainaxis,sep=''),
	paste('sg2zmuv',mainaxis,sep='')
	)

AMI <-  AMI[  axis %in% selaXX ]
MTD <-  MTD[  axis %in% selaXX ]





###################################################################


HNnbMTD <- MTD[Activity=='HNnb', .SDcols=cols  ]
HNwbMTD <- MTD[Activity=='HNwb', .SDcols=cols  ]
HFnbMTD <- MTD[Activity=='HFnb', .SDcols=cols  ]
HFwbMTD <- MTD[Activity=='HFwb', .SDcols=cols  ]




mtHNnb <- round( mean( HNnbMTD$timedelays  ) ) 
mtHNwb <- round( mean( HNwbMTD$timedelays  ) ) 
mtHFnb <- round( mean( HFnbMTD$timedelays  ) ) 
mtHFwb <- round( mean( HFwbMTD$timedelays  ) ) 




total_mean <- round( mean(  c(mtHNnb, mtHNwb, mtHFnb, mtHFwb) )) 
message('window=', windowl, ' total mean minDelay=' , total_mean )









#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
