cao
---



# `> source(paste(getwd(), "/B_cao.R", sep=""), echo=TRUE)`



```
##########################
## (4.2.1) Activities Selection
#movement_variables <- c('HN','HF')
#movement_variables <- c('VN','VF')
movement_variables <- c('HN', 'HF', 'VN', 'VF')

```


```
#########################
#### one window lenght
windowsl <- c(500)
windowsn <- c('w10')

```


computation time for time series with 500sample window
```


> #################
> # Stop the clock!
> end.time <- Sys.time()



> end.time - start.time
Time difference of 8.258252 mins

```


```

    └── [       4096 May  5  7:54]  hri
        └── [       4096 May  5  7:54]  utde
            ├── [    6283402 May  5  7:54]  EE-w10.dt
            └── [     356219 May  5  7:54]  MED-w10.dt

```









#  `> source(paste(getwd(), "/CA_cao_mm_H.R", sep=""), echo=TRUE)`

```
#acts <- 'H'
#windowl<-'w2'
#wdata <- fread('MED-w2.dt', header=TRUE)
#
#
#acts <- 'H'
#windowl<-'w5'
#wdata <- fread('MED-w5.dt', header=TRUE)

acts <- 'H'
windowl<-'w10'
wdata <- fread('MED-w10.dt', header=TRUE)

#acts <- 'H'
#windowl<-'w15'
#wdata <- fread('MED-w15.dt', header=TRUE)
```




```
> end.time - start.time
Time difference of 1.935169 secs
```



# `> source(paste(getwd(), "/CB_cao_mm_V.R", sep=""), echo=TRUE)`


comment and uncomment the following lines of code
```
#acts <- 'V'
#windowl<-'w2'
#wdata <- fread('MED-w2.dt', header=TRUE)


#acts <- 'V'
#windowl<-'w5'
#wdata <- fread('MED-w5.dt', header=TRUE)

acts <- 'V'
windowl<-'w10'
wdata <- fread('MED-w10.dt', header=TRUE)

#acts <- 'V'
#windowl<-'w15'
#wdata <- fread('MED-w15.dt', header=TRUE)
```



```

> end.time - start.time
Time difference of 1.865611 secs


```



```

    └── [       4096 May  5  7:54]  hri
        └── [       4096 May  5  7:56]  utde
            ├── [       8448 May  5  7:56]  aMED-H-w10.dt
            ├── [       8448 May  5  7:56]  aMED-V-w10.dt


```
# `> source(paste(getwd(), "/EA_plotcao_avMED_H.R", sep=""), echo=TRUE)`

```

#
#windowl<-'w2'
#aMED <- fread('aMED-H-w2.dt', header=TRUE)


#windowl<-'w5'
#aMED <- fread('aMED-H-w5.dt', header=TRUE)


windowl<-'w10'
aMED <- fread('aMED-H-w10.dt', header=TRUE)

#windowl<-'w15'
#aMED <- fread('aMED-H-w15.dt', header=TRUE)


```



```
> end.time - start.time
Time difference of 1.753456 secs
```


# `> source(paste(getwd(), "/EB_plotcao_avMED_V.R", sep=""), echo=TRUE)`


```
#windowl<-'w2'
#aMED <- fread('aMED-V-w2.dt', header=TRUE)
#
#
#windowl<-'w5'
#aMED <- fread('aMED-V-w5.dt', header=TRUE)


windowl<-'w10'
aMED <- fread('aMED-V-w10.dt', header=TRUE)


#windowl<-'w15'
#aMED <- fread('aMED-V-w15.dt', header=TRUE)




```




```
> end.time - start.time
Time difference of 1.640589 secs
```




