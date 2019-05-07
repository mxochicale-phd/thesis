mscripts
---


# 0. create /tmp for data output


```
cd $HOME/phd/phd-thesis/0_code_data/1_code/5_creation_of_curated_timeseries/code_raw2aligned/mscripts 
sh mkdir_tmp_phdtmpdata.sh
```


`mkdir_tmp_phdtmpdata.sh` contains:
```
mkdir -p $HOME/phd/tmp/phdtmpdata
```








# HRI

## Setting Up Paths

Set the paths where data is going to be saved and
check carefully where does the following paths are well defined.
```
cd ..;
cd ..;
main_path = pwd;
cd ..;
cd ..;
cd ..;
cd ..;
user_path = pwd;


data_path='/data_raw_p01-p22'
tmpdatapath='/tmp/phdtmpdata';
```


## Usage


## 2. Open a new terminal to run octave
```
octave --no-gui
```

Then run the m script:

```
hri_rawData_TO_TimeAlignedDataForSeparateActivities_p01_to_p22_octave_linux
```

output

```
data_path = /data_raw_p01-p22
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/time_aligned_different_length_data_for_separate_activities_p01_to_p22_octave_linux/')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/time_aligned_different_length_data_for_separate_activities_p01_to_p22_octave_linux/p01-HRI//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/time_aligned_different_length_data_for_separate_activities_p01_to_p22_octave_linux/p02-HRI//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/time_aligned_different_length_data_for_separate_activities_p01_to_p22_octave_linux/p03-HRI//')
  [2,1] = 0
}
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0
ans = 0


```



## 3. outcome data path






```
~/phd/tmp/phdtmpdata$ tree -d
.
└── hri_time_aligned_timeseries
    └── data_raw_p01-p22
        ├── p01
        ├── p02
        ├── p03
        ├── p04
        ├── p05
        ├── p06
        ├── p07
        ├── p08
        ├── p09
        ├── p10
        ├── p11
        ├── p12
        ├── p13
        ├── p14
        ├── p15
        ├── p16
        ├── p17
        ├── p18
        ├── p19
        ├── p20
        ├── p21
        └── p22

24 directories
```





# HII


## 2. Open a new terminal to run octave
```
octave --no-gui
```

Then run the m script:

```
hii_rawData_TO_TimeAlignedDataForSeparateActivities_p01_to_p22_octave_linux
```

output

```

octave:1> hii_rawData_TO_TimeAlignedDataForSeparateActivities_p01_to_p22_octave_linux
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p01-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p02-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p06-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p07-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p08-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p09-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p10-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p11-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p13-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p14-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p15-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p16-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p17-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p18-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p19-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p21-HII//')
  [2,1] = 0
}
ans = 
{
  [1,1] = system( 'mkdir -p /home/ai/tmp/phdtmpdata/hii_time_aligned_timeseries/p22-HII//')
  [2,1] = 0
}

```



## 3. outcome data path



```
~/phd/tmp/phdtmpdata$ tree -d
.
├── hii_time_aligned_timeseries
│   └── data_raw_p01-p22
│       ├── p01
│       ├── p02
│       ├── p06
│       ├── p07
│       ├── p08
│       ├── p09
│       ├── p10
│       ├── p11
│       ├── p13
│       ├── p14
│       ├── p15
│       ├── p16
│       ├── p17
│       ├── p18
│       ├── p19
│       ├── p21
│       └── p22

```



