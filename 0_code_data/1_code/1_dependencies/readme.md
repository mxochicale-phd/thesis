
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

Warning:
```
Warning in install.packages("devtools", repos = mirror_repo, dependencies = TRUE) :
  'lib = "/usr/local/lib/R/site-library"' is not writable
Would you like to use a personal library instead? (yes/No/cancel) yes
```


## (C) nonlinearTseries package


* install nonlinearTseries with R script `install_nonlinearTseries.R`
```
R
source(paste(getwd(),"/C_install-nonlinearTseries.R", sep=""), echo=FALSE)
```



# GNU Octave

## (D) install octave 

```
sh D_install-octave.sh
```


