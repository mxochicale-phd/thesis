

# code
/home/ai/github/phd-thesis-code-data/code/rscripts/plotting-timeseries/smoothed-hii/v00 

# dataset
/home/ai/github/phd-thesis-code-data/data-outputs/smoothed-timeseries/hii/v00 

#output figures
/home/ai/github/phd-thesis/figs/results/smoothed-timeseries/hii/v00








## shifting columns with grups



```
###REFERENCES
#setkey(dt, entity, date)   # important for ordering
#dt[,indpct_fast:=( ind/ shift(ind,1) )-1, by=entity]
#DT3[order(year), (anscols):= shift(.SD, 2, type="lag"), .SDcols=cols ] ## add randomly two NA values
#ans <- flights[, .(delay_arr = arr_delay, delay_dep = dep_delay)]
#DT4[, c("lag1", "lag2"):= shift(.SD, c(1,3),fill=NA, type='lead'), by=year]
#ans <- flights[origin == 'JFK' & month == 6L]


###POSIBLE SOLUTIONS
#setkey(xpa, Participant)
#xpa <- xpa[ Participant=='p01', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ ,150, type='lead'),  ]
#xpa <- xpa[ Participant=='p01' & Activity=='HNnb', sg0zmuvGyroZ:=shift(sg0zmuvGyroZ ,150, type='lead'),  ]

#xpa <- xpa[ .(c('p01')), sg0zmuvGyroZ:=shift(sg0zmuvGyroZ ,150, type='lead'), by= .(Participant) ]
#xpa <- xpa[ .(c('p01')), c('sg0zmuvGyroZ','sg1zmuvGyroZ':=shift(.(sg0zmuvGyroZ,sg1zmuvGyroZ) ,c(150,50), type='lead'), by= .(Participant) ]
#xpa <- xpa[ .(c('p01')), c('sg0zmuvGyroZ','sg1zmuvGyroZ','sg2zmuvGyroZ'):=shift(.(sg0zmuvGyroZ,sg1zmuvGyroZ,sg2zmuvGyroZ) ,c(150,150,150), type='lead'), by= .(Participant) ]

###MAIN SOLUTION
xpa <- xpa[ 	Participant=='p01' & Activity=='HNnb', 
		c('sg0zmuvGyroZ','sg1zmuvGyroZ','sg2zmuvGyroZ'):=shift(.(sg0zmuvGyroZ,sg1zmuvGyroZ,sg2zmuvGyroZ) ,c(150,150,150), type='lead'), 
		by= .(Participant, Activity) 
	]

```
Sun 23 Sep 01:59:32 BST 2018



```
####DONTWORK
#xpa <- xpa[ 	Participant=='p01' & Activity=='HNnb', 
#		c('sg0zmuvGyroX','sg1zmuvGyroX','sg2zmuvGyroX'):=shift(.(sg0zmuvGyroX,sg1zmuvGyroX,sg2zmuvGyroX) ,c(shiftHNnb,shiftHNnb,shiftHNnb), type='lead'), 
#		by= .(Participant, Activity, Sensor) ]

		#DONT WORK
		#c('sg0zmuvGyroX','sg1zmuvGyroX','sg2zmuvGyroX'):=shift(.(sg0zmuvGyroX,sg1zmuvGyroX,sg2zmuvGyroX) ,c(shiftHNnb,shiftHNnb,shiftHNnb), type='lead'), 
		#by= .(Participant, Activity, Sensor)
		#DONT WORK
		#c('sg0zmuvGyroX','sg1zmuvGyroX','sg2zmuvGyroX'):=shift(.(sg0zmuvGyroX,sg1zmuvGyroX,sg2zmuvGyroX) ,c(shiftHNnb,shiftHNnb,shiftHNnb), type='lead'),
		#sg0zmuvGyroX:=shift(sg0zmuvGyroX ,300, type='lead'), ##worked
		#'':=shift(sg2zmuvGyroX ,150, type='lead'),##DONT WORK 
		#'':=shift(.(sg0zmuvGyroX, sg1zmuvGyroX, sg2zmuvGyroX) ,c(100, 100, 100), type='lead'),#DONT WORK 


SOLUTION
xpa[Participant=='p01' & Activity=='HNnb', sg0zmuvGyroX:=shift(sg0zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNnb', sg1zmuvGyroX:=shift(sg1zmuvGyroX, shiftHNnb, type='lead'), ] 
xpa[Participant=='p01' & Activity=='HNnb', sg2zmuvGyroX:=shift(sg2zmuvGyroX, shiftHNnb, type='lead'), ] 

```
Sun 23 Sep 16:35:46 BST 2018



## discarding participants after visual inspection of the data


GENERATE ALL DATA 
```
> source(  paste( getwd(), '/0_dataset-all.R', sep=''), echo=TRUE )
```

```
/home/ai/github/phd-thesis-code-data/data-outputs/smoothed-timeseries/hii/v00
209M Sep 24 11:36 xdata_v00.dt
```




* for HORIZONTAL MOVEMENTS

```
p01 GOD 1 axis offphase
p02 MED 3 axis offphase
p03 bad 4 axis offphase
p04 GOD 0 axis offphase
p05 GOD 1 axis offphase
p06 bad 3 axis not present for 1 activity
p07 MED 4 axis offphase
p08 MED 3 axis offphase
p09 GOD 0 axis offphase
p10 GOD 0 axis offphase
p11 MED 2 axis offphase
p12 MED 3 axis offphase
p13 MED 2 axis offphase
p14 bad 1 axis not present for 1 activity
p15 MED 2 axis offphase
p16 bad 4 axis offphase
p17 bad 3 axis not present for 1 activity
```


Sun 23 Sep 20:43:14 BST 2018



* for VERTICAL MOVEMENTS


```
p01 GOD 1 axis offphase
p02 GOD 1 axis offphase
p03 bad 3 axis offphase 
p04 GOD axis slightly offphase
p05 GOD 1 axis offphase
p06 GOD 1 axis offphase
p07 GOD 2 axis offphase
p08 MED 2 axix offphase
p09 MED 3 axis offphase
p10 GOD axis slightly offphase
p11 GOD 1 axis offphase
p12 MED 3 axis offphase
p13 MED 3 axis offphase
p14 MED 4 axis offphase
p15 GOD axis slighly offphase
p16 BAD 1 axis offphase
p17 MED 1 activity axis offphase
```

Mon 24 Sep 10:37:35 BST 2018


# ELIMINATE THE BAD DATA!

```
> source(  paste( getwd(), '/A_dataset.R', sep=''), echo=TRUE )
```


```
xdata <- xdata[.(c(
		'p01', 'p04', 'p05', 'p10', 'p11', 'p15'
		))]
```


```
/home/ai/github/phd-thesis-code-data/data-outputs/smoothed-timeseries/hii/v00 
23M Sep 24 11:40 xdata_v00.dt
```




## then plot 
source(  paste( getwd(), '/B_timeseries.R', sep=''), echo=TRUE )


comment/uncomment the following lines

```
### TWO ACTIVITIS


###HORIZONTAL NO BEAT
#movementtag <- 'Hnb' 
#setkey(wkdata, Activity)
#awkdata <- wkdata[.(c('HNnb', 'HFnb'))]
#### GyroZ -- HORIZONTAL
#awkdata <- awkdata[,.(
#	sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
#	), by=. (Participant,Activity,Sensor,Sample)]
#
#

###HORIZONTAL WITH BEAT
#movementtag <- 'Hwb' 
#setkey(wkdata, Activity)
#awkdata <- wkdata[.(c('HNwb', 'HFwb'))]
#### GyroZ -- HORIZONTAL
#awkdata <- awkdata[,.(
#	sg0zmuvGyroZ, sg1zmuvGyroZ, sg2zmuvGyroZ
#	), by=. (Participant,Activity,Sensor,Sample)]
#
#



####VERTICAL NO beat
#movementtag <- 'Vnb' 
#setkey(wkdata, Activity)
#awkdata <- wkdata[.(c('VNnb', 'VFnb'))]
#### GyroY -- VERTICAL
#awkdata <- awkdata[,.(
#	sg0zmuvGyroY, sg1zmuvGyroY, sg2zmuvGyroY
#	), by=. (Participant,Activity,Sensor,Sample)]
#
#

###VERTICAL with beat
movementtag <- 'Vwb' 
setkey(wkdata, Activity)
awkdata <- wkdata[.(c('VNwb', 'VFwb'))]

### GyroY -- VERTICAL
awkdata <- awkdata[,.(
	sg0zmuvGyroY, sg1zmuvGyroY, sg2zmuvGyroY
	), by=. (Participant,Activity,Sensor,Sample)]


```


Mon 24 Sep 19:38:56 BST 2018






# `source(  paste( getwd(), '/C_timeseries.R', sep=''), echo=TRUE )`






