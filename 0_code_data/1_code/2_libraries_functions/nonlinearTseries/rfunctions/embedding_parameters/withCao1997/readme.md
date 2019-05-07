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

# setting up PATHS

```
source(paste(github_repo_path,'/code/rfunctions/embedding_parameters/withCao1997/cao97_functions.R', sep=''))
```




