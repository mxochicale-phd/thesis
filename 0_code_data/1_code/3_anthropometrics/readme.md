
# 20 participants

```
datafilename <- 'data_20p.csv'
```

```
> source( paste( getwd(), '/computing_statistics.R' ,sep='' ), echo=TRUE )

> message('mean age: ', m, 'SD age: ' , sd)
mean age: 19.8SD age: 1.39924791829115
```



# 6 participants


* first filtering due to missing axis
p01 - p01
p02 - p02
p06 - p03
p07 - p04
p08 - p05
p09 - p06
p10 - p07
p11 - p08
p13 - p09
p14 - p10
p15 - p11
p16 - p12
p17 - p13
p18 - p14
p19 - p15
p21 - p16
p22 - p17

* second filtering due to syncronisation time drifting

p01 - p01 - p01
p07 - p04 - p02
p08 - p05 - p03
p14 - p10 - p04
p15 - p11 - p05
p19 - p15 - p06



```
datafilename <- 'data_06p.csv'
```


```
> source( paste( getwd(), '/computing_statistics.R' ,sep='' ), echo=TRUE )

> message('mean age: ', m, 'SD age: ' , sd)
mean age: 19.5SD age: 0.836660026534076

```



