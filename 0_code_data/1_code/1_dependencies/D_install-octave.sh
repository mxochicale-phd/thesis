#!/bin/bash  


cd ~/Downloads
wget ftp://ftp.gnu.org/gnu/octave/octave-4.0.2.tar.gz
tar xf octave-4.0.2.tar.gz
cd octave-4.0.2/
./configure
make 
sudo make install

# remove
rm -rf octave-4.0.2
rm octave-4.0.2.tar.gz 




