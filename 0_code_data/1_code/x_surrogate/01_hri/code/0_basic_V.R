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



#################
# Start the clock!
start.time <- Sys.time()




################################################################################
# (0) Defining paths for main_path, r_scripts_path, ..., etc.
homepath <- Sys.getenv("HOME")
r_scripts_path <- getwd()
setwd("../")
main_path <- getwd()
figures_path <- paste(main_path,'/src',sep="")
setwd("../../../../")
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
#source(paste(github_repo_path, libfun_path, rfunctions_ollin_cencah_R, sep='')) # Calling `functions_ollin_cencah` 


library(ggplot2)
library(devtools)
load_all(paste(github_repo_path, libfun_path, '/nonlinearTseries', sep=""))







################################################################################
# (2) Reading raw tidied  interpolated data
xdata <- fread("hri-TidiedInterpolatedRawData.dt", header=TRUE)
# add time variable
xdata[, Time:=Sample/50, ]
# add one sample to start at 0 instead of 0.2
xdata[, Time:=Time-0.02, ]
# reorder 
setcolorder(xdata, c(1:4, 11, 5:10))


####################
#### window size


windowlengthnumber <- c(100)
windowsn <- c('w2')



#windowlengthnumber <- c(250)
#windowsn <- c('w5')

#windowlengthnumber <- c(500)
#windowsn <- c('w10')
#windowlengthnumber <- c(750)
#windowsn <- c('w15')



# general variables for window legnth
wstar=100
wend=wstar+windowlengthnumber
windowlength=wend-wstar
windowframe =wstar:wend
xdata <- xdata[,.SD[windowframe],by=.(Participant,Activity,Sensor)];



###############################################################################
### (4.1) Selecting Participants
setkey(xdata, Participant)
## One Participants
xdata <- xdata[.(c('p01'))]
#xdata <- xdata[.(c('p02'))]
#xdata <- xdata[.(c('p03'))]
#xdata <- xdata[.(c('p04'))] 
#xdata <- xdata[.(c('p05'))]
#xdata <- xdata[.(c('p06'))]
#xdata <- xdata[.(c('p07'))]
#xdata <- xdata[.(c('p08'))]
#xdata <- xdata[.(c('p09'))]
#xdata <- xdata[.(c('p10'))]
#xdata <- xdata[.(c('p11'))]
#xdata <- xdata[.(c('p12'))]
#xdata <- xdata[.(c('p13'))]
#xdata <- xdata[.(c('p14'))] 
#xdata <- xdata[.(c('p15'))]
#xdata <- xdata[.(c('p16'))]
#xdata <- xdata[.(c('p17'))]
#xdata <- xdata[.(c('p18'))]
#xdata <- xdata[.(c('p19'))]
#xdata <- xdata[.(c('p20'))]


setkey(xdata, Activity)
#xdata <- xdata[.(c('VN'))]
xdata <- xdata[.(c('VF'))]

setkey(xdata, Sensor)
#xdata <- xdata[.(c('HS01'))]
xdata <- xdata[.(c('RS01'))]



xn<-xdata$GyroY
axisk <- names(xdata)[10]#GyroY











#############################################################
##  Create Plot Output Path
##
plot_path <- paste(figures_path, '/V', sep="")
#plot_path <- paste(figures_path, sep="")
if (file.exists(plot_path)){
    setwd(file.path(plot_path))
} else {
  dir.create(plot_path, recursive=TRUE)
  setwd(file.path(plot_path))
}








	plotlinewidtg <- 1.5
	basefontsize <- 18


	p <- ggplot(xdata)+ geom_line( aes(x=Time,y=get(axisk), color=Sensor), size=plotlinewidtg )+
   	facet_grid(Participant~Activity)+
   	scale_y_continuous()+
	#geom_segment(aes(x = 100, y = -125, xend = 100, yend = 125)) +
   	#coord_cartesian(xlim=c(wstar,wend), ylim=c(-7,7)) +
   	coord_cartesian(   ylim=c(-150,150)) +
	theme_bw(base_size=basefontsize)+
	theme(legend.position='none')+
	labs(y=axisk, x='Time (secs)')




	### Save Picture
	width = 800
	height = 800
	text.factor = 1
	dpi <- text.factor * 100
	width.calc <- width / dpi
	height.calc <- height / dpi

	file_ext <- paste('ts_.png', sep='')
	ggsave(filename = file_ext,
		dpi = dpi,
		width = width.calc,
		height = height.calc,
		units = 'in',
		bg = "transparent",
		device = "png",
		p)






##################################################################################
##################################################################################
##################################################################################
#### Surrogate Data Testing
#### https://rdrr.io/cran/nonlinearTseries/man/surrogateTest.html



# Number of generated surrogates 
K_val <- 5
alpha <- 0.05

NS= ((2*K_val)/alpha) -1 # for two-side test
message('NS=', NS)


sdt = surrogateTest(	
	time.series = xn,
	significance = alpha,
        K=K_val, 
	#Integer controlling the number of surrogates to be generated 
	one.sided = FALSE,# a two-side test is applied. 
	FUN=timeAsymmetry,
	do.plot=FALSE
	) 



###############################
## saving  surrogate data testing plot
#`surrogate.data.R` at 
#$HOME/phd/phd-thesis/0_code_data/1_code/2_libraries_functions/nonlinearTseries/R 


  surrogates.statistics = sdt$surrogates.statistics 
  data.statistic = sdt$data.statistic 

xlab = "Values of the statistic"
ylab = ""
main="Surrogate data testing"
type = "h"
lwd = 2
xlim = NULL
ylim = NULL
 
  
  if (is.null(xlim)) {
    xlim = range(data.statistic, surrogates.statistics)
  }
  if (is.null(ylim)) {
    ylim = c(0, 3)
  } 
 

  
#sdt_filename_extension <-  paste('sdt_', signal_source, '_window_length_', N, '.png', sep='')  
sdt_filename_extension <-  paste('sdt_.png', sep='')  
png(sdt_filename_extension, width = 800, height = 800)

 
 plot(surrogates.statistics, rep(1, length(surrogates.statistics)), 
       xlim = xlim, ylim = ylim, 
       type = type, lwd = lwd, main = main, xlab = xlab, ylab = ylab, 
       col = 1, lty = 1)
 lines(data.statistic,2, type = type, lwd = 10, col = 2, lty = 2)
 legend("top",bty = "n", legend = c("Surrogate data", "Original data"), col = 1:2,  lty = c(1, 2), lwd = lwd)
 
 
dev.off() 









#
#### Two Participants
##xdata <- xdata[.(c('p01','p02'))]
#
#### Three Participant
##xdata <- xdata[.(c('p01', 'p02', 'p03'))]
#
## ################################################################################
## ## Six Participants
## xdata <- xdata[.(c('p01','p02', 'p03', 'p04', 'p05', 'p06'
##                    ))]
#
#################################################################################
### Twelve Participants
## xdata <- xdata[.(c('p01','p02', 'p03', 'p04', 'p05', 'p06','p07','p08', 'p09', 'p10', 'p11', 'p12'))]
#
#
#
#################################################################################
#### Twenty Participants
##xdata <- xdata[.(c('p01','p02', 'p03', 'p04', 'p05', 'p06','p07','p08', 'p09', 'p10',
##                    'p11','p12', 'p13', 'p14', 'p15', 'p16','p17','p18', 'p19', 'p20'
##                   ))]
##
##
#
#
##################################################################################
##### (5) postprocessing vectors
##
#
#
#################################################################################
#### (5.2) Zero mean and unit Variance
####
#xdata[,c('sg0zmuvAccX', 'sg0zmuvAccY', 'sg0zmuvAccZ','sg0zmuvGyroX', 'sg0zmuvGyroY', 'sg0zmuvGyroZ'
#	) :=
#       lapply(.(
#		AccX, AccY, AccZ, GyroX, GyroY, GyroZ
#		), 
#	function(x) ( zeromean_unitvariance(x)  ) )]
#
#
#
#
#
#################################################################################
#### (5.3) Smoothing data with Savitzky-Golay Filter
####
#
#### FUNCTON TO SMOOTH THE DATA
#SGolay <- function(xinput,sgCoeffs){
#  output <- filter(sgCoeffs, xinput)
#  return(output)
#}
#
#polynomial_degree <- 5
#SavitzkyGolayCoeffs1 <- sgolay(p=polynomial_degree, n=29 ,m=0)
#SavitzkyGolayCoeffs2 <- sgolay(p=polynomial_degree, n=159 ,m=0)
#
#
#xdata[,c('sg1AccX', 'sg1AccY', 'sg1AccZ', 'sg1GyroX', 'sg1GyroY', 'sg1GyroZ',
#	 'sg1zmuvAccX', 'sg1zmuvAccY', 'sg1zmuvAccZ', 'sg1zmuvGyroX', 'sg1zmuvGyroY', 'sg1zmuvGyroZ'
#	) :=
#	lapply(.(
#		AccX, AccY, AccZ, GyroX, GyroY, GyroZ,
#		sg0zmuvAccX, sg0zmuvAccY, sg0zmuvAccZ, sg0zmuvGyroX, sg0zmuvGyroY, sg0zmuvGyroZ
#		), 
#	function(x) ( SGolay(x,SavitzkyGolayCoeffs1)  ))
#	]
#
#xdata[,c('sg2AccX', 'sg2AccY', 'sg2AccZ', 'sg2GyroX', 'sg2GyroY', 'sg2GyroZ',
#	 'sg2zmuvAccX', 'sg2zmuvAccY', 'sg2zmuvAccZ', 'sg2zmuvGyroX', 'sg2zmuvGyroY', 'sg2zmuvGyroZ'
#	) :=
#	lapply(.(
#		AccX, AccY, AccZ, GyroX, GyroY, GyroZ,
#		sg0zmuvAccX, sg0zmuvAccY, sg0zmuvAccZ, sg0zmuvGyroX, sg0zmuvGyroY, sg0zmuvGyroZ
#		), 
#	function(x) ( SGolay(x,SavitzkyGolayCoeffs2)  ))
#	]
#
#
#
##################################################################################
### (6) Selecting Axis after postprocessing 
##
#
#
#####HORIZONTAL/VERTICAL
#
#xpa <- xdata[,.(
#	#sg2zmuvGyroY,
#	#sg2zmuvGyroZ
#	sg0zmuvGyroY, sg1zmuvGyroY, sg2zmuvGyroY,
#	sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
#	), by=. (Participant,Activity,Sensor,Sample,Time)]
#
#
#
#movementtag <- 'H' 
#setkey(xpa, Activity)
#xpa <- xpa[.(c('HN', 'HF'))]
#
#
#setkey(xpa, Sensor)
##xpa <- xpa[.(c('HS01','RS01'))]
#xpa <- xpa[.(c('RS01'))]
#
#
#### GyroZ -- HORIZONTAL
#xpa <- xpa[,.(
#	sg2zmuvGyroZ
#	), by=. (Participant,Activity,Sensor,Sample,Time)]
#	#sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
#
#
#
#
#
#
#
#
#
#
#
#
##################################
##################################
##################################
##################################
#####  PLOT
#
#
#################################################################################
#################################################################################
#################################################################################
#################################################################################
#### (4.1) Windowing Data [xdata[,.SD[1:2],by=.(Participant,Activity,Sensor)]]
#
#
##########################
##### one window lenght
#windowsl <- c(3000)
#windowsn <- c('w10')
#
#
#############################
####### four window lenghts
##windowsl <- c(100,250,500,750)
##windowsn <- c('w2', 'w5', 'w10', 'w15')
#########################################
##### w2, 2-second window (100 samples) ## 100 to 200
#########################################
##### w5, 5-second window (250 samples) # 100 to 350
########################################
##### w10, 10-second window (500 samples) ## 100 to 600
#########################################
##### w15, 15-second window (750 samples) ## 100 to 850
#
#
#
#
#
#
#for ( wk in 1:(length(windowsl)) ) {
#
#xdata <- xpa
#windowlengthnumber <- windowsl[wk]
#windowksams <- paste('w', windowlengthnumber, sep='')
#windowksecs <- windowsn[wk]
#
#message('****************')
#message('****************')
#message('****************')
#message('****************')
#message('*** window:', windowksams)
#
#
#
## general variables for window legnth
#wstar=000
#wend=wstar+windowlengthnumber
#windowlength=wend-wstar
#windowframe =wstar:wend
#wkdata <- xdata[,.SD[windowframe],by=.(Participant,Activity,Sensor)];
#
#
#
#
#
############################
#### (4.2.3) Activities Selection
##
#
#
################## Reorder Factor:
#wkdata$Activity <- factor(wkdata$Activity)
#wkdata$Activity <- factor(wkdata$Activity, levels= levels (wkdata$Activity)[c(2,1)] )
#
#
#
#
##################################################################################
##################################################################################
##################################################################################
##################################################################################
#				### (4.2.4) Axis Selection
#			
#	
#		################################################################################
#		# (3) Outcomes Plot Path
#		if (file.exists(outcomes_plot_path)){
#		  setwd(file.path(outcomes_plot_path))
#		} else {
#		  dir.create(outcomes_plot_path, recursive=TRUE)
#		  setwd(file.path(outcomes_plot_path))
#		}
#
#	
#				axis <- names(wkdata)[6: (  length(wkdata))  ]
#				####### Axisk
#				for (axis_k in c(1:length(axis)  )){ #for (axis_k in c(1:length(axis))){
#				
#				
#				axisk<- axis[axis_k]
#				message('#### axisk:  ' , axisk )
#	
#
#
#	plotlinewidtg <- 1.5
#	basefontsize <- 18
#	p <- ggplot(wkdata)+ geom_line( aes(x=Time,y=get(axisk), color=Sensor), size=plotlinewidtg )+
#   	facet_grid(Participant~Activity)+
#   	scale_y_continuous()+
#	 geom_vline(xintercept = 2)+
#	 geom_vline(xintercept = 4)+
#	 geom_vline(xintercept = 7)+
#	 geom_vline(xintercept = 12)+
#	 geom_vline(xintercept = 17)+
#	#geom_segment(aes(x = 100, y = -125, xend = 100, yend = 125)) +
#   	#coord_cartesian(xlim=c(wstar,wend), ylim=c(-7,7)) +
#   	#coord_cartesian(   ylim=c(-3,3)) +
#   	coord_cartesian(   ylim=c(-3,3), x=c(0,60)) +
#	theme_bw(base_size=basefontsize)+
#	#theme(legend.position='none')+
#	labs(y=axisk, x='Time (secs)')
#
#
#	### Save Picture
#	width = 1200 #1600 #600
#	height = 450 #1600 #800 
#	text.factor = 1
#	dpi <- text.factor * 100
#	width.calc <- width / dpi
#	height.calc <- height / dpi
#
#	file_ext <- paste(axisk,'-', windowksams, '-m', movementtag, '.png', sep='')
#	ggsave(filename = file_ext,
#		dpi = dpi,
#		width = width.calc,
#		height = height.calc,
#		units = 'in',
#		bg = "transparent",
#		device = "png",
#		p)
#
#
#
#
#
#
#
#				}##end##for (axis_k in c(1:length(axis)  )){ 
##################################################################################
##################################################################################
##################################################################################
##################################################################################
#
#
#
#} ##end## for ( wk in 1:(length(windowsl)) ) { 
#################################################################################
#################################################################################
#################################################################################
#################################################################################
#
#
#




#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
# message('Execution Time: ', end.time - start.time)

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
