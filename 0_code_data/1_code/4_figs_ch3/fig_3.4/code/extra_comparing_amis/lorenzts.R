#############
## LORENZ ATTRACTOR##
#############
##http://fractalswithr.blogspot.mx/2007/04/lorenz-attractor.html
require(rgl)
library(lattice) ##xyplot

a=10; r=28; b=8/3; dt=0.01
X=0.01; Y=0.01; Z=0.01

n=6000
XYZ=array(0,dim=c(n,3))
t=0

for(i in 1:n)
{
  X1=X; Y1=Y; Z1=Z

  X=X1+(-a*X1+a*Y1)*dt
  Y=Y1+(-X1*Z1+r*X1-Y1)*dt
  Z=Z1+(X1*Y1-b*Z1)*dt
  #t=t+dt
  XYZ[i,]=c(X,Y,Z)
}


framewindow <- 1000:5000;

x=XYZ[framewindow,1]
y=XYZ[framewindow,2]
z=XYZ[framewindow,3]

write(x, file="datafile",ncolumns=1)

## 2D plot
p <- xyplot( x ~ framewindow ,
        pch=16, col.line = c('royalblue'), type = c("l","g"), lwd=5,
        xlab=list(label="samples", cex=4),
        ylab=list(label="", cex=4),
        scales=list(font=1, cex=2.5)
)

plot(p)

# ## 3D plot
# rgl.open()
# rgl.clear()
# rgl.linestrips(x,y,z)
# axes3d()
# axis3d('x',pos=c(NA, 0, 0))
# title3d('Lorenz Attractor','','x','y','z')
# rgl.bringtotop()
