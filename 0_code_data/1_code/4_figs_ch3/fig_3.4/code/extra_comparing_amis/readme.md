# Reference
#  [Eric Weeks](http://www.physics.emory.edu/faculty/weeks//software/minfo.html)


# Usage

Generate time series datafile on R with
```
source(paste(getwd(),"/lorenzts.R", sep=""), echo=FALSE)
```

Compile the c code for mutual information
```
cc -o minfo minfo5.c -lm
```

To run, use
```
./minfo datafile -b 100 -t 100 > r.mi
```
where
-t (number) sets the maximum delay to compute the mutual information  
-b (number) puts the data into 2^(number) equiprobable bins before  
doing the computation


```
R
mi_comparison.R
```



