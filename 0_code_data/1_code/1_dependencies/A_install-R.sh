#!/bin/bash  

# references
## MAIN REFERENCE: https://cloud.r-project.org/bin/linux/ubuntu/README.html
## https://gist.github.com/ElToro1966/999f1c8ca51a75648dd587a3170e4335

# key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9


## Ubuntu 18.04: bionic
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'

sudo apt-get update


## DEPENDENCIES
sudo apt-get update
sudo apt-get --yes install gfortran
sudo apt-get --yes install libblas-dev libatlas-base-dev liblapack-dev libatlas-base-dev libncurses5-dev libopenblas-dev 
sudo apt-get --yes install cdbs gdebi 


sudo apt-get --yes install xorg  #X11
sudo apt-get --yes install libx11-dev  #X11
sudo apt-get --yes install libglu1-mesa-dev #X11
#ref https://stackoverflow.com/questions/31820865/installing-rgl-on-ubuntu-and-mac-x11-not-found 

sudo apt-get --yes install libfreetype6 libfreetype6-dev # 'freetype2'
#ref https://github.com/jwilm/alacritty/issues/1623


## devtools dependencies
sudo apt-get --yes install libssl-dev libcurl4-openssl-dev
sudo apt-get --yes install libxml2-dev # for xml2 calling load_all()
sudo apt-get --yes install r-cran-rgl # rgl for nonlinearTseries

## r-base r-base-dev  
sudo apt-get --yes install r-base r-base-dev






########################################
########################################
## For the following versions of Ubuntu
## 12.04, 14.04, 16.04
#
##!/bin/bash  
#
###USAGE:
##chmod +x file
##./file
#
#
#
#sudo apt-key adv –keyserver keyserver.ubuntu.com –recv-keys E084DAB9
###or
##gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
##gpg -a --export E084DAB9 | sudo apt-key add -
#
#
#
##SELECT UBUNTU VERSION
#
## Basic format of next line deb https://<my.favorite.cran.mirror>/bin/linux/ubuntu <enter your ubuntu version>/
##sudo add-apt-repository 'deb https://cran.ma.imperial.ac.uk/bin/linux/ubuntu precise/'
#
### Ubuntu 12.04: precise
##sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu precise/'
#
### Ubuntu 14.04: trusty
#sudo add-apt-repository 'deb-src https://cloud.r-project.org/bin/linux/ubuntu trusty/'
#
#### Ubuntu 16.04: xenial
##sudo add-apt-repository 'deb-src https://cloud.r-project.org/bin/linux/ubuntu xenial'
#
#
#
#sudo apt-get update
#
#
### DEPENDENCIES
#sudo apt-get update
#sudo apt-get --yes install gfortran
#sudo apt-get --yes install libblas-dev libatlas-base-dev liblapack-dev libatlas-base-dev libncurses5-dev
#sudo apt-get --yes install cdbs
#sudo apt-get --yes install r-base r-base-dev
#
#
### devtools dependencies
#sudo apt-get --yes install libssl-dev libcurl4-openssl-dev
#sudo apt-get --yes install libxml2-dev # for xml2 calling load_all()
#sudo apt-get --yes install r-cran-rgl # rgl for nonlinearTseries
#
#
