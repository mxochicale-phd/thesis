#------------------------------------------------------------
#   Functions
#   Ollin Cencah <-> Movimiento eterno <-> Eternal Movement
#
#
#
# Written by Miguel Xochicale [http://mxochicale.github.io]
#
#
#------------------------------------------------------------


## LOADING FUNCTIONS
#github_path <- getwd()
#source( paste(github_path,'/hwum-dataset/r-scripts/functions/ollin_cencah.R',sep='') )

## LOADING LIBRARIES
library(ggplot2) ## percentage of variance bar plot
require(tseriesChaos) # for embed()
library(plot3D) # for plotRSS2D_rotateddata <-function (PCAMatrix,maxlimit)



################################################################################
################################################################################
################################################################################
#-------------------- zero mean unit variance function  --------------------------

#Sphering the data (whitening)
zeromean_unitvariance <- function ( x )
{
  # convert data as a matrix object
  x <- as.matrix(x)

  #column zero mean
  mx <- mean( x )

  zmx <-  x - matrix(rep( mx,dim(x)[1] ),ncol=dim(x)[2])

  sd_zmx <- sd(zmx)
  zmuv <- zmx/sd_zmx
  return( zmuv )
}






################################################################################
################################################################################
################################################################################
#--------------------    Uniform Time Delay Embedding  --------------------------
#--------------------    Takens Theorem  --------------------------
#

UTDE <- function(timeserie,dim,tau,print_Xdims=FALSE)
{
  timedelayembedded <- embedd(timeserie,  m=dim, d=tau)

  if (print_Xdims == TRUE ){
    message("  --------------")
    message("  Embedded Parameters:   " ,"m=",dim," tau=",tau,sep="" )
    message("  Embedded Matrix dimension:  ",dim(timedelayembedded)[1], 'x' ,dim(timedelayembedded)[2] )
    message("  --------------")
  }

  return (timedelayembedded)
}
# example:
# UTDE(1:10, 10, 1, TRUE)
# UTDE(1:10, 10, 1, print_Xdims=FALSE)





################################################################################
################################################################################
################################################################################
#----- Reconstructed State Space with Principal Component Analysis  ---------
#-------------------- RSS with PCA  --------------------------
RSS <- function(Embedded_Matrix)
{
  #For further testing
  #http://www.sthda.com/english/wiki/principal-component-analysis-in-r-prcomp-vs-princomp-r-software-and-data-mining


  # Center the data so that the mean of each row is 0
  rm <- rowMeans(t(Embedded_Matrix));
  X <- t(Embedded_Matrix  - t((matrix(rep(rm,dim(Embedded_Matrix)[1]),nrow=dim(Embedded_Matrix)[2]))))

  # Covariance Matrix
  E  <- X %*% t(X)
  Eigen <- eigen(E,TRUE)

  Evalues <- Eigen$values
  PC <- t(Eigen$vectors) # Principal Components


  #the standard deviations of the principal components
  #sdev_method1= sqrt(Eigen$values)
  singular_values <- sqrt(   diag(   ( 1 /(dim(X)[2]-1)*PC%*% E %*% t(PC) )   )   )
  ### when obtaining the square root with sqrt( of the diagonal )
  ### some values are very little (e.g. 2.558211e-17 -1.518796e-16)
  ### so that the result is NaN
  # R cannot calculate the square root and warns you that the square root of a negative number is not a number (NaN).
  #(i.e., the square roots of the eigenvalues of the covariance/correlation matrix).
  singular_values <- replace(singular_values, is.nan(singular_values), 0)
  #http://stackoverflow.com/questions/18142117/how-to-replace-nan-value-with-zero-in-a-huge-data-frame


  # Find the new data ##Rotated data
  rotateddata <- PC %*% X


  #Percentage Of Variance
  POV <- ( Evalues/sum(Evalues) )*100
  #http://stats.stackexchange.com/questions/31908/what-is-percentage-of-variance-in-pca

  #cummulative energy of PCA
  cumEigv <- c(0, cumsum(POV) ) /100


  ####PRINT C1 C2 C1+C2
  twoPC <- c( POV[1:2], sum(POV[1:2]) )


  #output<-list(  [1] ,      [2]  ,            [3]  ,          [4]  ,      [5],   [6],   [7] )
  output<-list(  PC , singular_values  ,  rotateddata  ,   Eigen$values  ,  POV, cumEigv, twoPC )

  return(output)

}
#Usage
#        RSS(Embedded_Matrix)
# Ymt <- RSS( Xmt )








################################################################################
################################################################################
################################################################################
plotRSS2D_rotateddata <-function (Ymt,max_axis_limit)
{

## output of Ymt using RSS()
#  output<-  list(  [1] ,      [2]  ,            [3]  ,    ...
#   output   list(  PC , singular_values  ,  rotateddata  , ...

## rotateddata
N <- length(Ymt[[3]][1,])
col.v <- 1:N
x <- Ymt[[3]][1,]
y <- Ymt[[3]][2,]


scatter2D(
     x, y, colvar = col.v, bty = "n", pch = ".",
     type='l', lwd=5,
     cex = 5,
     main = "",
     xlab = 'y0', ylab ='y1',
     colkey = list(side = 4, plot = TRUE, length = 1, width = 0.5),
     xlim = c(-max_axis_limit,max_axis_limit), ylim=c(-max_axis_limit,max_axis_limit)
     )

}
# Usage plotRSS2D_rotateddata(Ymt,max_axis_limit)
# plotRSS2D_rotateddata(Ymt, 10)





################################################################################
################################################################################
################################################################################

plotRSS3D_rotateddata <-function (Ymt, Nx, dim, tau, sample_rate)
{

## output of Ymt using RSS()
#  output<-  list(  [1] ,      [2]  ,            [3]  ,    ...
#  output   list(  PC , singular_values  ,  rotateddata  , ...

## rotateddata
NN <- length(Ymt[[3]][1,])
L <- Nx-((dim-1)*tau)
diff<- (Nx-L)+1
time <- (diff:Nx)/sample_rate

col.v <- time
x <- Ymt[[3]][1,]
y <- Ymt[[3]][2,]
z <- Ymt[[3]][3,]


scatter3D(
  	x, y, z, 
	colvar = col.v, 
	bty = "b2", 
	type = "l", 
	lwd=6,
 	#axis.scales = TRUE,
	# xlim=c(-1,1),ylim= c(-1,1),zlim=c(-10,30),
	# main = "",
	xlab = 'y0', ylab ='y1', zlab = 'y2',
	cex.lab = 2,# change font size of the labels 
	colkey = list(
		dist = -0.06, # distance from the main plot
		side=4,
		length = 0.5, 
		width = 0.9, 
		shift = 0.0,
		line.clab = 2,
		cex.axis =2, # font size for numbers
		cex.clab = 2,# font size of clab for col key
		addlines=FALSE),
	clab = "(secs)"# label for col key
   )

}
# Usage 
# plotRSS3D_rotateddata(Ymt)







################################################################################
################################################################################
################################################################################

plotRSS3D2D_rotateddata <-function (Ymt)
{

par(mfrow = c(1, 4), mar = c(5, 3, 5, 3))

## rotateddata
 N <- length(Ymt[[3]][1,])
 col.v <- 1:N
 x <- Ymt[[3]][1,]
 y <- Ymt[[3]][2,]
 z <- Ymt[[3]][3,]


scatter2D(
     x, y, colvar = col.v, bty = "n", pch = ".",
     type='l', lwd=5,
     cex = 5, colkey = TRUE,
    # main = "PC1~PC2",
     xlab = 'y0', ylab ='y1'
     )

scatter2D(
 y, z, colvar = col.v, bty = "n", pch = ".",
 type='l', lwd=5,
 cex = 5, colkey = TRUE,
 #main = "PC2~PC3",
 xlab = 'y1', ylab ='y2'
 )

scatter2D(
 x, z, colvar = col.v, bty = "n", pch = ".",
 type='l', lwd=5,
 cex = 5, colkey = TRUE,
 #main = "PC1~PC3",
 xlab = 'y0', ylab ='y2'
 )


scatter3D(
  	x, y, z, colvar = col.v, 
	bty = "b2", 
	type = "l", 
	lwd=5,
 	#axis.scales = TRUE,
# 	# xlim=c(-1,1),ylim= c(-1,1),zlim=c(-10,30),
  # main = "",
   xlab = 'y0', ylab ='y1', zlab = 'y2'
  #  colkey = list(length = 0.3, width = 0.8, cex.clab = 0.75)
   )



}
# Usage 
# plotRSS3D2D_rotateddata(Ymt)






