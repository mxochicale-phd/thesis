# OBSERVATIONS

The script "/comparison-3methods.R" plots the computation of the mutual information
and average mutual information using three methods: a) mutual() function
from tseriesChaos package, b) timeLag() function from nonliearTseries package
and c) Weeks' method using miinfo.c. With this in mind, the observations
that can be given from "/plots_paht/mi_comparison-3methods.png" are related to
the different values that each method compute, we had expected to have similar
results, however further investigation is required to analyse in depth each
of the computations of the previous functions. Similarly, it would be helpful
to integrate the minfo5.c in R.
~ Thursday November 9 2017




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
comparison02.R
```

## Reference
* [Eric Weeks](http://www.physics.emory.edu/faculty/weeks//software/minfo.html)



# TODO

- [ ] Embedding the minfo5.c in R [1](http://users.stat.umn.edu/~geyer/rc/).
