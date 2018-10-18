

CODE: /home/ai/github/phd-thesis-code-data/code/rscripts/rqa/hri/v05 

DATA: /home/ai/github/phd-thesis-code-data/data-outputs/rqa/hri/v05

FIGS: /home/ai/github/phd-thesis/figs/results/rqa/hri/v05/rqa_plots




```
> source(  paste( getwd(), '/D_rqa.R', sep=''), echo=TRUE )
```


# HN

W[Participant == 'p01' & Activity == 'HN' & Sensor == 'HS01' & Axis=='sg0zmuvGyroZ']
```
> W[Participant == 'p01' & Activity == 'HN' & Sensor == 'HS01' & Axis=='sg0zmuvGyroZ']
   Participant Window Activity Sensor         Axis       REC    RATIO       DET
1:         p01   w500       HN   HS01 sg0zmuvGyroZ 0.2326405 4.265091 0.9922332
           DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax    Vmean
1: 0.002173913  460 28.37305         28.12269 3.399105 0.9971481   83 32.18016
```


W[Participant == 'p01' & Activity == 'HN' & Sensor == 'HS01' & Axis=='sg1zmuvGyroZ']
```
> W[Participant == 'p01' & Activity == 'HN' & Sensor == 'HS01' & Axis=='sg1zmuvGyroZ']
   Participant Window Activity Sensor         Axis      REC    RATIO       DET
1:         p01   w500       HN   HS01 sg1zmuvGyroZ 0.236132 4.221755 0.9968914
           DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax    Vmean
1: 0.002173913  460 40.31185         39.97258 3.915544 0.9994022   94 38.87829
```


W[Participant == 'p01' & Activity == 'HN' & Sensor == 'HS01' & Axis=='sg2zmuvGyroZ']


```
> W[Participant == 'p01' & Activity == 'HN' & Sensor == 'HS01' & Axis=='sg2zmuvGyroZ']
   Participant Window Activity Sensor         Axis       REC    RATIO       DET
1:         p01   w500       HN   HS01 sg2zmuvGyroZ 0.3088777 3.235554 0.9993906
           DIV Lmax   Lmean LmeanWithoutMain     ENTR       LAM Vmax    Vmean
1: 0.002173913  460 85.0882             84.6 4.640236 0.9998172   97 52.63111
```


W[Participant == 'p01' & Activity == 'HN' & Sensor == 'RS01' & Axis=='sg0zmuvGyroZ']

```
> W[Participant == 'p01' & Activity == 'HN' & Sensor == 'RS01' & Axis=='sg0zmuvGyroZ']
   Participant Window Activity Sensor         Axis       REC    RATIO       DET
1:         p01   w500       HN   RS01 sg0zmuvGyroZ 0.1655036 5.651182 0.9352913
           DIV Lmax    Lmean LmeanWithoutMain     ENTR      LAM Vmax   Vmean
1: 0.006451613  155 8.104706           7.9931 2.099894 0.961135   82 9.66438
```

W[Participant == 'p01' & Activity == 'HN' & Sensor == 'RS01' & Axis=='sg1zmuvGyroZ']

```
> W[Participant == 'p01' & Activity == 'HN' & Sensor == 'RS01' & Axis=='sg1zmuvGyroZ']
   Participant Window Activity Sensor         Axis      REC    RATIO       DET
1:         p01   w500       HN   RS01 sg1zmuvGyroZ 0.317818 3.115616 0.9901988
           DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax    Vmean
1: 0.002173913  460 20.55979         20.42435 2.680404 0.9953955   96 26.84984
```


W[Participant == 'p01' & Activity == 'HN' & Sensor == 'RS01' & Axis=='sg2zmuvGyroZ']

```
> W[Participant == 'p01' & Activity == 'HN' & Sensor == 'RS01' & Axis=='sg2zmuvGyroZ']
   Participant Window Activity Sensor         Axis       REC    RATIO       DET
1:         p01   w500       HN   RS01 sg2zmuvGyroZ 0.3674696 2.718665 0.9990268
           DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax   Vmean
1: 0.002173913  460 68.61829         68.27289 4.265497 0.9997311  107 65.6084
``` 

HN

       sg0zmuvGyroZ  sg1zmuvGyroZ  sg2zmuvGyroZ 
----------------------------------------------HS01
REC   0.232  0.236 0.308 
DET   0.992  0.996 0.999
RATIO 4.265  4.221 3.235
ENTR  3.399  3.915 4.640

----------------------------------------------RS01
REC   0.165 0.317 0.367
DET   0.935 0.990 0.999
RATIO 5.651 3.115 2.718
ENTR  2.099 2.680 4.265


# HF

W[Participant == 'p01' & Activity == 'HF' & Sensor == 'HS01' & Axis=='sg0zmuvGyroZ']


```> W[Participant == 'p01' & Activity == 'HF' & Sensor == 'HS01' & Axis=='sg0zmuvGyroZ']
   Participant Window Activity Sensor         Axis        REC    RATIO
1:         p01   w500       HF   HS01 sg0zmuvGyroZ 0.06039403 16.36442
         DET         DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax
1: 0.9883132 0.002173913  460 15.11919         14.58711 2.662584 0.9968056    9
      Vmean
1: 5.428087
```

W[Participant == 'p01' & Activity == 'HF' & Sensor == 'HS01' & Axis=='sg1zmuvGyroZ']


```
> W[Participant == 'p01' & Activity == 'HF' & Sensor == 'HS01' & Axis=='sg1zmuvGyroZ']
   Participant Window Activity Sensor         Axis       REC    RATIO      DET
1:         p01   w500       HF   HS01 sg1zmuvGyroZ 0.0645348 15.39157 0.993292
           DIV Lmax   Lmean LmeanWithoutMain     ENTR       LAM Vmax    Vmean
1: 0.002173913  460 27.8589         26.97131 3.063351 0.9982501    9 5.742869
> 
```



W[Participant == 'p01' & Activity == 'HF' & Sensor == 'HS01' & Axis=='sg2zmuvGyroZ']


```
> W[Participant == 'p01' & Activity == 'HF' & Sensor == 'HS01' & Axis=='sg2zmuvGyroZ']
   Participant Window Activity Sensor         Axis       REC    RATIO      DET
1:         p01   w500       HF   HS01 sg2zmuvGyroZ 0.1362359 7.333615 0.999102
           DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax    Vmean
1: 0.002173913  460 109.9886         108.6489 4.032483 0.9996201   17 12.21697
``` 


W[Participant == 'p01' & Activity == 'HF' & Sensor == 'RS01' & Axis=='sg0zmuvGyroZ']

```
> W[Participant == 'p01' & Activity == 'HF' & Sensor == 'RS01' & Axis=='sg0zmuvGyroZ']
   Participant Window Activity Sensor         Axis        REC    RATIO
1:         p01   w500       HF   RS01 sg0zmuvGyroZ 0.02775726 31.58054
         DET       DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax
1: 0.8765893 0.0212766   47 6.148633         5.607143 2.021569 0.8616715    8
      Vmean
1: 3.386409
```



W[Participant == 'p01' & Activity == 'HF' & Sensor == 'RS01' & Axis=='sg1zmuvGyroZ']


```
> W[Participant == 'p01' & Activity == 'HF' & Sensor == 'RS01' & Axis=='sg1zmuvGyroZ']
   Participant Window Activity Sensor         Axis        REC   RATIO       DET
1:         p01   w500       HF   RS01 sg1zmuvGyroZ 0.07974271 12.2991 0.9807636
           DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax    Vmean
1: 0.002173913  460 15.09628         14.69091 2.089963 0.9994099   10 6.907423
```


W[Participant == 'p01' & Activity == 'HF' & Sensor == 'RS01' & Axis=='sg2zmuvGyroZ']

```
> W[Participant == 'p01' & Activity == 'HF' & Sensor == 'RS01' & Axis=='sg2zmuvGyroZ']
   Participant Window Activity Sensor         Axis       REC   RATIO       DET
1:         p01   w500       HF   RS01 sg2zmuvGyroZ 0.1910258 5.22561 0.9982265
           DIV Lmax   Lmean LmeanWithoutMain     ENTR       LAM Vmax    Vmean
1: 0.002173913  460 73.2821         72.57971 3.310574 0.9998768   18 16.21734
``` 



HF
       sg0zmuvGyroZ  sg1zmuvGyroZ  sg2zmuvGyroZ 
----------------------------------------------HS01
REC   0.060    0.064   0.136  
DET   0.988    0.993   0.999
RATIO 16.364  15.391   7.333
ENTR  2.662    3.063   4.032


----------------------------------------------RS01
REC    0.027   0.079  0.191 
DET    0.876   0.980  0.998
RATIO 31.580  12.299  5.335
ENTR   2.021   2.089  3.310








# inkscape command

```

inkscape --export-pdf ../../../PDF/rp_aH.pdf rp_aH.svg

```







# VN





W[Participant == 'p01' & Activity == 'VN' & Sensor == 'HS01' & Axis=='sg0zmuvGyroY']
```
> W[Participant == 'p01' & Activity == 'VN' & Sensor == 'HS01' & Axis=='sg0zmuvGyroY']
   Participant Window Activity Sensor         Axis       REC    RATIO       DET
1:         p01   w500       VN   HS01 sg0zmuvGyroY 0.2323959 4.206643 0.9776063
           DIV Lmax    Lmean LmeanWithoutMain    ENTR       LAM Vmax    Vmean
1: 0.002173913  460 17.28715         17.12822 3.03935 0.9873251   99 24.03302
> 
```

W[Participant == 'p01' & Activity == 'VN' & Sensor == 'HS01' & Axis=='sg1zmuvGyroY']


```
> W[Participant == 'p01' & Activity == 'VN' & Sensor == 'HS01' & Axis=='sg1zmuvGyroY']
   Participant Window Activity Sensor         Axis       REC   RATIO       DET
1:         p01   w500       VN   HS01 sg1zmuvGyroY 0.2426254 4.10863 0.9968582
           DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax    Vmean
1: 0.002173913  460 31.74861         31.48331 3.979378 0.9993018  105 40.63644
```

W[Participant == 'p01' & Activity == 'VN' & Sensor == 'HS01' & Axis=='sg2zmuvGyroY']

```
 
> W[Participant == 'p01' & Activity == 'VN' & Sensor == 'HS01' & Axis=='sg2zmuvGyroY']
   Participant Window Activity Sensor         Axis       REC    RATIO       DET
1:         p01   w500       VN   HS01 sg2zmuvGyroY 0.3620207 2.760909 0.9995061
           DIV Lmax    Lmean LmeanWithoutMain     ENTR      LAM Vmax    Vmean
1: 0.002173913  460 54.11612         53.82958 3.999227 0.999922  129 59.91511
> 
```

W[Participant == 'p01' & Activity == 'VN' & Sensor == 'RS01' & Axis=='sg0zmuvGyroY']

```
> W[Participant == 'p01' & Activity == 'VN' & Sensor == 'RS01' & Axis=='sg0zmuvGyroY']
   Participant Window Activity Sensor         Axis       REC    RATIO       DET
1:         p01   w500       VN   RS01 sg0zmuvGyroY 0.2894632 3.398288 0.9836793
           DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax    Vmean
1: 0.002173913  460 20.60368         20.45368 2.898608 0.9907505  107 28.81702
> 
```


W[Participant == 'p01' & Activity == 'VN' & Sensor == 'RS01' & Axis=='sg1zmuvGyroY']

```
> W[Participant == 'p01' & Activity == 'VN' & Sensor == 'RS01' & Axis=='sg1zmuvGyroY']
   Participant Window Activity Sensor         Axis       REC    RATIO       DET
1:         p01   w500       VN   RS01 sg1zmuvGyroY 0.3167075 3.148574 0.9971771
           DIV Lmax    Lmean LmeanWithoutMain     ENTR      LAM Vmax    Vmean
1: 0.002173913  460 37.43279         37.19643 3.696927 0.998544  113 51.61982
> 
```



W[Participant == 'p01' & Activity == 'VN' & Sensor == 'RS01' & Axis=='sg2zmuvGyroY']

```
> W[Participant == 'p01' & Activity == 'VN' & Sensor == 'RS01' & Axis=='sg2zmuvGyroY']
   Participant Window Activity Sensor         Axis       REC    RATIO      DET
1:         p01   w500       VN   RS01 sg2zmuvGyroY 0.3602985 2.773664 0.999347
           DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax    Vmean
1: 0.002173913  460 73.93333         73.55899 4.623798 0.9999216  132 74.62476
> 
```

       sg0zmuvGyroY  sg1zmuvGyroY  sg2zmuvGyroY 
----------------------------------------------HS01
REC     0.232   0.242   0.362 
DET     0.977   0.996   0.999
RATIO   4.206   4.108   2.760
ENTR    3.039   3.979   3.999

----------------------------------------------RS01
REC     0.289   0.316   0.360 
DET     0.983   0.997   0.999
RATIO   3.398   3.148   2.773
ENTR    2.898   3.696   4.623














# VF 

W[Participant == 'p01' & Activity == 'VF' & Sensor == 'HS01' & Axis=='sg0zmuvGyroY']


```
> W[Participant == 'p01' & Activity == 'VF' & Sensor == 'HS01' & Axis=='sg0zmuvGyroY']
   Participant Window Activity Sensor         Axis        REC    RATIO
1:         p01   w500       VF   HS01 sg0zmuvGyroY 0.05786252 16.63023
         DET         DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax
1: 0.9622672 0.005524862  181 10.26279         9.871528 2.527571 0.9812963   17
      Vmean
1: 7.069127
```


W[Participant == 'p01' & Activity == 'VF' & Sensor == 'HS01' & Axis=='sg1zmuvGyroY']


```
> W[Participant == 'p01' & Activity == 'VF' & Sensor == 'HS01' & Axis=='sg1zmuvGyroY']
   Participant Window Activity Sensor         Axis        REC    RATIO
1:         p01   w500       VF   HS01 sg1zmuvGyroY 0.06374429 15.56956
         DET         DIV Lmax    Lmean LmeanWithoutMain    ENTR      LAM Vmax
1: 0.9924707 0.002173913  460 23.30156         22.54167 3.25996 0.997195   17
      Vmean
1: 7.381967
```


W[Participant == 'p01' & Activity == 'VF' & Sensor == 'HS01' & Axis=='sg2zmuvGyroY']


```
> W[Participant == 'p01' & Activity == 'VF' & Sensor == 'HS01' & Axis=='sg2zmuvGyroY']
   Participant Window Activity Sensor         Axis       REC    RATIO       DET
1:         p01   w500       VF   HS01 sg2zmuvGyroY 0.1081352 9.234806 0.9986075
           DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax   Vmean
1: 0.002173913  460 66.13545         64.99422 4.088309 0.9996519   18 11.7509
```


W[Participant == 'p01' & Activity == 'VF' & Sensor == 'RS01' & Axis=='sg0zmuvGyroY']

```
> W[Participant == 'p01' & Activity == 'VF' & Sensor == 'RS01' & Axis=='sg0zmuvGyroY']
   Participant Window Activity Sensor         Axis        REC    RATIO
1:         p01   w500       VF   RS01 sg0zmuvGyroY 0.05346766 17.61328
         DET         DIV Lmax   Lmean LmeanWithoutMain     ENTR       LAM Vmax
1: 0.9417407 0.002898551  345 7.61637         7.293447 1.881356 0.9897914   14
      Vmean
1: 5.873107
```

W[Participant == 'p01' & Activity == 'VF' & Sensor == 'RS01' & Axis=='sg1zmuvGyroY']


```
> W[Participant == 'p01' & Activity == 'VF' & Sensor == 'RS01' & Axis=='sg1zmuvGyroY']
   Participant Window Activity Sensor         Axis        REC    RATIO
1:         p01   w500       VF   RS01 sg1zmuvGyroY 0.06858146 14.38112
         DET         DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax
1: 0.9862779 0.002173913  460 23.45024         22.73529 2.261837 0.9995883   13
      Vmean
1: 7.900759
```


W[Participant == 'p01' & Activity == 'VF' & Sensor == 'RS01' & Axis=='sg2zmuvGyroY']

```
> W[Participant == 'p01' & Activity == 'VF' & Sensor == 'RS01' & Axis=='sg2zmuvGyroY']
   Participant Window Activity Sensor         Axis       REC    RATIO       DET
1:         p01   w500       VF   RS01 sg2zmuvGyroY 0.1144875 8.729551 0.9994246
           DIV Lmax    Lmean LmeanWithoutMain     ENTR       LAM Vmax    Vmean
1: 0.002173913  460 154.8854         152.9231 3.625685 0.9996712   15 13.02785
> 
```


       sg0zmuvGyroZ  sg1zmuvGyroZ  sg2zmuvGyroZ 
----------------------------------------------HS01
REC      0.057    0.063   0.108
DET      0.962    0.992   0.998
RATIO   16.630   15.569   9.234
ENTR     2.527    3.259   4.088

----------------------------------------------RS01
REC      0.053   0.068  0.114
DET      0.941   0.986  0.999
RATIO   17.613  14.381  8.729
ENTR     1.881   2.261  3.625





# inkscape command

```

inkscape --export-pdf ../../../PDF/rp_aV.pdf rp_aV.svg

```


