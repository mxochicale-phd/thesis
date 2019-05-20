###############################################################################	
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


#################
# Start the clock!
start.time <- Sys.time()




################################################################################
# (0) Defining paths for main_path, r_scripts_path, ..., etc.
homepath <- Sys.getenv("HOME")
r_scripts_path <- getwd()
setwd("../")
main_path <- getwd()
outcomes_plot_path <- paste(main_path,'/src',sep="")
setwd("../../../../../")
github_repo_path <- getwd()

libfun_path <- '/0_code_data/1_code/2_libraries_functions'
rfunctions_ollin_cencah_R <- '/rfunctions/ollin_cencah.R'

### Outcomes Data Path
outcomes_data_path <- paste(github_repo_path,'/0_code_data/0_data/1_datasets/hri/dataset', sep="")

#### Raw Data Path
rawdata_path <- paste(github_repo_path,'/0_code_data/0_data/0_raw-timeseries/hri',sep='')
setwd(file.path(rawdata_path))


#################################################################################
## (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(signal)# for butterworth filter and sgolay
source(paste(github_repo_path, libfun_path, rfunctions_ollin_cencah_R, sep='')) # Calling `functions_ollin_cencah` 


################################################################################
# (2) Reading raw tidied  interpolated data
xdata <- fread("hri-TidiedInterpolatedRawData.dt", header=TRUE)
# add time variable
xdata[, Time:=Sample/50, ]
# add one sample to start at 0 instead of 0.2
xdata[, Time:=Time-0.02, ]
# reorder 
setcolorder(xdata, c(1:4, 11, 5:10))









###############################################################################
### (4.1) Selecting Participants
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
xdata <- xdata[.(c('p01','p02', 'p03', 'p04', 'p05', 'p06','p07','p08', 'p09', 'p10',
                   'p11','p12', 'p13', 'p14', 'p15', 'p16','p17','p18', 'p19', 'p20'
                   ))]








#################################################################################
#### (5) postprocessing vectors
#


################################################################################
### (5.2) Zero mean and unit Variance
###
xdata[,c('sg0zmuvAccX', 'sg0zmuvAccY', 'sg0zmuvAccZ','sg0zmuvGyroX', 'sg0zmuvGyroY', 'sg0zmuvGyroZ'
	) :=
       lapply(.(
		AccX, AccY, AccZ, GyroX, GyroY, GyroZ
		), 
	function(x) ( zeromean_unitvariance(x)  ) )]





################################################################################
### (5.3) Smoothing data with Savitzky-Golay Filter
###

### FUNCTON TO SMOOTH THE DATA
SGolay <- function(xinput,sgCoeffs){
  output <- filter(sgCoeffs, xinput)
  return(output)
}

polynomial_degree <- 5
SavitzkyGolayCoeffs1 <- sgolay(p=polynomial_degree, n=29 ,m=0)
SavitzkyGolayCoeffs2 <- sgolay(p=polynomial_degree, n=159 ,m=0)


xdata[,c('sg1AccX', 'sg1AccY', 'sg1AccZ', 'sg1GyroX', 'sg1GyroY', 'sg1GyroZ',
	 'sg1zmuvAccX', 'sg1zmuvAccY', 'sg1zmuvAccZ', 'sg1zmuvGyroX', 'sg1zmuvGyroY', 'sg1zmuvGyroZ'
	) :=
	lapply(.(
		AccX, AccY, AccZ, GyroX, GyroY, GyroZ,
		sg0zmuvAccX, sg0zmuvAccY, sg0zmuvAccZ, sg0zmuvGyroX, sg0zmuvGyroY, sg0zmuvGyroZ
		), 
	function(x) ( SGolay(x,SavitzkyGolayCoeffs1)  ))
	]

xdata[,c('sg2AccX', 'sg2AccY', 'sg2AccZ', 'sg2GyroX', 'sg2GyroY', 'sg2GyroZ',
	 'sg2zmuvAccX', 'sg2zmuvAccY', 'sg2zmuvAccZ', 'sg2zmuvGyroX', 'sg2zmuvGyroY', 'sg2zmuvGyroZ'
	) :=
	lapply(.(
		AccX, AccY, AccZ, GyroX, GyroY, GyroZ,
		sg0zmuvAccX, sg0zmuvAccY, sg0zmuvAccZ, sg0zmuvGyroX, sg0zmuvGyroY, sg0zmuvGyroZ
		), 
	function(x) ( SGolay(x,SavitzkyGolayCoeffs2)  ))
	]



#################################################################################
## (6) Selecting Axis after postprocessing 
#


####HORIZONTAL/VERTICAL

xpa <- xdata[,.(
	#sg2zmuvGyroY,
	#sg2zmuvGyroZ
	sg0zmuvGyroY, sg1zmuvGyroY, sg2zmuvGyroY,
	sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
	), by=. (Participant,Activity,Sensor,Sample,Time)]



movementtag <- 'V' 
setkey(xpa, Activity)
xpa <- xpa[.(c('VN', 'VF'))]


setkey(xpa, Sensor)
#xpa <- xpa[.(c('HS01','RS01'))]
xpa <- xpa[.(c('RS01'))]
#xpa <- xpa[.(c('RS01'))]

sensortag <- 'RS01'


### GyroZ -- HORIZONTAL
xpa <- xpa[,.(
	sg0zmuvGyroY, sg1zmuvGyroY, sg2zmuvGyroY
	), by=. (Participant,Activity,Sensor,Sample,Time)]
	#sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ






#################################
#################################
#################################
#################################
####  PLOT


################################################################################
################################################################################
################################################################################
################################################################################
### (4.1) Windowing Data [xdata[,.SD[1:2],by=.(Participant,Activity,Sensor)]]


#########################
#### one window lenght
windowsl <- c(500)
windowsn <- c('w10')


############################
###### four window lenghts
#windowsl <- c(100,250,500,750)
#windowsn <- c('w2', 'w5', 'w10', 'w15')
########################################
#### w2, 2-second window (100 samples) ## 100 to 200
########################################
#### w5, 5-second window (250 samples) # 100 to 350
#######################################
#### w10, 10-second window (500 samples) ## 100 to 600
########################################
#### w15, 15-second window (750 samples) ## 100 to 850






for ( wk in 1:(length(windowsl)) ) {

xdata <- xpa
windowlengthnumber <- windowsl[wk]
windowksams <- paste('w', windowlengthnumber, sep='')
windowksecs <- windowsn[wk]

message('****************')
message('****************')
message('****************')
message('****************')
message('*** window:', windowksams)



# general variables for window legnth
wstar=100
wend=wstar+windowlengthnumber
windowlength=wend-wstar
windowframe =wstar:wend
wkdata <- xdata[,.SD[windowframe],by=.(Participant,Activity,Sensor)];





###########################
### (4.2.3) Activities Selection
#


################# Reorder Factor:
wkdata$Activity <- factor(wkdata$Activity)
wkdata$Activity <- factor(wkdata$Activity, levels= levels (wkdata$Activity)[c(2,1)] )




#################################################################################
#################################################################################
#################################################################################
#################################################################################
				### (4.2.4) Axis Selection
			
	
		################################################################################
		# (3) Outcomes Plot Path
		if (file.exists(outcomes_plot_path)){
		  setwd(file.path(outcomes_plot_path))
		} else {
		  dir.create(outcomes_plot_path, recursive=TRUE)
		  setwd(file.path(outcomes_plot_path))
		}

	
				axis <- names(wkdata)[6: (  length(wkdata))  ]
				####### Axisk
				for (axis_k in c(1:length(axis)  )){ #for (axis_k in c(1:length(axis))){
				
				
				axisk<- axis[axis_k]
				message('#### axisk:  ' , axisk )
	


	plotlinewidtg <- 1.5
	basefontsize <- 18
	p <- ggplot(wkdata)+ geom_line( aes(x=Time,y=get(axisk), color=Sensor), size=plotlinewidtg )+
   	facet_grid(Participant~Activity)+
   	scale_y_continuous()+
	
	# geom_vline(xintercept = 2)+
	# geom_vline(xintercept = 4)+
	# geom_vline(xintercept = 7)+
	# geom_vline(xintercept = 12)+
	# geom_vline(xintercept = 17)+
	
	#geom_segment(aes(x = 100, y = -125, xend = 100, yend = 125)) +
   	#coord_cartesian(xlim=c(wstar,wend), ylim=c(-7,7)) +
   	coord_cartesian(   ylim=c(-6,6)) +
   	#coord_cartesian(   ylim=c(-3,3), x=c(0,60)) +
	theme_bw(base_size=basefontsize)+
	theme(legend.position='none')+
	labs(y=axisk, x='Time (secs)')


	### Save Picture
	width = 800 #1600 #600
	height = 1200 #1600 #800 
	text.factor = 1
	dpi <- text.factor * 100
	width.calc <- width / dpi
	height.calc <- height / dpi

	file_ext <- paste(axisk,'-', windowksams, '-m', movementtag, '_', sensortag ,'.png', sep='')
	ggsave(filename = file_ext,
		dpi = dpi,
		width = width.calc,
		height = height.calc,
		units = 'in',
		bg = "transparent",
		device = "png",
		p)







				}##end##for (axis_k in c(1:length(axis)  )){ 
#################################################################################
#################################################################################
#################################################################################
#################################################################################



} ##end## for ( wk in 1:(length(windowsl)) ) { 
################################################################################
################################################################################
################################################################################
################################################################################







#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
# message('Execution Time: ', end.time - start.time)

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
