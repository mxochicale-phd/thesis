#------------------------------------------------------------
#   Extra Functions For Recurrent Quantification Analysis using 
#   `nonlinearTseries` package
#   
#
#
# Written by Miguel Xochicale
# 
#------------------------------------------------------------


## LOADING FUNCTIONS
#github_path <- getwd()
#libfun_path <- '/0_code_data/1_code/2_libraries_functions/rfunctions'
#extra_rqa_R <- '/extra_rqa.R'
#
#### Calling `functions_extra_nonlinearTseries` 
#source( paste(github_path, libfun_path, extra_rqa_R, sep='') )
#


## LOADING LIBRARIES
#################################################################################
#mirror_repo <- 'https://www.stats.bris.ac.uk/R/'
#if (!require("ggplot2")) {
#install.packages('ggplot2', repos=mirror_repo, dependencies = TRUE) 
#library(ggplot2)
#}

library(ggplot2) 


## USAGE EXAMPLE

#
#rqa.analysis=rqa(time.series = xn, embedding.dim=1, time.lag=1,
#                radius=5,lmin=2,vmin=2,do.plot=FALSE,distanceToBorder=2)
#
#rm <- as.matrix(rqa.analysis$recurrence.matrix)
#maxsamplerp <- dim(rm)[1]
#RM <- as.data.table( melt(rm, varnames=c('a','b'),value.name='Recurrence') )
#rplot <- plotRecurrencePlot(RM,maxsamplerp)
#
#width = 1000
#height = 1000
#savePlot(filename_extension,width,height,rplot)
#
#



## output of Ymt using RSS()
#  output<-  list(  [1] ,      [2]  ,            [3]  ,    ...
#  output   list(  PC , singular_values  ,  rotateddata  , ...



################################################################################
plotRecurrencePlot <-function (RM, maxsamplerp)
{


axis_start<- as.numeric(RM[1,1])
axis_end<- as.numeric(RM[.N,1])

ggplot(RM)+
	geom_raster( aes(x=a,y=b,fill=Recurrence) ) +  
	scale_fill_manual( values = c("#ffffff", "#000000") ) + # black and white colours
	labs(x="Time (secs)", y="Time (secs)") +
	#labs(x="Sample", y="Sample") +
	scale_y_continuous(limits = c(axis_start, axis_end), expand = c(0, 0)) + # remove space between axis and area plot	
	scale_x_continuous(limits = c(axis_start, axis_end), expand = c(0, 0)) + # remove space between axis and area plot	
	theme_bw(base_size=20) + 

	theme(legend.position="none",
	plot.margin=grid::unit(c(10,10,10,10), "mm"), # increase the border between axis and the image
	#plot.margin=grid::unit(c(0,0,0,0), "mm"), # increase the border between axis and the image
	axis.line = element_line(colour = "black")
	)
}

# Usage of plotRecurrencePlot <-function (RM,maxsamplerp)
# Example: plotRecurrencePlot(RM,maxsamplerp)



################################################################################
plotOnlyRecurrencePlot <-function (RM,maxsamplerp)
{

ggplot(RM)+
	geom_raster( aes(x=a,y=b,fill=Recurrence) ) +  
	scale_fill_manual( values = c("#ffffff", "#000000") ) + # black and white colours
	theme_void()+	
	theme(legend.position="none")+
	scale_x_continuous(limits = c(0,maxsamplerp), expand = c(0, 0)) + # remove space between axis and area plot	
	scale_y_continuous(limits = c(0,maxsamplerp), expand = c(0, 0)) # remove space between axis and area plot

}

# Usage of plotOnlyRecurrencePlot <-function (RM,maxsamplerp)
# Example: plotOnlyRecurrencePlot(RM,maxsamplerp)


################################################################################
saveRP <-function (filename_extension,width,height,ggplotobject)
{

### Save Picture
#width = 1000
#height = 1000

text.factor = 1
dpi <- text.factor * 100
width.calc <- width / dpi
height.calc <- height / dpi

ggsave(filename = filename_extension,
             dpi = dpi,
             width = width.calc,
             height = height.calc,
             units = 'in',
             bg = "transparent",
             device = "png"
             , ggplotobject)


}
# Usage of saveRP <-function (filename,width,height,ggplotobject)
# Example: 




