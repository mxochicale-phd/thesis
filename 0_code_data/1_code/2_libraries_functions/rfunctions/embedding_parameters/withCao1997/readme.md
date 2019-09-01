Cao's Algorithm
---


# Setup for Cao's Algorithm

## 1. Clean dll libraries for R
```
rm *.o *.so
```

## 2. build dll to wrap f function in R
```
R CMD SHLIB cao97sub.f
```
which creates cao97sub.o and cao97sub.so

outout:
```
gfortran   -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4  -c cao97sub.f -o cao97sub.o
gcc -std=gnu99 -shared -L/usr/lib/R/lib -Wl,-Bsymbolic-functions -Wl,-z,relro -o cao97sub.so cao97sub.o -lgfortran -lm -lquadmath -L/usr/lib/R/lib -lR
```



### **NOTE** Remember to source the `cao97_functions.R` and `cao97sub.so`


```
homepath <- Sys.getenv("HOME")
github_path <- '/phd/thesis'
path_cao97_functions_R <- '/0_code_data/1_code/2_libraries_functions/rfunctions/embedding_parameters/withCao1997/cao97_functions.R'

################################################################################
## CAO's Algorithm
##
source(paste(github_path, path_cao97_functions_R, sep=''))

```


```
#### Setting up paths
homepath <- Sys.getenv("HOME")
github_path <- '/phd/thesis'
path_cao97sub_so <- '/0_code_data/1_code/2_libraries_functions/rfunctions/embedding_parameters/withCao1997/cao97sub.so'
```



## 3. Test examples
cd $HOME/phd/thesis/0_code_data/1_code/2_libraries_functions/rfunctions/embedding_parameters/withCao1997/examples 
```
R
> source(paste(getwd(),"/exampleCAO97.R", sep=""), echo=TRUE)
```






