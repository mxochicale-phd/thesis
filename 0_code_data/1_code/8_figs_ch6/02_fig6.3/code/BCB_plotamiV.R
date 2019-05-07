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
setwd("../")
main_path <- getwd()
outcomes_plot_path <- paste(main_path,'/src',sep="")
setwd("../../../../")
github_repo_path <- getwd()


#### Data Path
data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hri/utde', sep="")
setwd(file.path(data_path))




################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data

library(ggplot2)
library(RColorBrewer) #for brewer.pal
library(latex2exp)

################################################################################
# (2) Reading data


noparticipants <- 20

#
#AMI <- fread('AMI-w2.dt', header=TRUE)
#MTD <- fread('MTD-w2.dt', header=TRUE)
#windowl<-'w2'
#
#
#
#AMI <- fread('AMI-w5.dt', header=TRUE)
#MTD <- fread('MTD-w5.dt', header=TRUE)
#windowl<-'w5'
#

AMI <- fread('AMI-w10.dt', header=TRUE)
MTD <- fread('MTD-w10.dt', header=TRUE)
windowl<-'w10'

#
#AMI <- fread('AMI-w15.dt', header=TRUE)
#MTD <- fread('MTD-w15.dt', header=TRUE)
#windowl<-'w15'
#
#

mainaxis <- 'GyroY'
selaXX <- c(	
	paste('sg0zmuv',mainaxis,sep=''),
	paste('sg1zmuv',mainaxis,sep=''),
	paste('sg2zmuv',mainaxis,sep='')
	)

AMI <-  AMI[  axis %in% selaXX ]
MTD <-  MTD[  axis %in% selaXX ]


# Substitute axis to make shorter names for the plots
MTD$axis <- gsub('sg0zmuvGyroY', 'sg0', MTD$axis) 
MTD$axis <- gsub('sg1zmuvGyroY', 'sg1', MTD$axis) 
MTD$axis <- gsub('sg2zmuvGyroY', 'sg2', MTD$axis) 



#########################
##
## Time in milliseconds
##
sample_rate <- 50
MTD[, timedelays:= (timedelays/sample_rate)*1000 ]





################################################################################
### (5.2) Creating and Changing to Preprosseced Data Path

if (file.exists(outcomes_plot_path)){
    setwd(file.path(outcomes_plot_path))
} else {
  dir.create(outcomes_plot_path, recursive=TRUE)
  setwd(file.path(outcomes_plot_path))
}




###################################################################
### Miminum Embedding Plots


yminmax <- c(0, (30/sample_rate)*1000 )
plotlinewidth <- 0.9
basesizefont <- 18

VNMTD <- MTD[Activity=='VN', .SDcols=cols  ]
HS01VNMTD <- VNMTD[sensor=='HS01', .SDcols=cols  ]
pHS01VNMTD <- ggplot(HS01VNMTD, aes(x=axis, y=timedelays) )+
          geom_point(aes(fill=axis),
                    alpha=0.8,
                    size=4,
                    shape=21,
                    position=position_jitter(width=0.15, height=0)  )+
        geom_boxplot(lwd=1,outlier.colour=NA, fill=NA)+
        # geom_boxplot(lwd=1,outlier.colour = c("grey40") , outlier.size=4)+
 	xlab( "" )+
   	ylab( TeX(' $ \\tau_0 $ (milliseconds) ') )+
         theme_bw(15)+
         theme(panel.grid.minor= element_blank(),
               panel.border=element_rect(color="black"),
               legend.position="none")+
	coord_cartesian(ylim= yminmax)+
	theme_bw(base_size=basesizefont) +
	theme(legend.position = 'none' ) +
	theme(axis.text.x = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain")  ) +
  	stat_summary(fun.y = mean, geom = "point", shape = 23, size = 4, fill = "gray")






RS01VNMTD <- VNMTD[sensor=='RS01', .SDcols=cols  ]
pRS01VNMTD <- ggplot(RS01VNMTD,  aes(x=axis, y=timedelays) )+
          geom_point(aes(fill=axis),
                    alpha=0.8,
                    size=4,
                    shape=21,
                    position=position_jitter(width=0.15, height=0)  )+
        geom_boxplot(lwd=1,outlier.colour=NA, fill=NA)+
        # geom_boxplot(lwd=1,outlier.colour = c("grey40") , outlier.size=4)+
 	xlab( "" )+
   	ylab( TeX(' $ \\tau_0 $ (milliseconds) ') )+
         theme_bw(15)+
         theme(panel.grid.minor= element_blank(),
               panel.border=element_rect(color="black"),
               legend.position="none")+
	coord_cartesian(ylim= yminmax)+
	theme_bw(base_size=basesizefont) +
	theme(legend.position = 'none' ) +
	theme(axis.text.x = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain")  ) +
  	stat_summary(fun.y = mean, geom = "point", shape = 23, size = 4, fill = "gray")







VFMTD <- MTD[Activity=='VF', .SDcols=cols  ]
HS01VFMTD <- VFMTD[sensor=='HS01', .SDcols=cols  ]
pHS01VFMTD <- ggplot(HS01VFMTD, aes(x=axis, y=timedelays) )+
          geom_point(aes(fill=axis),
                    alpha=0.8,
                    size=4,
                    shape=21,
                    position=position_jitter(width=0.15, height=0)  )+
        geom_boxplot(lwd=1,outlier.colour=NA, fill=NA)+
        # geom_boxplot(lwd=1,outlier.colour = c("grey40") , outlier.size=4)+
 	xlab( "" )+
   	ylab( TeX(' $ \\tau_0 $ (milliseconds) ') )+
         theme_bw(15)+
         theme(panel.grid.minor= element_blank(),
               panel.border=element_rect(color="black"),
               legend.position="none")+
	coord_cartesian(ylim= yminmax)+
	theme_bw(base_size=basesizefont) +
	theme(legend.position = 'none' ) +
	theme(axis.text.x = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain")  ) +
  	stat_summary(fun.y = mean, geom = "point", shape = 23, size = 4, fill = "gray")




RS01VFMTD <- VFMTD[sensor=='RS01', .SDcols=cols  ]
pRS01VFMTD <- ggplot(RS01VFMTD, aes(x=axis, y=timedelays) )+
          geom_point(aes(fill=axis),
                    alpha=0.8,
                    size=4,
                    shape=21,
                    position=position_jitter(width=0.15, height=0)  )+
        geom_boxplot(lwd=1,outlier.colour=NA, fill=NA)+
        # geom_boxplot(lwd=1,outlier.colour = c("grey40") , outlier.size=4)+
 	xlab( "" )+
   	ylab( TeX(' $ \\tau_0 $ (milliseconds) ') )+
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
width = 300
height = 500
text.factor = 1
dpi <- text.factor * 100
width.calc <- width / dpi
height.calc <- height / dpi

tagim <- paste( '-window-', windowl, sep='')
tagfile <- 'boxplots_'


filenameimage <- paste(tagfile, "HS01_VN", tagim, ".png",sep="")
ggsave(filename = filenameimage,
        dpi = dpi,
        width = width.calc,
        height = height.calc,
        units = 'in',
        bg = "transparent",
        device = "png",
	pHS01VNMTD
	)


filenameimage <- paste(tagfile, "RS01_VN", tagim, ".png",sep="")
ggsave(filename = filenameimage,
        dpi = dpi,
        width = width.calc,
        height = height.calc,
        units = 'in',
        bg = "transparent",
        device = "png",
	pRS01VNMTD
	)


filenameimage <- paste(tagfile, "HS01_VF", tagim, ".png",sep="")
ggsave(filename = filenameimage,
        dpi = dpi,
        width = width.calc,
        height = height.calc,
        units = 'in',
        bg = "transparent",
        device = "png",
	pHS01VFMTD
	)


filenameimage <- paste(tagfile, "RS01_VF", tagim, ".png",sep="")
ggsave(filename = filenameimage,
        dpi = dpi,
        width = width.calc,
        height = height.calc,
        units = 'in',
        bg = "transparent",
        device = "png",
	pRS01VFMTD
	)




#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
