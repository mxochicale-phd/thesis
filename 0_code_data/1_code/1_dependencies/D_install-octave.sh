#!/bin/bash  

# download and installation
cd ~/Downloads
wget ftp://ftp.gnu.org/gnu/octave/octave-4.0.2.tar.gz
tar xf octave-4.0.2.tar.gz
cd octave-4.0.2/
./configure
make 
sudo make install

# remove installation path and tar file
rm -rf octave-4.0.2
rm octave-4.0.2.tar.gz 



#
#remove octave [:link:](https://askubuntu.com/questions/814054/uninstalling-octave-from-ubuntu-16-04-lts)
#```
#sudo make uninstall
#
#```
#
#
#
#References: 
#* GNU Octave, version 4.0.2 [:link:](https://unix.stackexchange.com/questions/280195/how-to-install-octave-without-gui-in-ubuntu-16-0://unix.stackexchange.com/questions/280195/how-to-install-octave-without-gui-in-ubuntu-16-04)
#
#* withouht: sudo apt-get build-dep octave [:link:](https://askubuntu.com/questions/730322/how-to-install-octave-in-ubuntu-14-04-using-terminal#comment1083602_730333)
#
#
#
### ISSUES
#
#### GNU Octave 4.2.2 Installation in Ubuntu 16.04
#*(this versions has an issue with undefined variables when calling functions )*
#
#```
#sudo add-apt-repository ppa:octave/stable
#sudo apt-get update
#sudo apt-get install octave octave-signal octave-control
#```
#remove octave [:link:](https://askubuntu.com/questions/814054/uninstalling-octave-from-ubuntu-16-04-lts) 
#```
#sudo apt-get remove --auto-remove octave
#```
#
#
# UBUNTU 18.04
#
#sudo apt-get install octave
#sudo apt-get remove --auto-remove octave
#


