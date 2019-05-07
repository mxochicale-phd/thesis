logbook
---









# `source(  paste( getwd(), '/D_rqa.R', sep=''), echo=TRUE )`



```
##########################
##### one window lenght
windowsl <- c(500)
windowsn <- c('w10')
dimensions <- c(6)
delays <- c(8)
```




```
> end.time - start.time
Time difference of 11.30023 mins

```

```
> head(W)
   Participant Window Activity Sensor         Axis       REC     RATIO
1:         p01   w500       HN   HS01 sg0zmuvGyroY 1.0000000 0.9999906
2:         p01   w500       HN   HS01 sg1zmuvGyroY 1.0000000 0.9999906
3:         p01   w500       HN   HS01 sg2zmuvGyroY 1.0000000 0.9999906
4:         p01   w500       HN   HS01 sg0zmuvGyroZ 0.2326405 4.2650914
5:         p01   w500       HN   HS01 sg1zmuvGyroZ 0.2361320 4.2217554
6:         p01   w500       HN   HS01 sg2zmuvGyroZ 0.3088777 3.2355544
         DET         DIV Lmax     Lmean LmeanWithoutMain     ENTR       LAM
1: 0.9999906 0.002173913  460 231.25027        231.00000 6.130893 1.0000000
2: 0.9999906 0.002173913  460 231.25027        231.00000 6.130893 1.0000000
3: 0.9999906 0.002173913  460 231.25027        231.00000 6.130893 1.0000000
4: 0.9922332 0.002173913  460  28.37305         28.12269 3.399105 0.9971481
5: 0.9968914 0.002173913  460  40.31185         39.97258 3.915544 0.9994022
6: 0.9993906 0.002173913  460  85.08820         84.60000 4.640236 0.9998172
   Vmax     Vmean
1:  461 461.00000
2:  461 461.00000
3:  461 461.00000
4:   83  32.18016
5:   94  38.87829
6:   97  52.63111

```




```
    └── [       4096 May  5 12:42]  hri
        ├── [       4096 May  5 12:42]  rqa
        │   └── [     179635 May  5 12:42]  rqa_w10.dt
```








# `> source(  paste( getwd(), '/Ea_rqa_plots_aH.R', sep=''), echo=TRUE )`

```
#windowksecs <- c('w2')
#windowksecs <- c('w5')
windowksecs <- c('w10')
#windowksecs <- c('w15')
```



```
> end.time - start.time
Time difference of 6.124626 secs
```





# `> source(  paste( getwd(), '/Eb_rqa_plots_aV.R', sep=''), echo=TRUE )`

```
#windowksecs <- c('w2')
#windowksecs <- c('w5')
windowksecs <- c('w10')
#windowksecs <- c('w15')
```



```
> end.time - start.time
Time difference of 5.761256 secs
```


# $ tree -s

```
.
├── [       4096]  H
│   ├── [      15102]  det_bp_HF_HS01.png
│   ├── [      16202]  det_bp_HF_RS01.png
│   ├── [      13392]  det_bp_HN_HS01.png
│   ├── [      13644]  det_bp_HN_RS01.png
│   ├── [      20303]  entr_bp_HF_HS01.png
│   ├── [      17303]  entr_bp_HF_RS01.png
│   ├── [      20150]  entr_bp_HN_HS01.png
│   ├── [      15477]  entr_bp_HN_RS01.png
│   ├── [      28621]  ratio_bp_HF_HS01.png
│   ├── [      19122]  ratio_bp_HF_RS01.png
│   ├── [      20386]  ratio_bp_HN_HS01.png
│   ├── [      15591]  ratio_bp_HN_RS01.png
│   ├── [      18917]  rec_bp_HF_HS01.png
│   ├── [      14605]  rec_bp_HF_RS01.png
│   ├── [      26342]  rec_bp_HN_HS01.png
│   └── [      15795]  rec_bp_HN_RS01.png
└── [       4096]  V
    ├── [      15624]  det_bp_VF_HS01.png
    ├── [      14736]  det_bp_VF_RS01.png
    ├── [      13890]  det_bp_VN_HS01.png
    ├── [      13357]  det_bp_VN_RS01.png
    ├── [      20349]  entr_bp_VF_HS01.png
    ├── [      17126]  entr_bp_VF_RS01.png
    ├── [      22539]  entr_bp_VN_HS01.png
    ├── [      16306]  entr_bp_VN_RS01.png
    ├── [      24710]  ratio_bp_VF_HS01.png
    ├── [      16270]  ratio_bp_VF_RS01.png
    ├── [      16637]  ratio_bp_VN_HS01.png
    ├── [      14898]  ratio_bp_VN_RS01.png
    ├── [      17946]  rec_bp_VF_HS01.png
    ├── [      14240]  rec_bp_VF_RS01.png
    ├── [      25384]  rec_bp_VN_HS01.png
    └── [      15565]  rec_bp_VN_RS01.png

2 directories, 32 files
```



