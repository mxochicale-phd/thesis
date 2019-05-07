

# code

# dataset


```
~/phd/phd-thesis/0_code_data/0_data$ tree -s

└── [       4096]  1_datasets
    └── [       4096]  hii
        └── [   23802138]  xdata.dt

```



`0_dataset-all.R` works well but
`A_dataset.R` is used as it filter out some 
offphase data




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



# datatable


/home/ai/github/phd-thesis-code-data/data-outputs/dataset/hii/v00

  23M Sep 24 20:34 xdata_v00.dt

```
"Participant" "Activity" "Sensor" "Sample" "sg0zmuvGyroY" "sg1zmuvGyroY" "sg2zmuvGyroY" "sg0zmuvGyroZ" "sg1zmuvGyroZ" "sg2zmuvGyroZ"
"p01" "HFnb" "HS01" 1 -0.0703004411784511 -0.0797807667233684 0.0175340798294728 0.0345113493189202 0.00664422374467492 0.0677789429154257
"p01" "HFnb" "HS01" 2 -0.0278745781945801 -0.0680897629066011 0.0197993030774923 0.0424090183783423 0.0267627860689498 0.0724824600921973
"p01" "HFnb" "HS01" 3 -0.0370477377586604 -0.0558719885904483 0.0196517095831857 0.0435372568154026 0.0455321196861016 0.0766187496661449
"p01" "HFnb" "HS01" 4 -0.0496608321592706 -0.0408743117730732 0.0167633585761362 0.0435372568154026 0.0610118005199007 0.080435638387738
"p01" "HFnb" "HS01" 5 -0.0175547736849899 -0.0248759266396175 0.0123542891758016 0.059332594934247 0.072132904384217 0.0847011801741762
"p01" "HFnb" "HS01" 6 -0.0267279332490701 -0.01003524050009 0.00706865317132591 0.0830256021125134 0.0797693752357432 0.0902133400970389
"p01" "HFnb" "HS01" 7 0.00996470500725074 0.00401105379347788 4.38992200013914e-05 0.0988209402313577 0.084809349857703 0.0952743026157306
"p01" "HFnb" "HS01" 8 0.0340442488629613 0.0183976968267633 -0.00967231085563691 0.110103324601961 0.0887738084126883 0.0994494855370755
"p01" "HFnb" "HS01" 9 0.0455106983180616 0.030775904293646 -0.0209316807313693 0.136052808654348 0.0914197209305603 0.102699267036373
"p01" "HFnb" "HS01" 10 0.0455106983180616 0.043564719413584 -0.0335082767691526 0.113488039913142 0.0912051501383119 0.105262117953794
"p01" "HFnb" "HS01" 11 0.0455106983180616 0.0563902963304412 -0.0458559077219809 0.0672302639936691 0.0897970914299726 0.108618107070898
"p01" "HFnb" "HS01" 12 0.0478039882090816 0.0674930005983592 -0.0592596424607933 0.055947879623066 0.0912695705615636 0.111510561231133
"p01" "HFnb" "HS01" 13 0.0363375387539813 0.0780033598964457 -0.0741731348011266 0.0548196411860057 0.0966071736744553 0.113734770389349
"p01" "HFnb" "HS01" 14 0.0672969522827521 0.0870680068402347 -0.0901218429435196 0.0875385558607546 0.104204790459078 0.11500828665753
```



