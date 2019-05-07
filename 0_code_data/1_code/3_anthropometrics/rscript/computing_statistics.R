###############################################################################	
#
#  Computing age statistics
#
#
#
#
#
###############################################################################	
	# OUTLINE:
 	# (0) Definifing paths 
	# (1) Statistics for 06 participants 
	# (2) Statistics for 20 participants 


library('data.table') #

################################################################################
# (0) Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()
setwd('../')
main_path <- getwd()
data_path <- paste(main_path,'/data', sep='')



################################################################################
# (1) Statistics for 06 participants 

datafilename <- 'data_06p.csv'

full_anthropometric_path_and_datafilename <- paste( data_path, '/', datafilename, sep='')
pNNanthropometric <- fread(full_anthropometric_path_and_datafilename)

all_pNNanthropometric <- pNNanthropometric[, head(.SD, .N), ] # replace .N for the number of participants
summary(all_pNNanthropometric)

m <- mean(all_pNNanthropometric$Age)
sd <- sd(all_pNNanthropometric$Age)
message('mean age: ', m, 'SD age: ' , sd)






################################################################################
# (1) Statistics for 20 participants 

datafilename <- 'data_20p.csv'

full_anthropometric_path_and_datafilename <- paste( data_path, '/', datafilename, sep='')
pNNanthropometric <- fread(full_anthropometric_path_and_datafilename)

all_pNNanthropometric <- pNNanthropometric[, head(.SD, .N), ] # replace .N for the number of participants
summary(all_pNNanthropometric)

m <- mean(all_pNNanthropometric$Age)
sd <- sd(all_pNNanthropometric$Age)
message('mean age: ', m, 'SD age: ' , sd)








#################################################################################
## (2) Filtering particpants (NOT USED)
#males_pNNanthropometric <- all_pNNanthropometric[Gender == 'Male' &  Handeness == 'Right', !c("MusicTraining") ]
#summary(males_pNNanthropometric)
#
#females_pNNanthropometric <- all_pNNanthropometric[Gender == 'Female' &  Handeness == 'Right', !c("MusicTraining") ]
#summary(females_pNNanthropometric)
#
#mf_pNNanthropometric <- all_pNNanthropometric[Gender == c('Male','Female') &  Handeness == 'Right', !c("MusicTraining") ]
#summary(mf_pNNanthropometric)
#






#############################################
setwd(r_scripts_path) ## go back to the r-script source path
