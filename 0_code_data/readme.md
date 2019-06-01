# Code and data
This thesis has been written in GNU Linux Operating System
and tested in Ubuntu 14.04.5 LTS and Ubuntu 16.04.2 LTS.
For its replication, it is suggested that users 
install either Ubuntu 14.04.5 LTS or Ubuntu 16.04.2 LTS 
(other GNU Linux distributions can also work) 
with the latest version of R and its dependencies 
including GNU Octave version 4.0.2 
(see [here](/0_code_data/1_code/1_dependencies) for installation of dependencies).

## Organisation of paths
[`0_data`](/0_code_data/0_data) contains all the input data that is either 
retrieved from external sources or created manually. 
The core principle here is that nothing in this folder 
should ever be modified. 
The data in this folder should remain identical 
to the way that you have retrieved or manually created it.

[`1_code`](/0_code_data/1_code) contains for all code files. 
This includes:
* [`0_machineinfo`](/0_code_data/1_code/0_machineinfo)
* [`2_libraries_functions`](/0_code_data/1_code/1_dependencies)  
* [`1_dependencies`](/0_code_data/1_code/2_libraries_functions)
* [`3_anthropometrics`](/0_code_data/1_code/3_anthropometrics)
* [`4_figs_ch3`](/0_code_data/1_code/4_figs_ch3)
* [`5_creation_of_curated_timeseries`](/0_code_data/1_code/5_creation_of_curated_timeseries)
* [`6_figs_ch4`](/0_code_data/1_code/6_figs_ch4)
* [`7_figs_ch5`](/0_code_data/1_code/7_figs_ch5)
* [`8_figs_ch6`](/0_code_data/1_code/8_figs_ch6)         
* [`9_figs_appendixes`](/0_code_data/1_code/9_figs_appendixes)
* [`x_surrogate`](/0_code_data/1_code/x_surrogate)


## Replication of results
For figure replication, the paths are organised as follows: 
* `/code` contains R scripts that create figures in 
* `/scr`, and 
* `/vector` which contains the vector files.


# Clone github repository 
```
mkdir -p $HOME/phd && cd $HOME/phd 
git clone https://github.com/mxochicale/phd-thesis
# create temporal paths
mkdir -p $HOME/phd/tmp/phdtmpdata
```

