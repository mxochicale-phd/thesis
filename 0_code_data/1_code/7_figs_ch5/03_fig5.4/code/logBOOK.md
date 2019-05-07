logbook
---



# scripts



# `source(paste(getwd(),"/B_ami.R", sep=""), echo=TRUE)`

```
######################################
## w2, 2-second window (100 samples) ## 100 to 200
#wstar=100
#windowlengthnumber=100
#windowltag <- 'w2'
#
######################################
## w5, 5-second window (250 samples) # 100 to 350
#wstar=100
#windowlengthnumber=250
#windowltag <- 'w5'

######################################
### w10, 10-second window (500 samples) ## 100 to 600
wstar=000
windowlengthnumber=500
windowltag <- 'w10'

######################################
## w15, 15-second window (750 samples) ## 100 to 850
#wstar=100
#windowlengthnumber=750
#windowltag <- 'w15'
```

```
> end.time - start.time
Time difference of 38.59746 secs
```



```
3.1M Oct 21 12:37 AMI-w10.dt
22K Oct 21 12:37 MTD-w10.dt

```
















# `source(paste(getwd(),"/CA_plotamiH.R", sep=""), echo=TRUE)`

```
#AMI <- fread('AMI-w2.dt', header=TRUE)
#MTD <- fread('MTD-w2.dt', header=TRUE)
#windowl<-'w2'


#
#AMI <- fread('AMI-w5.dt', header=TRUE)
#MTD <- fread('MTD-w5.dt', header=TRUE)
#windowl<-'w5'
#
#
AMI <- fread('AMI-w10.dt', header=TRUE)
MTD <- fread('MTD-w10.dt', header=TRUE)
windowl<-'w10'

#
#AMI <- fread('AMI-w15.dt', header=TRUE)
#MTD <- fread('MTD-w15.dt', header=TRUE)
#windowl<-'w15'
#
```



```
> end.time - start.time
Time difference of 4.999267 secs
```


output path
`/home/ai/github/phd-thesis/figs/results/utde/minimum_embedding_parameters-hii/ami/v01` 










# `source(paste(getwd(),"/CB_plotamiV.R", sep=""), echo=TRUE)`


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

##
#AMI <- fread('AMI-w15.dt', header=TRUE)
#MTD <- fread('MTD-w15.dt', header=TRUE)
#windowl<-'w15'
#
#
```



```
> end.time - start.time
Time difference of 2.252194 secs
```





# todo

* [ ] automatically select the window

Fri 31 Aug 13:42:24 BST 2018


