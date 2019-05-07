testing
---







# TESTING

octave --no-gui
readrawdataHII_labels
```

tunnig labels start and stop points:
```
vim labels_p01-p22_HII.txt 
```

When testing, be sure to change the lines for the row lines of starts and ends of the particpant:

```
p16_labels = labels(121:128,:);
```

```
octave --no-gui
readrawdataHII
```





## creating the separatged asctivies per participatns in 
`/home/map479/tmp/phdtmpdata/hii_time_aligned_timeseries`


```
octave --no-gui
hii_rawData_TO_TimeAlignedDataForSeparateActivities_p01_to_p22_octave_linux
```



data status

p01 data OK, aligment OK 
p02 data OK, aligment OK
p03 DISCARTED (s01 did not stream data)
p04 DISCARTED (s01 data is shifted)
p05 DISCARTED (s02 IS NOT COMPLETED)
p06 data OK, aligment OK (excpet for activity07)
p07 data OK, aligment OK
p08 data OK, aligment OK
p09 data OK, aligment OK
p10 data OK, aligment OK
p11 data OK, aligment OK
p12 DISCARTED data OK, aligment WRONG
p13 data OK, aligment OK
p14 data OK, aligment OK
p15 data OK, aligment OK
p16 data OK, aligment OK
p17 data OK, aligment OK
p18 data OK, aligment OK
p19 data OK, aligment OK
p20 DISCARTED data WRONG (s01 not completed)
p21 data OK, aligment SEMIOK (s02 is not well aligned)
p22 data OK, aligment SEMIOK (a07 is very shifted)

Fri 24 Aug 01:23:56 BST 2018





