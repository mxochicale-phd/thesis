r-scripts for Human-Image Imitation (hii)
---


# Creating and setting up the raw data into aligned data



## 2. Generating data.table files

```
cd $HOME/phd/phd-thesis/0_code_data/1_code/5_creation_of_curated_timeseries/code_raw2aligned/B_rscripts-hii 
R
```




## Create 'hii-TidiedInterpolatedData.datatable'

Run `source(paste(getwd(),"/BA_creating_TidiedInterpolatedDATA_p01p22.R", sep=""), echo=TRUE)`
which creates
```
246M Aug 28 19:07 hii-TidiedInterpolatedData.datatable
246M Aug 29 14:34 hii-TidiedInterpolatedData.datatable
246M Apr 29 12:23 hii-TidiedInterpolatedData.datatable

```
at

`$HOME/phd/phd-thesis/tmp/phdtmpdata/outcomes/preProcessedDataTable_p01_to_p22`







## 3. Create only raw data for AccX AccY AccZ GyroX GyroY GyroZ for HS01 and RS01

Run four times 
`source(paste(getwd(),"/BB_preprocessed_TidiedInterpolatedDATA_p01p22.R", sep=""), echo=TRUE)`


which generate four data table objects for each of the sensors, having the following
names and heading

```

> names(xdata)
 [1] "Participant" "Activity"    "Sensor"      "Sample"      "AccX"       
 [6] "AccY"        "AccZ"        "GyroX"       "GyroY"       "GyroZ"      
> head(xdata)
   Participant Activity Sensor Sample      AccX      AccY      AccZ      GyroX
1:         p01     HNnb   HS01      1 -83.00000 -350.0000 -917.0000 -0.8750000
2:         p01     HNnb   HS01      2 -80.00924 -349.9962 -916.9986 -1.6246964
3:         p01     HNnb   HS01      3 -73.99445 -350.0166 -918.0011 -1.5014525
4:         p01     HNnb   HS01      4 -78.99232 -339.0045 -917.0000 -0.9989654
5:         p01     HNnb   HS01      5 -78.01218 -348.9853 -917.0000 -2.1216285
6:         p01     HNnb   HS01      6 -76.98702 -341.0478 -917.0000 -2.1893038
      GyroY    GyroZ
1: 2.812500 1.562500
2: 2.937488 1.312823
3: 2.937420 1.311597
4: 3.062265 1.812952
5: 2.688194 1.562912
6: 2.563188 1.562229


```
Then comment and uncomment the following lines to generate the data table for four sensors


```


##### HS01
#xdata <- xdata[.(c('HS01'))]
#write.table(xdata, "hii-HS01-TidiedInterpolatedRawData.dt", row.name=FALSE)


##### HS02
#xdata <- xdata[.(c('HS02'))]
#write.table(xdata, "hii-HS02-TidiedInterpolatedRawData.dt", row.name=FALSE)


#### HS03
xdata <- xdata[.(c('HS03'))]
write.table(xdata, "hii-HS03-TidiedInterpolatedRawData.dt", row.name=FALSE)

###### HS04
#xdata <- xdata[.(c('HS04'))]
#write.table(xdata, "hii-HS04-TidiedInterpolatedRawData.dt", row.name=FALSE)
#


```






* output path:
`$HOME/phd/phd-thesis/0_code_data/0_data/0_raw-timeseries`


Files:
```


:~/phd/phd-thesis/0_code_data/0_data$ tree -s
.
├── [       4096]  0_raw-timeseries
│   ├── [       4096]  hii
│   │   ├── [   28185223]  hii-HS01-TidiedInterpolatedRawData.dt
│   │   ├── [   31486666]  hii-HS02-TidiedInterpolatedRawData.dt
│   │   ├── [   28817382]  hii-HS03-TidiedInterpolatedRawData.dt
│   │   └── [   33532170]  hii-HS04-TidiedInterpolatedRawData.dt


```





