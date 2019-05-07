



#mirror_repo <- 'https://www.stats.bris.ac.uk/R/'
#packagename <- 'lattice'
#if (!require(packagename)) install.packages(packagename, repos=mirror_repo, dependencies = TRUE) 

#packagename <- 'plot3D'
#if (!require(packagename)) install.packages(packagename, repos=mirror_repo, dependencies = TRUE) 

#if (!require("lattice")) install.packages("lattice")
#library(lattice) ##xyplot
#library(latticeExtra)  ##overlay xyplots a + as.layer(b)
#require(rgl)




#RSS <- function(Embedded_Matrix)
#{
#.
#.
#.
#  #####  Area Under the Curve
#  auc_cumEigv <- AUC(cumEigv)
#
# #output<-list(  [1] ,      [2]  ,            [3]  ,          [4]  ,      [5],   [6],   [7],     [8] )
#  output<-list(  PC , singular_values  ,  rotateddata  ,   Eigen$values  ,  POV, cumEigv, twoPC, auc_cumEigv )
#}





#
#################################################################################
#################################################################################
#################################################################################
##-------------------- Area Under the Curve -------------------------
#AUC<-function(ce_vector){
#
#  L <- length(ce_vector)
#  dim <- L-1
#
#  x_eigenvalue_number <- (0:dim)
#  y_randomvector <- (0:dim)/dim
#
#
#  #START TRIANGLE
#  d11<-distance_twovectors(x_eigenvalue_number[1],y_randomvector[1] ,x_eigenvalue_number[2],y_randomvector[2])
#  d12<-distance_twovectors(x_eigenvalue_number[2],y_randomvector[2] ,x_eigenvalue_number[2], ce_vector[2])
#  d13<-distance_twovectors(x_eigenvalue_number[2], ce_vector[2]     ,x_eigenvalue_number[1],y_randomvector[1])
#  s1 <- (1/2 )*(d11+d12+d13)
#
#  area_star_triangle <- triangle_area(s1,d11,d12,d13)
#
#
#  #END TRIANGLE
#  d21<-distance_twovectors(x_eigenvalue_number[L],y_randomvector[L] ,x_eigenvalue_number[L-1],y_randomvector[L-1])
#  d22<-distance_twovectors(x_eigenvalue_number[L-1],y_randomvector[L-1] ,x_eigenvalue_number[L-1], ce_vector[L-1])
#  d23<-distance_twovectors(x_eigenvalue_number[L-1], ce_vector[L-1]     ,x_eigenvalue_number[L],y_randomvector[L])
#  s2 <- (1/2 )*(d21+d22+d23)
#
#  area_end_triangle <- triangle_area(s2,d21,d22,d23)
#
#
#
#  # area_of_irregular_polygon
#  areas_of_irregular_polygons  = c()
#  for (pol_i in ( 2:(L-2) )) {
#
#    #message("pol ",pol_i)
#
#    area_of_fist_irregular_polygon <- area_of_irregular_polygon(x_eigenvalue_number[pol_i+1],x_eigenvalue_number[pol_i],
#                                                                y_randomvector[pol_i+1], y_randomvector[pol_i],
#                                                                ce_vector[pol_i+1], ce_vector[pol_i])
#
#    areas_of_irregular_polygons[length(areas_of_irregular_polygons)+1] = area_of_fist_irregular_polygon
#    #message("area ",areas_of_irregular_polygons)
#  }
#
#
#  auc <- area_star_triangle + area_end_triangle + sum(areas_of_irregular_polygons)
#  auc <- round(auc, digits=2)
#
#  return(auc)
#}
#
#
#distance_twovectors <- function (x1,y1,x2,y2){
#  dist <- sqrt( (x2 - x1)^2 +  (y2 - y1)^2   )
#  #dist <- sqrt( (x_eigenvalue_number[1] - x_eigenvalue_number[2])^2 +  (y_randomvector[1] - y_randomvector[2])^2   )
#  return(dist)
#}
#
#
#triangle_area <- function(s,a,b,c){
#  area <- sqrt(  s*(s-a)*(s-b)*(s-c) )
#  return(area)
#}
#
#
#
#################################################################################
#################################################################################
#################################################################################
#area_of_irregular_polygon <-function(xB,xA,yB,yA,pcB,pcA){
#
#    ## area of triangule one
#    bt1 <- xB - xA
#    ht1 <- pcB - pcA
#    at1 <- (1/2) * bt1 * ht1
#
#
#    bt2 <- xB - xA
#    ht2 <- yB - yA
#    at2 <- (1/2) * bt2 * ht2
#
#    # area of rectangle
#    s1 <- pcB - yA
#    s2 <- xB - xA
#    ar <- s1*s2
#
#      area <- ar - (at1+at2)
#
##
##   #FIRST polygon
##   ## area of triangule one
##
##   bt1 <- x_eigenvalue_number[3] - x_eigenvalue_number[2]
##   ht1 <- ce_vector[3] - ce_vector[2]
##   at1 <- (1/2) * bt1 * ht1
##
##   ## area of triangel two
##
##   bt2 <- x_eigenvalue_number[3] - x_eigenvalue_number[2]
##   ht2 <- y_randomvector[3] - y_randomvector[2]
##   at2 <- (1/2) * bt2 * ht2
##
##   # area of rectangle
##
##   s1 <- ce_vector[3] - y_randomvector[2]
##   s2 <- x_eigenvalue_number[3] - x_eigenvalue_number[2]
##   ar <- s1*s2
##
##   area_of_fist_irregular_polygon <- ar - (at1+at2)
##  0.2687141
#  return(area)
#}
## Usage
## area_of_fist_irregular_polygon <- area_of_irregular_polygon(x_eigenvalue_number[3],x_eigenvalue_number[2],
##                                                             y_randomvector[3], y_randomvector[2],
##                                                             ce_vector[3], ce_vector[2])
##
## message("area ",area_of_fist_irregular_polygon)
##
#





#
#################################################################################
#################################################################################
#################################################################################
##-------------------- Percentage of Cumulative Energy -------------------------
#plot_CE<-function(e_cum , i_cum,n_cum,dim){
#
#  ploting <-
#    xyplot(e_cum + i_cum + n_cum +c (0:dim)/dim ~  c(0:dim),
#           col.line = c("red","blue","green3","black"), type = c("b"), lwd=4, lty=c(2,3,4,1),
#           pch=1:4,cex=3, # control the characther expansion for characters
#           main=list(label="", cex=2.5),
#           xlab=list(label="Eigenvalue number",font=2, cex=1.5),
#           ylab=list(label="Cumulative Energy %",font=2, cex=1.5),
#           grid = TRUE,
#           scales=list(font=1, cex=1.5,
#                       y=list(at=seq(0,1,.5)),x=list(at=seq(0,dim,1))  ),
#
#           key=list(
#             text = list(c(expression("x"),
#                           expression("y"),
#                           expression("z")
#             ), cex=2 ),
#             corner=c(0.95,0.05), # position
#             lines = list(pch=c(1:3), col= c('red','blue','green3') ),
#             type="b", lwd=6,lty=c(2,3,4),
#             cex=3 # control the character expansion  of the symbols
#           )
#    )
#
#
#
#  print(ploting)
#
#}
#
#
#################################################################################
#################################################################################
#################################################################################
#plot_CE_xyz<-function(x_cum,x_area,y_cum,y_area,z_cum,z_area,dim,tau){
#
#  ploting <-
#    xyplot(x_cum + y_cum + z_cum +c (0:dim)/dim ~  c(0:dim),
#           col.line = c("red","blue","green3","black"), type = c("b"), lwd=4, lty=c(2,3,4,1),
#           pch=1:4,cex=3, # control the characther expansion for characters
#           main=list(label= paste0("m=", dim, " T=", tau),font=1, cex=1),
#           xlab=list(label="Eigenvalue number",font=2, cex=1.5),
#           ylab=list(label="Cumulative Energy %",font=2, cex=1.5),
#           grid = TRUE,
#           scales=list(font=1, cex=1.5,
#                       y=list(at=seq(0,1,.5)),x=list(at=seq(0,dim,1))  ),
#
#           key=list(
#             text = list(c( paste0("x auc:", x_area),
#                            paste0("y auc:", y_area),
#                            paste0("z auc:", z_area)
#             ), cex=2 ),
#             corner=c(0.95,0.05), # position
#             lines = list(pch=c(1:3), col= c('red','blue','green3') ),
#             type="b", lwd=6,lty=c(2,3,4),
#             cex=3 # control the character expansion  of the symbols
#           )
#    )
#
#
#
#  print(ploting)
#
#}
#
#
#################################################################################
#################################################################################
#################################################################################
#plot_CE_testing<-function(cumEigv,area,dim,tau){
#
#  ploting <-
#    xyplot(cumEigv +c (0:dim)/dim ~  c(0:dim),
#           col.line = c("red","black"), type = c("b"), lwd=4, lty=c(4,1),
#           pch=c(4,1),cex=3, # control the characther expansion for characters
#           main=list(label= paste0("m=", dim, " T=", tau),font=1, cex=1),
#           xlab=list(label="Eigenvalue number",font=2, cex=1.5),
#           ylab=list(label="Cumulative Energy %",font=2, cex=1.5),
#           grid = TRUE,
#           scales=list(font=1, cex=1.5,
#                       y=list(at=seq(0,1,.5)),x=list(at=seq(0,dim,1))  ),
#
#           key=list(
#             text = list(c(expression("CEC"),
#                           expression("")
#             ), cex=2 ),
#             corner=c(0.95,0.05), # position
#             lines = list(pch=c(4,1), col= c('red','black') ),
#             type="b", lwd=6,lty=c(4,1),
#             cex=3 # control the character expansion  of the symbols
#           ),
#           panel = function(...) {
#             panel.text(dim/3, 1/2, paste0("AUC: ", area), cex=2, srt = 45)
#             panel.xyplot(...)
#           }
#    )
#
#  print(ploting)
#
#}
## Usage of plot_CE_testing(cumEigv,area,dim,tau)
## plot_CE_testing(RSS[[6]],RSS[[8]],dim_i,tau_j)
#
#
#
#################################################################################
#################################################################################
#################################################################################
##-------------------- Plot Percentage of Variances --------------------------
#Plot_PV_testing  <- function(PCAMatrix,dim,tau){
#
#  maxdim <- length(PCAMatrix)
#
#
#  df.eig <- data.frame(dim = factor(1:maxdim), eig=PCAMatrix, pov=paste0(  round(PCAMatrix,0), ""))  ## 22 %
#  #df.eig <- data.frame(dim = factor(1:maxdim), eig=PCAMatrix, pov=paste0(  round(PCAMatrix,1), "%")) ## 22.1 %
#
#
#
#
#  plotPV <-
#    ggplot(data=df.eig, aes(dim, eig, group=1)) +
#    geom_bar(stat="identity", fill="steelblue") +
#    geom_text( aes(label= pov), vjust=-0.5, hjust=0.5, color="black", size=10 ) + #text over bars
#    geom_line() +
#    geom_point(colour = "black", size = 3) +
#    labs(title = paste0("m=", dim, ", T=",tau), x = "Dimension", y = "Percentage of variances", size=12) +
#    theme(axis.text=element_text(color="black",size=15),
#           axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=25),
#           panel.background = element_rect(fill = "white",
#                                           colour = "white",
#                                           size = 0.5, linetype = "solid"),
#           panel.grid.major = element_line(size = 0.5, linetype = 'solid',
#                                           colour = "gray"),
#           panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
#                                           colour = "gray")) +
#  coord_cartesian(xlim=c(-0.1,maxdim+1),ylim=c(0,100))
#
#
#  print(plotPV)
#}
## Usage of Plot_PV_testing(PCAMatrix,dim,tau)
## Plot_PV_testing(pcamatrix[[5]],dim_i,tau_j)
#
#



#
#################################################################################
#################################################################################
#################################################################################
##-------------------- Plot State Space  --------------------------
#Plot_2D_Embedded_State_Space <- function(X1,X2, dim, tau, colour, maxplotlenght){
#
#  N <- length(X1)
#
#
#  phasespaceplot <- xyplot(X1 ~ X2,
#                           type = c("o"),
#                           col.line = c(colour),
#                           lwd=2,
#                           xlab=list(label="x(t)", cex=1.5, fontfamily="Times"),
#                           ylab=list(label="x(t-T)", cex=1.5, fontfamily="Times"),
#                           scales = list(font=1, cex=1
#                                         ,x=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                                         ,y=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                           ),
#                           key=list(
#
#                             text = list( paste( "[",N,"x",dim,"]","   m=",dim," T=",tau,sep="")   ),
#                             cex=2, # control the character expansion  of the symbols
#                             corner=c(0,0.95) # position
#                           ),
#
#
#                           panel = function(...) {
#                             panel.abline(h = 0, v = 0, lwd=0.5, lty = 1)
#                             panel.xyplot(...)
#                           }
#
#  )
#
#  print(phasespaceplot)
#
#
#}
#





#################################################################################
#################################################################################
#################################################################################
## Plot_3D_Embedded_State_Space
#Plot_3D_Embedded_State_Space  <- function(X1,X2,X3,dim,tau,colour){
#
#  rgl.open()
#  rgl.clear()
#  bg3d("white") # background color
#  light3d()
#  #rgl.linestrips(PCAMatrix[1,],PCAMatrix[2,],PCAMatrix[3,],color=c(colour), alpha=0.9, lwd =1)
#  #rgl.viewpoint( theta = 0, phi = 15, fov = 60, zoom = .8, scale = par3d("scale"), interactive = TRUE)
#  #rgl.linestrips(PCAMatrix[1,],PCAMatrix[3,],PCAMatrix[5,],color=c(colour), alpha=0.9, lwd =2)
#
#
#  rgl.spheres(X1,X2,X3, r = 0.05, color =c(colour))
#
#  #rgl.linestrips(X1,X2,X3,color=c(colour), alpha=0.9, lwd =1)
#  rgl.viewpoint( theta = 270, phi = 1, fov = 60, zoom = .8, scale = par3d("scale"), interactive = TRUE)
#
#
#  #axis labels
#  rgl.material(
#    color = c("black")
#  )
#
#  axes3d()
#  #   #axis3d('x',pos=c(NA, 0, 0))
#
#
#
#  title3d(paste("embed, m=",dim," T=",tau,sep=""),'','x(t)','x(t-T)','x(t-2T)')
#
#  rgl.bringtotop()
#  #  rgl.snapshot("hola.jpg")
#
#}
##
#














#################################################################################
#################################################################################
#################################################################################
## Plot _2D_State Space
#Plot_2D_State_Space <- function(PCAMatrix, colour, maxplotlenght){
#
#
#  phasespaceplot <- xyplot(PCAMatrix[1,] ~ PCAMatrix[2,],
#                     type = c("l"),
#                     col.line = c(colour),
#                     lwd=2,
#                     xlab=list(label="PC2", cex=1.5, fontfamily="Times"),
#                     ylab=list(label="PC1", cex=1.5, fontfamily="Times"),
#                     scales = list(font=1, cex=1
#                                   ,x=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                                   ,y=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                     ),
#                     panel = function(...) {
#                       panel.abline(h = 0, v = 0, lwd=0.5, lty = 1)
#                       panel.xyplot(...)
#                     }
#
#                     )
#
#  print(phasespaceplot)
#
#
#}
#



#################################################################################
#################################################################################
#################################################################################
## Plot _2D_State Space
#Plot_2D_State_Space_testing <- function(PCAMatrix, colour, maxplotlenght){
#
#  N <- length(PCAMatrix[[1]][1,])
#
#
#  phasespaceplot <- xyplot(PCAMatrix[[1]][1,] ~ PCAMatrix[[1]][2,],
#                           type = c("o"),
#                           cex=1.4,
#                           col.line = c(colour),
#                           lwd=4,
#                           xlab=list(label="", cex=1, fontfamily="Times"), #PC2
#                           ylab=list(label="", cex=1, fontfamily="Times"), #PC1
#                           scales = list(font=1, cex=.7
#                                         ,x=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                                         ,y=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                           ),
#
##                           key=list(
##                             text = list( paste( "[",N,"x",dim,"]","   m=",dim," T=",tau,sep="")   ),
##                             cex=2, # control the character expansion  of the symbols
##                             corner=c(0,0.95) # position
##                           ),
#
#                           panel = function(...) {
#                             panel.abline(h = 0, v = 0, lwd=0.5, lty = 1)
#                             panel.xyplot(...)
#                           }
#
#  )
#
#  print(phasespaceplot)
#
#}
##
##   #output<-  list(  [1] ,      [2]  ,            [3]  ,          [4]  ,      [5],   [6],   [7],     [8] )
## PCA output   list(  P , singular_values  ,  rotateddata  ,   Eigen$values  ,  POV, cumEigv, twoPC, auc_cumEigv )
##
## Usage of Plot_2D_State_Space_testing(PCAMatrix,colour, maxplotlenght). Examples
## Plot_2D_State_Space_testing(RSS,'red', 5)
## Plot_2D_State_Space_testing(tempepca, "red",0.3)
#


#################################################################################
#################################################################################
#################################################################################
#Plot_2D_State_Space_testing_two <- function(PCAMatrix,dim,tau, colour, maxplotlenght){
#
#  N <- length(PCAMatrix[[1]][1,])
#
#
#  phasespaceplot <- xyplot(PCAMatrix[[1]][1,] ~ PCAMatrix[[1]][2,],
#                           type = c("o"),
#                           cex=1.4,
#                           col.line = c(colour),
#                           lwd=4,
#                           xlab=list(label="", cex=1, fontfamily="Times"), #PC2
#                           ylab=list(label="", cex=1, fontfamily="Times"), #PC1
#                           scales = list(font=1, cex=.7
#                                         ,x=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                                         ,y=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                           ),
#
#                          key=list(
#                            text = list( paste( "[",N,"x",dim,"]","   m=",dim," T=",tau,sep="")   ),
#                            cex=2, # control the character expansion  of the symbols
#                            corner=c(0,0.95) # position
#                          ),
#
#                           panel = function(...) {
#                             panel.abline(h = 0, v = 0, lwd=0.5, lty = 1)
#                             panel.xyplot(...)
#                           }
#
#  )
#
#  print(phasespaceplot)
#
#
#}
## Usage of Plot_2D_State_Space_testing_two (PCAMatrix,dim,tau, colour, maxplotlenght). Examples
## Plot_2D_State_Space_testing_two(RSS,dim_i,tau_j, 'red', 5)
#
#

#################################################################################
#################################################################################
#################################################################################
## Plot_2D_State Space XYZ
#Plot_2D_State_Space_XYZ <- function(PCAMatrix_X,PCAMatrix_Y,PCAMatrix_Z, maxplotlenght, Sensor){
#
#
#  #phasespaceplot <- xyplot(PCAMatrix_X[1,] ~ PCAMatrix_X[2,]+PCAMatrix_Y[1,] ~ PCAMatrix_Y[2,],
#  phasespaceplot_x <- xyplot(PCAMatrix_X[1,] ~ PCAMatrix_X[2,],
#                           type = c("l"),
#                           col.line = "red",
#                           lwd=2,
#                           xlab=list(label="PC2", cex=1.5, fontfamily="Times"),
#                           ylab=list(label="PC1", cex=1.5, fontfamily="Times"),
#                           scales = list(font=1, cex=1
#                                         ,x=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                                         ,y=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                           ),
#                           key=list(
#                             #border= "grey",
#                             text = list(c(   paste(Sensor,"x",sep="") , paste(Sensor,"y",sep=""),  paste(Sensor,"z",sep="") )),
#                             #text = list(c(   paste(Sensor,"[x]",sep="") , expression(  A[y]    ), expression(  A[z]  ))),
#                             lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')),
#                             type="l", lwd=2,
#                             cex=1, # control the character expansion  of the symbols
#                             corner=c(1,0) # position
#                           )
#                           ,
#                           panel = function(...) {
#                             panel.abline(h = 0, v = 0, lwd=0.5, lty = 1)
#                             panel.xyplot(...)
#                           }
#  )
#
#
#
#
#  phasespaceplot_y <- xyplot(PCAMatrix_Y[1,] ~ PCAMatrix_Y[2,],
#                             type = c("l"),
#                             col.line = "blue",
#                             lwd=2,
#                             xlab=list(label="PC2", cex=1.5, fontfamily="Times"),
#                             ylab=list(label="PC1", cex=1.5, fontfamily="Times"),
#                             scales = list(font=1, cex=1
#                                           ,x=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                                           ,y=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                             )
#  )
#
#
#  phasespaceplot_z <- xyplot(PCAMatrix_Z[1,] ~ PCAMatrix_Z[2,],
#                             type = c("l"),
#                             col.line = "yellow3",
#                             lwd=2,
#                             xlab=list(label="PC2", cex=1.5, fontfamily="Times"),
#                             ylab=list(label="PC1", cex=1.5, fontfamily="Times"),
#                             scales = list(font=1, cex=1
#                                           ,x=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                                           ,y=list(at=seq(-maxplotlenght,maxplotlenght,maxplotlenght/2),limits=c(-maxplotlenght-(0.1*maxplotlenght),maxplotlenght+(0.1*maxplotlenght)))
#                             )
#)
#
#
#  print(
#  phasespaceplot_x + as.layer(phasespaceplot_y) + as.layer(phasespaceplot_z)
#  )
#}
## Usage of Plot_2D_State_Space_XYZ(PCAMatrix_X,PCAMatrix_Y,PCAMatrix_Z, maxplotlenght, Sensor)
#
#






#################################################################################
#################################################################################
#################################################################################
##  Plot_State Space function
##
#Plot_3D_State_Space  <- function(PCAMatrix,dim,tau,colour,imu,axis){
#
#  rgl.open()
#  rgl.clear()
#  bg3d("white") # background color
#  light3d()
#  #rgl.linestrips(PCAMatrix[1,],PCAMatrix[2,],PCAMatrix[3,],color=c(colour), alpha=0.9, lwd =1)
#  #rgl.viewpoint( theta = 0, phi = 15, fov = 60, zoom = .8, scale = par3d("scale"), interactive = TRUE)
#  #rgl.linestrips(PCAMatrix[1,],PCAMatrix[3,],PCAMatrix[5,],color=c(colour), alpha=0.9, lwd =2)
#
#
#  rgl.linestrips(PCAMatrix[1,],PCAMatrix[2,],PCAMatrix[3,],color=c(colour), alpha=0.9, lwd =1)
#  rgl.viewpoint( theta = 270, phi = 1, fov = 60, zoom = .8, scale = par3d("scale"), interactive = TRUE)
#
#
#  #axis labels
#  rgl.material(
#    color = c("black")
#  )
#
#  axes3d()
#  #   #axis3d('x',pos=c(NA, 0, 0))
#
#
#
#  title3d(paste(imu,"_",axis," m=",dim,"t=",tau,sep=""),'','PC1','PC2','PC3')
#
#  rgl.bringtotop()
#  #  rgl.snapshot("hola.jpg")
#
#}
##      Plot_State_Space(pcamatrix[[3]],dim_i,tau_j, colour,imu,axis)
#
#
#

#
##################################################################################
##################################################################################
##################################################################################
##Plot_3D_State_Space_testing  <- function(PCAMatrix,dim,tau,colour){
##
##  rgl.open()
##  rgl.clear()
##  bg3d("white") # background color
##  light3d()
##  #rgl.linestrips(PCAMatrix[1,],PCAMatrix[2,],PCAMatrix[3,],color=c(colour), alpha=0.9, lwd =1)
##  #rgl.viewpoint( theta = 0, phi = 15, fov = 60, zoom = .8, scale = par3d("scale"), interactive = TRUE)
##  #rgl.linestrips(PCAMatrix[1,],PCAMatrix[3,],PCAMatrix[5,],color=c(colour), alpha=0.9, lwd =2)
##
##
##  #rgl.linestrips(PCAMatrix[1,],PCAMatrix[2,],PCAMatrix[3,],color=c(colour), alpha=0.9, lwd =1)
##
##  rgl.spheres(PCAMatrix[1,],PCAMatrix[2,],PCAMatrix[3,], r = 0.05, color =c(colour))
##  rgl.viewpoint( theta = 270, phi = 1, fov = 60, zoom = .8, scale = par3d("scale"), interactive = TRUE)
##
##
##  #axis labels
##  rgl.material(
##    color = c("black")
##  )
##
##  axes3d()
##  #   #axis3d('x',pos=c(NA, 0, 0))
##
##
##
##  title3d(paste(" pca, m=",dim,"t=",tau,sep=""),'','PC1','PC2','PC3')
##
##  rgl.bringtotop()
##  #  rgl.snapshot("hola.jpg")
##
##}
###
###   #output<-  list(  [1] ,      [2]  ,            [3]  ,          [4]  ,      [5],   [6],   [7],     [8] )
### PCA output   list(  P , singular_values  ,  rotateddata  ,   Eigen$values  ,  POV, cumEigv, twoPC, auc_cumEigv )
###
### Usage of Plot_3D_State_Space_testing(PCAMatrix,dim,tau,colour). Examples:
###
### Plot_State_Space(pcamatrix[[3]],dim_i,tau_j, colour,imu,axis)
### Plot_3D_State_Space_testing(RSS[[3]],dim_i,tau_j,'red')
##
##
#
#





#################################################################################
#################################################################################
#################################################################################
#
#library(plot3D)
#plotRSS2D <-function (PCAMatrix,maxlimit)
#{
#
#
#  #   #output<-  list(  [1] , ...
#  # PCA output   list(  P , ...
#
#### Principal Components
#N <- length(PCAMatrix[[1]][1,])
#col.v <- 1:N
#x <- PCAMatrix[[1]][1,]
#y <- PCAMatrix[[1]][2,]
#
#
#scatter2D(
#     x, y, colvar = col.v, bty = "n", pch = ".",
#     type='l', lwd=5,
#     cex = 5,
#     main = "",
#     xlab = 'PC1', ylab ='PC2',
#     colkey = list(side = 4, plot = TRUE, length = 1, width = 0.5),
#     xlim = c(-maxlimit,maxlimit), ylim=c(-maxlimit,maxlimit)
#     )
#
#}
##
##
## Usage of plotRSS3D2D(PCAMatrix). Example
## plotRSS2D(RSS, 0.3)
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
#################################################################################
#################################################################################
#################################################################################
#
#library(plot3D)
#plotRSS3D2D <-function (PCAMatrix)
#{
#
#par(mfrow = c(1, 4), mar = c(5, 3, 5, 3))
#
#### Principal Components
#N <- length(PCAMatrix[[1]][1,])
#col.v <- 1:N
#x <- PCAMatrix[[1]][1,]
#y <- PCAMatrix[[1]][2,]
#z <- PCAMatrix[[1]][3,]
#
#### rotateddata
## N <- length(PCAMatrix[[3]][1,])
## col.v <- 1:N
## x <- PCAMatrix[[3]][1,]
## y <- PCAMatrix[[3]][2,]
## z <- PCAMatrix[[3]][3,]
#
#
#scatter3D(
#  	x, y, z, colvar = col.v, 
#	bty = "b2", 
#	type = "l", 
#	lwd=5,
# 	axis.scales = TRUE,
## 	# xlim=c(-1,1),ylim= c(-1,1),zlim=c(-10,30),
#   main = "XYZ",
#   xlab = 'PC1', ylab ='PC2', zlab = 'PC3'
#  #  colkey = list(length = 0.3, width = 0.8, cex.clab = 0.75)
#   )
#
#scatter2D(
#     x, y, colvar = col.v, bty = "n", pch = ".",
#     type='l', lwd=5,
#     cex = 5, colkey = TRUE,
#     main = "PC1~PC2",
#     xlab = 'PC1', ylab ='PC2'
#     )
#
#scatter2D(
# y, z, colvar = col.v, bty = "n", pch = ".",
# type='l', lwd=5,
# cex = 5, colkey = TRUE,
# main = "PC2~PC3",
# xlab = 'PC2', ylab ='PC3'
# )
#
#scatter2D(
# x, z, colvar = col.v, bty = "n", pch = ".",
# type='l', lwd=5,
# cex = 5, colkey = TRUE,
# main = "PC1~PC3",
# xlab = 'PC1', ylab ='PC3'
# )
#
#
#
#}
##
##   #output<-  list(  [1] ,      [2]  ,            [3]  ,          [4]  ,      [5],   [6],   [7],     [8] )
## PCA output   list(  P , singular_values  ,  rotateddata  ,   Eigen$values  ,  POV, cumEigv, twoPC, auc_cumEigv )
##
## Usage of plotRSS3D2D(PCAMatrix). Example
## plotRSS3D2D(RSS)
#
#


#





##--------------------  split_path function  --------------------------
## Usage of split_path
## >  paths[3]
## [1] "./gestures/continuous"
## > split_path(paths[3])
## [1] "."          "gestures"   "continuous"
##
##http://stackoverflow.com/questions/29214932/split-a-file-path-into-folder-names-vector
#split_path <- function(path) {
#   (setdiff(strsplit(path,"/|\\\\")[[1]], ""))
#}




#
#
#
#
#################################################################################
#################################################################################
#################################################################################
#euclidean.distances <- function(PCAMatrix){
#
#  N <- length(PCAMatrix[[1]][1,])
#
#
#  euc.dist <- function(x2, y2){
#      sqrt(  sum (  (x2)^2 + (y2)^2   ))
#    }
#
#  distances <- c()
#    for (i in 1:N)
#    {
#      distances <- c(distances, euc.dist( PCAMatrix[[1]][1,i], PCAMatrix[[1]][2,i] ))
#    }
#
#    return <- distances
#
#}
#
#
#
#################################################################################
#################################################################################
#################################################################################
#euclidean.distances_rotateddata <- function(PCAMatrix){
#
#
#  #   #output<-  list(  [1] ,      [2]  ,            [3]  ,    ...
#  # PCA output   list(  P , singular_values  ,  rotateddata  , ...
#
#
#  N <- length(PCAMatrix[[3]][1,])
#
#
#  euc.dist <- function(x2, y2){
#      sqrt(  sum (  (x2)^2 + (y2)^2   ))
#    }
#
#  distances <- c()
#    for (i in 1:N)
#    {
#      distances <- c(distances, euc.dist( PCAMatrix[[3]][1,i], PCAMatrix[[3]][2,i] ))
#    }
#
#    return <- distances
#}
## Usage
## euclidean.distances_rotateddata(RSS)
#
#
#
#










