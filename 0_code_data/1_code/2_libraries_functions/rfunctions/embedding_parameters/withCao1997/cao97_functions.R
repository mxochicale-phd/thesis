#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:    cao97_functions.R
# Description:
#
#
############
# How to use
# add the following line to your main script
# for the directory where the functions and the R scripts lives, you have to add
#
#
#homepath <- Sys.getenv("HOME")
#github_path <- getwd()
#path_cao97_functions_R <- '/0_code_data/1_code/2_libraries_functions/rfunctions/embedding_parameters/withCao1997/cao97_functions.R'
#source(paste(github_path, path_cao97_functions_R, sep=''))
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel Xochicale
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



#### Setting up paths
homepath <- Sys.getenv("HOME")
github_path <- '/phd/phd-thesis'
path_cao97sub_so <- '/0_code_data/1_code/2_libraries_functions/rfunctions/embedding_parameters/withCao1997/cao97sub.so'

### Libraries for plotE1valus() and plotE2values()
library(ggplot2)
library(RColorBrewer)

#-----------------------------------------------------------------------------
#--------------------  cao97 FORTRAN subrutine wraped in R  --------------------------
#build dll to wrap f function in R
#R CMD SHLIB cao97sub.f
# which produce cao97sub.so and cao97sub.o

#to replace NaN values, use
#X <- replace(X, is.nan(X), 0)
cao97sub <- function(x,maxd,tau) {
    dyn.load( paste(homepath, github_path, path_cao97sub_so, sep='') )
    lx = length(x)
    retdata <- .Fortran("cao97sub",
                        x = as.double(x),
                        lx = as.integer(lx),
                        maxd = as.integer(maxd),
                        tau = as.integer(tau),
                        e1 = double(maxd),
                        e2 = double(maxd)
                        )
    return(list(retdata$e1[1:maxd-1], retdata$e2[1:maxd-1]))
 }
## Example
# maxd <- 20
# tau <- 5
# E <-  cao97sub(timeseries,maxd,tau)



#####################################################
#####################################################
#####################################################
## Following functions were added 12april2018 17h15m

plotE1values <- function(E,maxdim,maxtau,delta_ee) {

e1 <- ggplot(E) +
    geom_line( aes(x=dim,y=E1, colour=factor(tau) ),lwd = 3,alpha=0.5)+
    geom_point( aes(x=dim,y=E1, shape=factor(tau), colour=factor(tau)), size=5, stroke =1 )+
 	
	geom_hline(yintercept = 1+delta_ee) + 
	geom_hline(yintercept = 1-delta_ee) +
	annotate("text", 0, 1, vjust = -1, label = paste( '1 +/- ', delta_ee, sep='') )+

	scale_color_manual(values = colorRampPalette(brewer.pal(n = 9, name="Greens"))(2*maxtau)[(maxtau+1):(2*maxtau)]  ) +
    	scale_shape_manual(values= 1:(maxtau))+

    labs(x='Embedding dimension, m', y='E1(m)' )+
    coord_cartesian(xlim = c(0, (maxdim-1) ), ylim = c(0, 1.5 ) )+
    theme( axis.title.x = element_text(size = rel(2.5), angle = 0),
           axis.text.x = element_text(size = rel(2), angle = 0),
           axis.title.y = element_text(size = rel(2.5), angle = 90),
           axis.text.y = element_text(size = rel(2), angle = 90)
           )+
    theme(legend.title = element_text(size = rel(1.5)),
          legend.text = element_text(size = rel(1.5))
          )+
    theme(
          panel.grid.major = element_line(colour = 'gray'),
          panel.grid.minor = element_line(colour = 'gray'),
          panel.background = element_rect(fill = "transparent",colour = NA),
          plot.background = element_rect(fill = "transparent",colour = NA)
    )

#print(e1)

}
##example
## delta_ee<-0.1
##plotE1values(E,maxdim,maxtau,delta_ee)



plotE2values <- function(E,maxdim,maxtau) {


e2 <- ggplot(E) +
    geom_line( aes(x=dim,y=E2, colour=factor(tau) ),lwd = 3,alpha=0.5)+
    geom_point( aes(x=dim,y=E2, shape=factor(tau), colour=factor(tau)), size=5, stroke =1 )+

	scale_color_manual(values = colorRampPalette(brewer.pal(n = 9, name="Blues"))(2*maxtau)[(maxtau+1):(2*maxtau)]  ) +
    	scale_shape_manual(values= 1:(maxtau))+

    labs(x='Embedding dimension, m', y='E2(m)' )+
    coord_cartesian(xlim = c(0, (maxdim-1) ), ylim = c(0, 1.5 ) )+
    theme( axis.title.x = element_text(size = rel(2.5), angle = 0),
           axis.text.x = element_text(size = rel(2), angle = 0),
           axis.title.y = element_text(size = rel(2.5), angle = 90),
           axis.text.y = element_text(size = rel(2), angle = 90)
           )+
    theme(legend.title = element_text(size = rel(1.5)),
          legend.text = element_text(size = rel(1.5))
        )+
    theme(
          panel.grid.major = element_line(colour = 'gray'),
          panel.grid.minor = element_line(colour = 'gray'),
          panel.background = element_rect(fill = "transparent",colour = NA),
          plot.background = element_rect(fill = "transparent",colour = NA)
    )

#print(e2)


}
##example
##plotE2values(E,maxdim,maxtau)


