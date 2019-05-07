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

	# (6) Plot E values
		# (6.1) main if for:
			# (6.1.0) Creating paths for plots
			# (6.1.1) E1 and E2 values
			# (6.1.2) Minimum Embedding Dimensions Plots


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

## Data Path
data_path <-  paste(github_repo_path,'/0_code_data/0_data/1_datasets/hii/utde', sep="")
setwd(file.path(data_path))



################################################################################
# (1) Loading Functions and Libraries and Setting up digits
library(ggplot2)
library(data.table) # for manipulating data
library(RColorBrewer) #for brewer.pal
library(latex2exp)


################################################################################
# (2) Reading data


#windowl<-'w2'
#aMED <- fread('aMED-H-w2.dt', header=TRUE)

#windowl<-'w5'
#aMED <- fread('aMED-H-w5.dt', header=TRUE)

windowl<-'w10'
aMED <- fread('aMED-H-w10.dt', header=TRUE)

#windowl<-'w15'
#aMED <- fread('aMED-H-w15.dt', header=TRUE)



#################################################################################
#### (6) Plot E values


# (6.1.1)  Creating paths for plots
if (file.exists(outcomes_plot_path)){
    setwd(file.path(outcomes_plot_path))
} else {
  dir.create(outcomes_plot_path, recursive=TRUE)
  setwd(file.path(outcomes_plot_path))
}








#################################
# () filtering participants/axis/ etc

#taus <- c('1') 
#taus <- c('1', '2', '3', '4', '5') 
#selpNN <- c('p01','p02', 'p03') 
#selaXX <- c('AccX','AccY', 'AccZ') 
#aee <-  eHw10[ tau %in% taus &  participant %in% selpNN & axis %in% selaXX ]




noparticipants <- 6
selpNN <- c('p01', 'p04', 'p05', 'p10', 'p11', 'p15')


#noparticipants <- 20
#selpNN <- c('p01', 'p02', 'p03', 'p04', 'p05', 'p06', 'p07', 'p08', 'p09', 'p10',
#	    'p11', 'p12', 'p13', 'p14', 'p15', 'p16', 'p17', 'p18', 'p19', 'p20')	



mainaxis <- 'GyroZ'
selaXX <- c(	
	paste('sg0zmuv',mainaxis,sep=''),
	paste('sg1zmuv',mainaxis,sep=''),
	paste('sg2zmuv',mainaxis,sep='')
	)



# Substitute axis to make shorter names for the plots
aMED$Axis <- gsub('sg0zmuvGyroZ', 'sg0', aMED$Axis) 
aMED$Axis <- gsub('sg1zmuvGyroZ', 'sg1', aMED$Axis) 
aMED$Axis <- gsub('sg2zmuvGyroZ', 'sg2', aMED$Axis) 





##########################
## (4.2.1) Activities Selection
movement_variables <- c('HNnb', 'HNwb', 'HFnb', 'HFwb')

#########################################################
for (movement_k in 1:length(movement_variables) ) {


movement_variable <- movement_variables[movement_k]
message(movement_variable)

amed<- aMED


if (movement_variable == 'HNnb' ) {
setkey(amed, Activity)
amed <- amed[.(c('HNnb'))]



} else if (movement_variable == 'HNwb' ) {
setkey(amed, Activity)
amed <- amed[.(c('HNwb'))]



} else if (movement_variable == 'HFnb') {
setkey(amed, Activity)
amed <- amed[.(c('HFnb'))]



} else if (movement_variable == 'HFwb') {
setkey(amed, Activity)
amed <- amed[.(c('HFwb'))]



} else {
message('no valid movement_variable')
}










yminmax <- c(0,10)
basesizefont <- 18



amedh <- amed[Sensor=='HS01', .SDcols=cols  ]

bph <-  ggplot(amedh, aes(x=Axis, y=aMED) )+
          geom_point(aes(fill=Axis),
                    alpha=0.8,
                    size=4,
                    shape=21,
                    position=position_jitter(width=0.15, height=0)  )+
        geom_boxplot(lwd=1,outlier.colour=NA, fill=NA)+
        # geom_boxplot(lwd=1,outlier.colour = c("grey40") , outlier.size=4)+
        #labs(x= "Axis", y="min Emb Dim")+
   	xlab( "" )+
   	ylab( TeX(' $m_0$ ') )+
         theme_bw(15)+
         theme(panel.grid.minor= element_blank(),
               panel.border=element_rect(color="black"),
               legend.position="none")+
	coord_cartesian(ylim= yminmax)+
	theme_bw(base_size=basesizefont) +
	theme(legend.position = 'none' ) +
	theme(axis.text.x = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain")  ) +
  	stat_summary(fun.y = mean, geom = "point", shape = 23, size = 4, fill = "gray")



amedr <- amed[Sensor=='HS02', .SDcols=cols  ]


bpr <-  ggplot(amedr, aes(x=Axis, y=aMED) )+
          geom_point(aes(fill=Axis),
                    alpha=0.8,
                    size=4,
                    shape=21,
                    position=position_jitter(width=0.15, height=0)  )+
        geom_boxplot(lwd=1,outlier.colour=NA, fill=NA)+
        # geom_boxplot(lwd=1,outlier.colour = c("grey40") , outlier.size=4)+
   	xlab( "" )+
   	ylab( TeX(' $m_0$ ') )+
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




tagfilename <- paste('-', windowl, '-', movement_variable, sep='') 
filenameimage <- paste('avMED-HS01', tagfilename, '.png',sep='')
ggsave(filename = filenameimage,
        dpi = dpi,
        width = width.calc,
        height = height.calc,
        units = 'in',
        bg = "transparent",
        device = "png",
	bph)



tagfilename <- paste('-', windowl, '-', movement_variable, sep='') 
filenameimage <- paste('avMED-HS02', tagfilename, '.png',sep='')
ggsave(filename = filenameimage,
        dpi = dpi,
        width = width.calc,
        height = height.calc,
        units = 'in',
        bg = "transparent",
        device = "png",
	bpr)




}##end##for (movement_k in 1:length(movement_variables) ) {







#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
