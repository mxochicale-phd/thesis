
# R

## (A) installing R and its dependencies

Run the bash `A_install-R.sh` to install R

```
sh A_install-R.sh
```


## (B) install basic R packages
Run `B_install-basic-packages.R` for package dependecies
```
R
source(paste(getwd(),"/B_install-basic-packages.R", sep=""), echo=FALSE)
```


## (C) nonlinearTseries package


* install nonlinearTseries with R script `install_nonlinearTseries.R`
```
R
source(paste(getwd(),"/C_install-nonlinearTseries.R", sep=""), echo=FALSE)
```

* then clone personal nonlinearTseries repository to `phd` path


```
cd ../../../../
git clone https://github.com/mxochicale/nonlinearTseries
```




# GNU Octave

## (D) install octave 

```
sh D_install-octave.sh
```


remove octave [:link:](https://askubuntu.com/questions/814054/uninstalling-octave-from-ubuntu-16-04-lts)
```
sudo make uninstall

```



References: 
* GNU Octave, version 4.0.2 [:link:](https://unix.stackexchange.com/questions/280195/how-to-install-octave-without-gui-in-ubuntu-16-0://unix.stackexchange.com/questions/280195/how-to-install-octave-without-gui-in-ubuntu-16-04)

* withouht: sudo apt-get build-dep octave [:link:](https://askubuntu.com/questions/730322/how-to-install-octave-in-ubuntu-14-04-using-terminal#comment1083602_730333)



## ISSUES

### GNU Octave 4.2.2 Installation in Ubuntu 16.04
*(this versions has an issue with undefined variables when calling functions )*

```
sudo add-apt-repository ppa:octave/stable
sudo apt-get update
sudo apt-get install octave octave-signal octave-control
```
remove octave [:link:](https://askubuntu.com/questions/814054/uninstalling-octave-from-ubuntu-16-04-lts) 
```
sudo apt-get remove --auto-remove octave
```



