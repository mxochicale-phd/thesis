logbook
---



# `source(  paste( getwd(), '/D_rqa.R', sep=''), echo=TRUE )`


```
> end.time - start.time
Time difference of 6.124347 mins

```



```

└── [       4096 May  1 22:51]  1_datasets
    └── [       4096 May  3  5:36]  hii
        ├── [       4096 May  3  5:36]  rqa
        │   └── [     112361 May  3  5:36]  rqa_w10.dt


```


```

> head(W)
   Participant Window Activity Sensor         Axis        REC      RATIO
1:         p01   w500     HNnb   HS01 sg0zmuvGyroY 0.66728013  1.4689405
2:         p01   w500     HNnb   HS01 sg1zmuvGyroY 0.69762707  1.4244194
3:         p01   w500     HNnb   HS01 sg2zmuvGyroY 1.00000000  0.9999902
4:         p01   w500     HNnb   HS01 sg0zmuvGyroZ 0.04747827 20.6106235
5:         p01   w500     HNnb   HS01 sg1zmuvGyroZ 0.05204989 19.0136019
6:         p01   w500     HNnb   HS01 sg2zmuvGyroZ 0.35145665  2.8382477
         DET         DIV Lmax     Lmean LmeanWithoutMain     ENTR       LAM
1: 0.9801948 0.002217295  451  19.66564         19.60200 2.722548 0.9900167
2: 0.9937135 0.002217295  451  45.40943         45.27903 3.713611 0.9983512
3: 0.9999902 0.002217295  451 226.75028        226.50000 6.111127 1.0000000
4: 0.9785567 0.002217295  451  23.20782         22.15686 3.057082 0.9864948
5: 0.9896558 0.002217295  451  28.52033         27.36957 3.332376 0.9934173
6: 0.9975210 0.002217295  451  57.34668         57.03045 4.045507 0.9996797
   Vmax      Vmean
1:  270  25.241631
2:  368  42.061188
3:  452 452.000000
4:   55   5.788869
5:   56   5.849391
6:  165  25.151016
> 


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
Time difference of 10.35239 secs
```



```
├── [ 14K]  det_bp_w10_HFnb_HS01.png
├── [ 14K]  det_bp_w10_HFnb_HS02.png
├── [ 13K]  det_bp_w10_HFwb_HS01.png
├── [ 13K]  det_bp_w10_HFwb_HS02.png
├── [ 13K]  det_bp_w10_HNnb_HS01.png
├── [ 13K]  det_bp_w10_HNnb_HS02.png
├── [ 13K]  det_bp_w10_HNwb_HS01.png
├── [ 13K]  det_bp_w10_HNwb_HS02.png
├── [ 16K]  entr_bp_w10_HFnb_HS01.png
├── [ 17K]  entr_bp_w10_HFnb_HS02.png
├── [ 15K]  entr_bp_w10_HFwb_HS01.png
├── [ 16K]  entr_bp_w10_HFwb_HS02.png
├── [ 15K]  entr_bp_w10_HNnb_HS01.png
├── [ 15K]  entr_bp_w10_HNnb_HS02.png
├── [ 15K]  entr_bp_w10_HNwb_HS01.png
├── [ 15K]  entr_bp_w10_HNwb_HS02.png
├── [ 17K]  ratio_bp_w10_HFnb_HS01.png
├── [ 18K]  ratio_bp_w10_HFnb_HS02.png
├── [ 18K]  ratio_bp_w10_HFwb_HS01.png
├── [ 18K]  ratio_bp_w10_HFwb_HS02.png
├── [ 19K]  ratio_bp_w10_HNnb_HS01.png
├── [ 19K]  ratio_bp_w10_HNnb_HS02.png
├── [ 16K]  ratio_bp_w10_HNwb_HS01.png
├── [ 16K]  ratio_bp_w10_HNwb_HS02.png
├── [ 17K]  rec_bp_w10_HFnb_HS01.png
├── [ 17K]  rec_bp_w10_HFnb_HS02.png
├── [ 16K]  rec_bp_w10_HFwb_HS01.png
├── [ 16K]  rec_bp_w10_HFwb_HS02.png
├── [ 17K]  rec_bp_w10_HNnb_HS01.png
├── [ 17K]  rec_bp_w10_HNnb_HS02.png
├── [ 18K]  rec_bp_w10_HNwb_HS01.png
└── [ 17K]  rec_bp_w10_HNwb_HS02.png
```










# `> source(  paste( getwd(), '/Eb_rqa_plots_aV.R', sep=''), echo=TRUE )`

```
#windowksecs <- c('w2')
#windowksecs <- c('w5')
windowksecs <- c('w10')
#windowksecs <- c('w15')
```


> end.time - start.time
Time difference of 9.968773 secs





```
├── [ 14K]  det_bp_w10_VFnb_HS01.png
├── [ 15K]  det_bp_w10_VFnb_HS02.png
├── [ 14K]  det_bp_w10_VFwb_HS01.png
├── [ 14K]  det_bp_w10_VFwb_HS02.png
├── [ 14K]  det_bp_w10_VNnb_HS01.png
├── [ 14K]  det_bp_w10_VNnb_HS02.png
├── [ 13K]  det_bp_w10_VNwb_HS01.png
├── [ 13K]  det_bp_w10_VNwb_HS02.png
├── [ 16K]  entr_bp_w10_VFnb_HS01.png
├── [ 16K]  entr_bp_w10_VFnb_HS02.png
├── [ 15K]  entr_bp_w10_VFwb_HS01.png
├── [ 15K]  entr_bp_w10_VFwb_HS02.png
├── [ 16K]  entr_bp_w10_VNnb_HS01.png
├── [ 16K]  entr_bp_w10_VNnb_HS02.png
├── [ 15K]  entr_bp_w10_VNwb_HS01.png
├── [ 16K]  entr_bp_w10_VNwb_HS02.png
├── [ 18K]  ratio_bp_w10_VFnb_HS01.png
├── [ 18K]  ratio_bp_w10_VFnb_HS02.png
├── [ 19K]  ratio_bp_w10_VFwb_HS01.png
├── [ 18K]  ratio_bp_w10_VFwb_HS02.png
├── [ 19K]  ratio_bp_w10_VNnb_HS01.png
├── [ 19K]  ratio_bp_w10_VNnb_HS02.png
├── [ 16K]  ratio_bp_w10_VNwb_HS01.png
├── [ 16K]  ratio_bp_w10_VNwb_HS02.png
├── [ 17K]  rec_bp_w10_VFnb_HS01.png
├── [ 17K]  rec_bp_w10_VFnb_HS02.png
├── [ 17K]  rec_bp_w10_VFwb_HS01.png
├── [ 16K]  rec_bp_w10_VFwb_HS02.png
├── [ 17K]  rec_bp_w10_VNnb_HS01.png
├── [ 17K]  rec_bp_w10_VNnb_HS02.png
├── [ 19K]  rec_bp_w10_VNwb_HS01.png
└── [ 19K]  rec_bp_w10_VNwb_HS02.png
```






