

# `source( paste( getwd(), '/BA_mean_caoH.R',sep='' ), echo=TRUE  )`


```
windowl<-'w2'
aMED <- fread('aMED-H-w2.dt', header=TRUE)
MED <- fread('MED-w2.dt', header=TRUE)
EE <- fread('EE-w2.dt', header=TRUE)


#windowl<-'w5'
#aMED <- fread('aMED-H-w5.dt', header=TRUE)
#MED <- fread('MED-w5.dt', header=TRUE)
#EE <- fread('EE-w5.dt', header=TRUE)
#

#windowl<-'w10'
#aMED <- fread('aMED-H-w10.dt', header=TRUE)
#MED <- fread('MED-w10.dt', header=TRUE)
#EE <- fread('EE-w10.dt', header=TRUE)
#

#windowl<-'w15'
#aMED <- fread('aMED-H-w15.dt', header=TRUE)
#MED <- fread('MED-w15.dt', header=TRUE)
#EE <- fread('EE-w15.dt', header=TRUE)
```



```
> #########################################################
> for (movement_k in 1:length(movement_varia .... [TRUNCATED] 
HNnb
HS01 6
HS02 6
HNwb
HS01 6
HS02 6
HFnb
HS01 6
HS02 6
HFwb
HS01 6
HS02 6

> mMA <- round( mean(MA) )

> message('window=', windowl, ' mean minEmdDim=' , mMA )
window=w10 mean minEmdDim=6

> #################
> # Stop the clock!
> end.time <- Sys.time()

> end.time - start.time
Time difference of 0.07802033 secs
```





# `source( paste( getwd(), '/BB_mean_caoV.R',sep='' ), echo=TRUE  )`

```

windowl<-'w2'
aMED <- fread('aMED-V-w2.dt', header=TRUE)
MED <- fread('MED-w2.dt', header=TRUE)
EE <- fread('EE-w2.dt', header=TRUE)

#
#windowl<-'w5'
#aMED <- fread('aMED-V-w5.dt', header=TRUE)
#MED <- fread('MED-w5.dt', header=TRUE)
#EE <- fread('EE-w5.dt', header=TRUE)
#

#windowl<-'w10'
#aMED <- fread('aMED-V-w10.dt', header=TRUE)
#MED <- fread('MED-w10.dt', header=TRUE)
#EE <- fread('EE-w10.dt', header=TRUE)
##
#
#windowl<-'w15'
#aMED <- fread('aMED-V-w15.dt', header=TRUE)
#MED <- fread('MED-w15.dt', header=TRUE)
#EE <- fread('EE-w15.dt', header=TRUE)
#
#



```



```
> #########################################################
> for (movement_k in 1:length(movement_variables) ) {
+ 
+ EE <- NULL # contains E1E2 valu .... [TRUNCATED] 
VNnb
HS01 6
HS02 6
VNwb
HS01 6
HS02 6
VFnb
HS01 6
HS02 6
VFwb
HS01 6
HS02 6

> mMA <- round( mean(MA) )

> message('window=', windowl, ' mean minEmdDim=' , mMA )
window=w10 mean minEmdDim=6

> #################
> # Stop the clock!
> end.time <- Sys.time()

> end.time - start.time
Time difference of 0.1148753 secs

```






# `> source( paste( getwd(), '/BC_mean_amiH.R',sep='' ), echo=TRUE  )`


```

#
#AMI <- fread('AMI-w2.dt', header=TRUE)
#MTD <- fread('MTD-w2.dt', header=TRUE)
#windowl<-'w2'
#

#
#AMI <- fread('AMI-w5.dt', header=TRUE)
#MTD <- fread('MTD-w5.dt', header=TRUE)
#windowl<-'w5'
#

AMI <- fread('AMI-w10.dt', header=TRUE)
MTD <- fread('MTD-w10.dt', header=TRUE)
windowl<-'w10'


#AMI <- fread('AMI-w15.dt', header=TRUE)
#MTD <- fread('MTD-w15.dt', header=TRUE)
#windowl<-'w15'




```




```



> total_mean <- round( mean(  c(mtHNnb, mtHNwb, mtHFnb, mtHFwb) )) 

> message('window=', windowl, ' total mean minDelay=' , total_mean )
window=w10 total mean minDelay=11


```






# `> source( paste( getwd(), '/BD_mean_amiV.R',sep='' ), echo=TRUE  )`


```

#AMI <- fread('AMI-w2.dt', header=TRUE)
#MTD <- fread('MTD-w2.dt', header=TRUE)
#windowl<-'w2'
#

#AMI <- fread('AMI-w5.dt', header=TRUE)
#MTD <- fread('MTD-w5.dt', header=TRUE)
#windowl<-'w5'
#

AMI <- fread('AMI-w10.dt', header=TRUE)
MTD <- fread('MTD-w10.dt', header=TRUE)
windowl<-'w10'


#AMI <- fread('AMI-w15.dt', header=TRUE)
#MTD <- fread('MTD-w15.dt', header=TRUE)
#windowl<-'w15'

```



```

> total_mean <- round( mean(  c(mtVNnb, mtVNwb, mtVNnb, mtVNwb) )) 

> message('window=', windowl, ' total mean minDelay=' , total_mean )
window=w10 total mean minDelay=10

```
















# `source( paste( getwd(), '/C_rss.R',sep='' ), echo=TRUE  )`


```
##########################
##### one window lenght
windowsl <- c(500)
windowsn <- c('w10')
dimensions <- c(6)
delays <- c(10)
```




```
> end.time - start.time
Time difference of 26.50404 secs
```




