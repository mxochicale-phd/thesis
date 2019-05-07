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
	# (2) Reading 


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

libfun_path <- '/0_code_data/1_code/2_libraries_functions'
rfunctions_extra_rqa_R <- '/rfunctions/extra_rqa.R'

## Data Path
data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hii/rqa', sep="")
setwd(file.path(data_path))



################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(signal)# for butterworth filter and sgolay
library(ggplot2)
library(RColorBrewer)

library(devtools)
load_all(paste(github_repo_path, libfun_path, '/nonlinearTseries', sep=""))
source( paste(github_repo_path, libfun_path, rfunctions_extra_rqa_R, sep='') )




################################################################################
# (2) Reading data

#windowksecs <- c('w2')
#windowksecs <- c('w5')
windowksecs <- c('w10')
#windowksecs <- c('w15')


file_ext <- paste('rqa_', windowksecs, '.dt',sep='')
W <- fread( file_ext, header=TRUE)



mainaxis <- 'GyroY'
selectAxisXX <- c(	
	paste('sg0zmuv',mainaxis,sep=''),
	paste('sg1zmuv',mainaxis,sep=''),
	paste('sg2zmuv',mainaxis,sep='')
	)
W <-  W[ Axis %in% selectAxisXX ]


## Substitute axis to make shorter names for the plots
W$Axis <- gsub('sg0zmuvGyroY', 'sg0', W$Axis) 
W$Axis <- gsub('sg1zmuvGyroY', 'sg1', W$Axis) 
W$Axis <- gsub('sg2zmuvGyroY', 'sg2', W$Axis) 




################################################################################
# () Recurrence Quantification Analysis Plots

#################################################################################
#################################################################################

ActivityXX <- c('VNnb', 'VNwb', 'VFnb', 'VFwb')


			for (activity_k in 1:length(ActivityXX) ) {

			activityk <- ActivityXX[activity_k]
			message(activityk)

			if (activityk == 'VNnb' ) {
			setkey(W, Activity)
			Wa <- W[.(c('VNnb'))]

			} else if (activityk == 'VNwb' ) {
			setkey(W, Activity)
			Wa <- W[.(c('VNwb'))]

			} else if (activityk == 'VFnb' ) {
			setkey(W, Activity)
			Wa <- W[.(c('VFnb'))]

			} else if (activityk == 'VFwb' ) {
			setkey(W, Activity)
			Wa <- W[.(c('VFwb'))]

			} else {
			message('no valid activity')
			}





#################################################################################
#################################################################################

sensors <- c('HS01','HS02')# HumanSensor01  and HumanSensor02

			for (sensor_k in 1:length(sensors) ) {

			sensork <- sensors[sensor_k]
			message(sensork)

			if (sensork == 'HS01' ) {
			setkey(Wa, Sensor)
			Ws <- Wa[.(c('HS01'))]

			} else if (sensork == 'HS02' ) {
			setkey(Wa, Sensor)
			Ws <- Wa[.(c('HS02'))]

			} else {
			message('no valid movement_variable')
			}



#####################################################
#		'REC', 'RATIO', 'DET', 'DIV', 
#
basesizefont <- 18


yminmax <- c(0,1)
mainlabel <-'REC'
prec <-  ggplot(Ws, aes(x=Axis, y=REC) )+
          geom_point(aes(fill=Axis),
                    alpha=0.8,
                    size=4,
                    shape=21,
                    position=position_jitter(width=0.15, height=0)  )+
        geom_boxplot(lwd=1,outlier.colour=NA, fill=NA)+
        # geom_boxplot(lwd=1,outlier.colour = c("grey40") , outlier.size=4)+
        labs(x= "", y=mainlabel)+
         theme_bw(15)+
         theme(panel.grid.minor= element_blank(),
               panel.border=element_rect(color="black"),
               legend.position="none")+
	coord_cartesian(ylim= yminmax)+
	theme_bw(base_size=basesizefont) +
	theme(legend.position = 'none' ) +
	theme(axis.text.x = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain")  ) +
  	stat_summary(fun.y = mean, geom = "point", shape = 23, size = 4, fill = "gray")




yminmax <- c(0.8,1.2)
mainlabel <-'DET'
pdet  <-  ggplot(Ws, aes(x=Axis, y=DET) )+
          geom_point(aes(fill=Axis),
                    alpha=0.8,
                    size=4,
                    shape=21,
                    position=position_jitter(width=0.15, height=0)  )+
        geom_boxplot(lwd=1,outlier.colour=NA, fill=NA)+
        # geom_boxplot(lwd=1,outlier.colour = c("grey40") , outlier.size=4)+
        labs(x= "", y=mainlabel)+
         theme_bw(15)+
         theme(panel.grid.minor= element_blank(),
               panel.border=element_rect(color="black"),
               legend.position="none")+
	coord_cartesian(ylim= yminmax)+
	theme_bw(base_size=basesizefont) +
	theme(legend.position = 'none' ) +
	theme(axis.text.x = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain")  ) +
  	stat_summary(fun.y = mean, geom = "point", shape = 23, size = 4, fill = "gray")





yminmax <- c(0,60)
mainlabel <-'RATIO'
pratio <-  ggplot(Ws, aes(x=Axis, y=RATIO) )+
          geom_point(aes(fill=Axis),
                    alpha=0.8,
                    size=4,
                    shape=21,
                    position=position_jitter(width=0.15, height=0)  )+
        geom_boxplot(lwd=1,outlier.colour=NA, fill=NA)+
        # geom_boxplot(lwd=1,outlier.colour = c("grey40") , outlier.size=4)+
        labs(x= "", y=mainlabel)+
         theme_bw(15)+
         theme(panel.grid.minor= element_blank(),
               panel.border=element_rect(color="black"),
               legend.position="none")+
	coord_cartesian(ylim= yminmax)+
	theme_bw(base_size=basesizefont) +
	theme(legend.position = 'none' ) +
	theme(axis.text.x = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain")  ) +
  	stat_summary(fun.y = mean, geom = "point", shape = 23, size = 4, fill = "gray")



yminmax <- c(0,6)
mainlabel <-'ENTR'
pentr <-  ggplot(Ws, aes(x=Axis, y=ENTR) )+
          geom_point(aes(fill=Axis),
                    alpha=0.8,
                    size=4,
                    shape=21,
                    position=position_jitter(width=0.15, height=0)  )+
        geom_boxplot(lwd=1,outlier.colour=NA, fill=NA)+
        # geom_boxplot(lwd=1,outlier.colour = c("grey40") , outlier.size=4)+
        labs(x= "", y=mainlabel)+
         theme_bw(15)+
         theme(panel.grid.minor= element_blank(),
               panel.border=element_rect(color="black"),
               legend.position="none")+
	coord_cartesian(ylim= yminmax)+
	theme_bw(base_size=basesizefont) +
	theme(legend.position = 'none' ) +
	theme(axis.text.x = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain")  ) +
  	stat_summary(fun.y = mean, geom = "point", shape = 23, size = 4, fill = "gray")





### Save Picture
################################################################################
# (5.0) Creating  and Changing to PlotPath
plot_path <- paste(outcomes_plot_path, '/V', sep="")
if (file.exists(plot_path)){
    setwd(file.path(plot_path))
} else {
  dir.create(plot_path, recursive=TRUE)
  setwd(file.path(plot_path))
}


### Save Picture
width = 300
height = 500
text.factor = 1
dpi <- text.factor * 100
width.calc <- width / dpi
height.calc <- height / dpi


##REC
tagfile <- 'rec_bp_'
fext <- paste(tagfile, windowksecs, '_', activityk, '_',  sensork ,  '.png', sep='')
ggsave(filename = fext,
        dpi = dpi,
        width = width.calc,
        height = height.calc,
        units = 'in',
        bg = "transparent",
        device = "png",
	prec
	)



##DET
tagfile <- 'det_bp_'
fext <- paste(tagfile, windowksecs, '_', activityk, '_',  sensork ,  '.png', sep='')
ggsave(filename = fext,
        dpi = dpi,
        width = width.calc,
        height = height.calc,
        units = 'in',
        bg = "transparent",
        device = "png",
	pdet)



##RATIO
tagfile <- 'ratio_bp_'
fext <- paste(tagfile, windowksecs, '_', activityk, '_',  sensork ,  '.png', sep='')
ggsave(filename = fext,
        dpi = dpi,
        width = width.calc,
        height = height.calc,
        units = 'in',
        bg = "transparent",
        device = "png",
	pratio)



##ENTR
tagfile <- 'entr_bp_'
fext <- paste(tagfile, windowksecs, '_', activityk, '_',  sensork ,  '.png', sep='')
ggsave(filename = fext,
        dpi = dpi,
        width = width.calc,
        height = height.calc,
        units = 'in',
        bg = "transparent",
        device = "png",
	pentr)





}##end##for (sensor_k in 1:length(sensors) ) {
#################################################################################
#################################################################################



} ##for (activity_k in 1:length(ActivityXX) ) {
#################################################################################
#################################################################################







#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
# message('Execution Time: ', end.time - start.time)

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
