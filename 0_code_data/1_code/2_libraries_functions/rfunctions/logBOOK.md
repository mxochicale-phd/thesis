logBOOK
---




## TODO


* [ ] clean this path  
	added: Fri 27 Jul 10:27:28 BST 2018  



* [ ] revise the following commented functions `funcs2revise.r`  

* `AUC in RSS()`
* `#AUC<-function(ce_vector){`
* `#area_of_irregular_polygon <-function(xB,xA,yB,yA,pcB,pcA){`
* `#plot_CE<-function(e_cum , i_cum,n_cum,dim){`
* `#plot_CE_xyz<-function(x_cum,x_area,y_cum,y_area,z_cum,z_area,dim,tau){`
* `#plot_CE_testing<-function(cumEigv,area,dim,tau){`
* `#Plot_PV_testing  <- function(PCAMatrix,dim,tau){`
* `#* `#Plot_2D_Embedded_State_Space <- function(X1,X2, dim, tau, colour, maxplotlenght){`
* `#Plot_3D_Embedded_State_Space  <- function(X1,X2,X3,dim,tau,colour){`
* `#Plot_2D_State_Space <- function(PCAMatrix, colour, maxplotlenght){`
* `#Plot_2D_State_Space_testing <- function(PCAMatrix, colour, maxplotlenght){`
* `ot_2D_State_Space_testing_two <- function(PCAMatrix,dim,tau, colour, maxplotlenght){`
* `#Plot_2D_State_Space_XYZ <- function(PCAMatrix_X,PCAMatrix_Y,PCAMatrix_Z, maxplotlenght, Sensor){`
* `#Plot_3D_State_Space  <- function(PCAMatrix,dim,tau,colour,imu,axis){`
* `#Plot_3D_State_Space_testing  <- function(PCAMatrix,dim,tau,colour){`
* `#plotRSS3D2D <-function (PCAMatrix)`
* `#plotRSS2D <-function (PCAMatrix,maxlimit)`
* `## split_path function  `

added: Wed 30 May 22:06:27 BST 2018
sorted: 



* [ ] replace the follwing libraries with ggplot2 and plot3D libs
	```
	#library(lattice) ##xyplot
	#library(latticeExtra)  ##overlay xyplots a + as.layer(b)
	#require(rgl)
	```
	and update the lines of code that use those functions
	(added:4may2018.14h06m, sorted:???.???)



* [ ] add versions for each of the functions when exporting 
	(added:28april2018.13h36m, sorted:???.???)

* [ ] add readme for all the functions
	(added:23april2019.19h19m; sorted:)

* [ ] Update `ollin_cencah.R` for packages dependencies:

```
#mirror_repo <- 'https://www.stats.bris.ac.uk/R/'
#packagename <- 'lattice'
#if (!require(packagename)) install.packages(packagename, repos=mirror_repo, dependencies = TRUE) 


#if (!require("lattice")) install.packages("lattice")
library(lattice) ##xyplot

require(tseriesChaos)
require(rgl)

library(latticeExtra)  ##overlay xyplots a + as.layer(b)
library(ggplot2) ## percentage of variance bar plot

```

(added:30march2018 1358, sorted:???)





* [ ] test the following code to avoid installing libraries 
```
#mirror_repo <- 'https://www.stats.bris.ac.uk/R/'
#packagename <- 'lattice'
#if (!require(packagename)) install.packages(packagename, repos=mirror_repo, dependencies = TRUE) 
```
	** (added:6march2018,13h39; sorted: )

* [ ] Add an exmaple for each function

* [ ] Create a main directory for the function file and mix all the functions for   the Human Variability Project


* [ ] clean the function: `ollin_cencah.R`, `functions_freq_features.R`,
`functions_inertial_sensors.R`, `functions_matrix_stats.R`, `functions_muse_sensor.R`

* [ ] Add description for the R functions in the README.md files with subfunctions

* [ ] Add documentation on how to use the functions


## SORTED

* [x] 	* update `exampleCAO97.R`
	* update paths using relative path with tavand/...
	* update `cao97_functions.R` for `plotE2values <- function(E,maxdim,maxtau) {`
	

	added/sorted: Mon 21 May 18:01:43 BST 2018


* [x] adding `functions_extra_nonlinearTseries.R` on 23 April 2018


* [x] create an independent repository with proper name  (tavand)
	[Tools-for-analysis-of-variability-with-nonlinear-dynamics] 
	(use the same history)
	(added:30march2018 1526 sorted:30march2018 2006)



* [x] tyding up : 6march2018
* [x]  Add rotated_angle function to rotate euler angles (6th of October 2016)
* [x] adding `split_path` (sorted: 6 Sep 2016)


