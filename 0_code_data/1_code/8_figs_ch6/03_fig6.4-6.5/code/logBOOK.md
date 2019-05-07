
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


window=w10 mean minEmdDim=6




# `> source( paste( getwd(), '/BC_mean_amiH.R',sep='' ), echo=TRUE  )`


```


AMI <- fread('AMI-w2.dt', header=TRUE)
MTD <- fread('MTD-w2.dt', header=TRUE)
windowl<-'w2'


#
#AMI <- fread('AMI-w5.dt', header=TRUE)
#MTD <- fread('MTD-w5.dt', header=TRUE)
#windowl<-'w5'
#
#
#AMI <- fread('AMI-w10.dt', header=TRUE)
#MTD <- fread('MTD-w10.dt', header=TRUE)
#windowl<-'w10'
#

#AMI <- fread('AMI-w15.dt', header=TRUE)
#MTD <- fread('MTD-w15.dt', header=TRUE)
#windowl<-'w15'




```


window=w10 total mean minDelay=8




# `> source( paste( getwd(), '/BD_mean_amiV.R',sep='' ), echo=TRUE  )`


```

AMI <- fread('AMI-w2.dt', header=TRUE)
MTD <- fread('MTD-w2.dt', header=TRUE)
windowl<-'w2'


#AMI <- fread('AMI-w5.dt', header=TRUE)
#MTD <- fread('MTD-w5.dt', header=TRUE)
#windowl<-'w5'
#

#AMI <- fread('AMI-w10.dt', header=TRUE)
#MTD <- fread('MTD-w10.dt', header=TRUE)
#windowl<-'w10'
#
#
#AMI <- fread('AMI-w15.dt', header=TRUE)
#MTD <- fread('MTD-w15.dt', header=TRUE)
#windowl<-'w15'





```



window=w10 total mean minDelay=8















# `source( paste( getwd(), '/C_rss.R',sep='' ), echo=TRUE  )`






caoH window=w10 mean minEmdDim=6
caoV window=w10 mean minEmdDim=6
amiH window=w10 total mean minDelay=8
amiV window=w10 total mean minDelay=8

```
windowsl <- c(500)
windowsn <- c('w10')
dimensions <- c(6)
delays <- c(8)
```




```
Time difference of 6.897569 secs
```



