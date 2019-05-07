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
# source(paste(github_path,'/hwum-dataset/r-scripts/functions/embedding_parameters/withCao1997/cao97_functions.R', sep='') )
# dyn.load('~/mxochicale/github/hwum-dataset/r-scripts/functions/embedding_parameters/withCao1997/cao97sub.so')
# dyn.load( '~/github/phd-thesis-code-data/code/rfunctions/embedding_parameters/withCao1997/cao97sub.so'  )

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



#### testing path
homepath <- Sys.getenv("HOME")
#message( 'homepath: ',   homepath )
repo_paths <- '/quetzalcoalt/srep2019'

#for plotE1valus() and plotE2values()
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
    dyn.load( paste(homepath, repo_paths, '/code/rfunctions/embedding_parameters/withCao1997/cao97sub.so', sep='') ) 
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






#
#maxylimit <- 1.4
#plot_E1_values<- function(E)
#{
#
#  plot_e1 = xyplot( E[[1]] +  E[[3]] +  E[[5]]  +  E[[7]] +  E[[9]] +
#                             E[[11]] +  E[[13]] +  E[[15]]  +  E[[17]] +  E[[19]]
#                           ~ 1: (maxd-1),
#                           type = "b", lwd=4,
#                           pch=1:10, # control the plot characters,
#                           col.line= c(1:10),
#                           cex=3, # control the characther expansion for characters
#                           main=list(label="", cex=2.5), #Control the character expansion ratio (cex)
#                           xlab=list(label="Dimension",  font=2, cex=2),
#                           ylab=list(label="E1 values",  font=2, cex=2),
#                           scales=list(font=2, cex=1.5,
#                                       y=list(limits=c(-.1,maxylimit))
#                           ),# size of the number labels from the x-y axes
#                           grid = TRUE,
#
#                           key=list(
#                             text = list(c(expression(paste(tau, "=1")),
#                                           expression(paste(tau, "=2")),
#                                           expression(paste(tau, "=3")),
#                                           expression(paste(tau, "=4")),
#                                           expression(paste(tau, "=5")),
#                                           expression(paste(tau, "=6")),
#                                           expression(paste(tau, "=7")),
#                                           expression(paste(tau, "=8")),
#                                           expression(paste(tau, "=9")),
#                                           expression(paste(tau, "=10"))
#                             )
#                             ),
#                             lines = list(pch=c(1:10), col= c(1:10) ),
#                             type="b",
#                             cex=2, # control the character expansion  of the symbols
#                             corner=c(0.95,0.05) # position
#                           )
#  )
#
#
#  print(plot_e1)
#
#}
#
#
#
#
#plot_E2_values<- function(E)
#{
#  plot_e2 = xyplot( E[[2]] +  E[[4]] +  E[[6]]  +  E[[8]] +  E[[10]] +
#          E[[12]] +  E[[14]] +  E[[16]]  +  E[[18]] +  E[[20]]
#        ~ 1: (maxd-1),
#        type = "b", lwd=4,
#        pch=1:10, # control the plot characters,
#        col.line= c(1:10),
#        cex=3, # control the characther expansion for characters
#        main=list(label="", cex=2.5), #Control the character expansion ratio (cex)
#        xlab=list(label="Dimension",  font=2, cex=2),
#        ylab=list(label="E2 values",  font=2, cex=2),
#        scales=list(font=2, cex=1.5,
#                    y=list(limits=c(-.1,maxylimit))
#                    ),# size of the number labels from the x-y axes
#        grid = TRUE,
#
#        key=list(
#          text = list(c(expression(paste(tau, "=1")),
#                        expression(paste(tau, "=2")),
#                        expression(paste(tau, "=3")),
#                        expression(paste(tau, "=4")),
#                        expression(paste(tau, "=5")),
#                        expression(paste(tau, "=6")),
#                        expression(paste(tau, "=7")),
#                        expression(paste(tau, "=8")),
#                        expression(paste(tau, "=9")),
#                        expression(paste(tau, "=10"))
#          )
#          ),
#          lines = list(pch=c(1:10), col= c(1:10) ),
#          type="b",
#          cex=2, # control the character expansion  of the symbols
#          corner=c(0.95,0.05) # position
#        )
#)
#
#print(plot_e2)
#
#}
#
#

#
# #-----------------------------------------------------------------------------
# #--------------------  Plot E1 values  --------------------------
# plot_E1_values <- function(E,k) {
# plot <- xyplot( E[[1]] +  E[[3]] +  E[[5]]  +  E[[7]] +  E[[9]] +
#           E[[11]] +  E[[13]] +  E[[15]]  +  E[[17]] +  E[[19]]
#         ~ 1: ( length(E) -1),
#         type = "b", lwd=4,
#         pch=1:10, # control the plot characters,
#         col.line= c(1:10),
#         cex=3, # control the characther expansion for characters
#         main=list(label=paste("participant_",k,sep=""), cex=3, fontfamily="Times"), #Control the character expansion ratio (cex)
#         xlab=list(label="Dimension", cex=3, fontfamily="Times"),
#         ylab=list(label="E1 values", cex=3, fontfamily="Times"),
#         scales=list(
#           y=list(limits=c(-0.07,1.15)),
#           font=2, cex=1.5),# size of the number labels from the x-y axes
#         grid = TRUE,
#
#         key=list(
#           text = list(c(expression(paste(tau, "=1")),
#                         expression(paste(tau, "=2")),
#                         expression(paste(tau, "=3")),
#                         expression(paste(tau, "=4")),
#                         expression(paste(tau, "=5")),
#                         expression(paste(tau, "=6")),
#                         expression(paste(tau, "=7")),
#                         expression(paste(tau, "=8")),
#                         expression(paste(tau, "=9")),
#                         expression(paste(tau, "=10"))
#           )
#           ),
#           lines = list(pch=c(1:10), col= c(1:10) ),
#           type="b",
#           cex=2, # control the character expansion  of the symbols
#           corner=c(0.95,0.05) # position
#         )
# )
#
#
# print(plot)
# }
# ##example
# ##plot_E1_values(E,maxdim)
#
#
#
#
# #-----------------------------------------------------------------------------
# #--------------------  Plot E2 values  --------------------------
# plot_E2_values <- function(E,k) {
#   plot <- xyplot( E[[2]] +  E[[4]] +  E[[6]]  +  E[[8]] +  E[[10]] +
#                         E[[12]] +  E[[14]] +  E[[16]]  +  E[[18]] +  E[[20]]
#                       ~ 1: ( length(E) -1),
#                       type = "b", lwd=4,
#                       pch=1:10, # control the plot characters,
#                       col.line= c(1:10),
#                       cex=3, # control the characther expansion for characters
#                   main=list(label=paste("participant_",k,sep=""), cex=3, fontfamily="Times"), #Control the character expansion ratio (cex)
#                       xlab=list(label="Dimension", cex=3, fontfamily="Times"),
#                       ylab=list(label="E2 values", cex=3, fontfamily="Times"),
#                       scales=list(
#                         y=list(limits=c(-0.07,1.15)),
#                         font=2, cex=1.5),# size of the number labels from the x-y axes
#                       grid = TRUE,
#
#                     key=list(
#                       text = list(c(expression(paste(tau, "=1")),
#                                     expression(paste(tau, "=2")),
#                                     expression(paste(tau, "=3")),
#                                     expression(paste(tau, "=4")),
#                                     expression(paste(tau, "=5")),
#                                     expression(paste(tau, "=6")),
#                                     expression(paste(tau, "=7")),
#                                     expression(paste(tau, "=8")),
#                                     expression(paste(tau, "=9")),
#                                     expression(paste(tau, "=10"))
#                       )
#                       ),
#                       lines = list(pch=c(1:10), col= c(1:10) ),
#                       type="b",
#                       cex=2, # control the character expansion  of the symbols
#                       corner=c(0.95,0.05) # position
#                     )
#             )
#
#   print(plot)
#
#
# }
# ##example
# ##plot_E2_values(E,maxdim)
#
#
#
# #
# # #
# # # E1 values
# # #
# # png(filename="E1_values.png", height=900, width=1500,bg="white")
# #
# # dev.off() # Turn off device driver (to flush output to PNG)
# #
# #






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


