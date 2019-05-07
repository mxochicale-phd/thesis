#!/bin/bash  

##USAGE:
#chmod +x file
#./file



sudo apt-key adv –keyserver keyserver.ubuntu.com –recv-keys E084DAB9
##or
#gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
#gpg -a --export E084DAB9 | sudo apt-key add -



#SELECT UBUNTU VERSION

# Basic format of next line deb https://<my.favorite.cran.mirror>/bin/linux/ubuntu <enter your ubuntu version>/
#sudo add-apt-repository 'deb https://cran.ma.imperial.ac.uk/bin/linux/ubuntu precise/'

## Ubuntu 12.04: precise
#sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu precise/'

## Ubuntu 14.04: trusty
sudo add-apt-repository 'deb-src https://cloud.r-project.org/bin/linux/ubuntu trusty/'

### Ubuntu 16.04: xenial
#sudo add-apt-repository 'deb-src https://cloud.r-project.org/bin/linux/ubuntu xenial'



sudo apt-get update


## DEPENDENCIES
sudo apt-get update
sudo apt-get --yes install gfortran
sudo apt-get --yes install libblas-dev libatlas-base-dev liblapack-dev libatlas-base-dev libncurses5-dev
sudo apt-get --yes install cdbs
sudo apt-get --yes install r-base r-base-dev


## devtools dependencies
sudo apt-get --yes install libssl-dev libcurl4-openssl-dev
sudo apt-get --yes install libxml2-dev # for xml2 calling load_all()
sudo apt-get --yes install r-cran-rgl # rgl for nonlinearTseries


