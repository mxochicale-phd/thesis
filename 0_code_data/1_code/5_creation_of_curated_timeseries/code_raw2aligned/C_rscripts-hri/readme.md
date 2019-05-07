r-scripts
---



# Generating data.table files

## 2. Create 'TidiedInterpolatedData.datatable'

```
cd%$HOME/phd/phd-thesis/0_code_data/1_code/5_creation_of_curated_timeseries/code_raw2aligned/C_rscripts-hri 
R
```


`source(paste(getwd(),"/BA_creating_TidiedInterpolatedDATA_p01p22.R", sep=""), echo=TRUE)`

```
$HOME/phd/tmp/phdtmpdata/outcomes 

158M Jul 27 11:01 TidiedInterpolatedData.datatable
158M Aug 29 14:47 TidiedInterpolatedData.datatable
158M Apr 29 14:51 hri-TidiedInterpolatedData.datatable

```




## 3. Create only raw data for AccX AccY AccZ GyroX GyroY GyroZ for HS01 and RS01


cd%$HOME/phd/phd-thesis/0_code_data/1_code/5_creation_of_curated_timeseries/code_raw2aligned/C_rscripts-hri 

`source(paste(getwd(),"/BB_preprocessed_TidiedInterpolatedDATA_p01p22.R", sep=""), echo=TRUE)`


* names of xdata object for  `hri-TidiedInterpolatedRawData.dt`

```

> head(xdata)
   Participant Activity Sensor Sample      AccX        AccY      AccZ
1:         p01       HN   HS01      1 -1.000000  4.00000000 -978.0000
2:         p01       HN   HS01      2 -3.994159  6.08593402 -981.7004
3:         p01       HN   HS01      3 -3.051809  0.05725664 -991.3705
4:         p01       HN   HS01      4 -1.921741  2.71938601 -969.3355
5:         p01       HN   HS01      5 -6.917193  5.22073518 -971.6132
6:         p01       HN   HS01      6  2.505496 -1.94244414 -975.2334
        GyroX    GyroY    GyroZ
1: -2.2500000 3.062500 1.937500
2: -2.1778894 2.549903 2.007128
3: -2.2152526 3.313847 1.499128
4: -0.7921632 3.185006 1.562309
5: -0.6829491 3.540080 1.505756
6: -0.6333563 3.374851 1.436897



```



`$HOME/phd/phd-thesis-code-data/data/timeseries/hri`
```
39876955 Jul 27 12:02 TidiedInterpolatedRawData-v06.dt
39M Aug 29 14:20 TidiedInterpolatedRawData-v06.dt
39M Apr 29 15:42 hri-TidiedInterpolatedRawData.dt
```


```
~/phd/phd-thesis/0_code_data/0_data/0_raw-timeseries$ tree -s
.
└── [       4096]  hri
    └── [   39876955]  hri-TidiedInterpolatedRawData.dt

```










