Setting up paths for packages and functions
---
The following are code extracs that are put into the code 
scripts to call either (i) nonlinearTseries packages or (ii)
different R functions.

# nonlinearTseries 

```
################################################################################
# (0) Defining paths for main_path, r_scripts_path, ..., etc.

homepath <- Sys.getenv("HOME")
setwd("../../../../")
github_repo_path <- getwd()
libfun_path <- '/0_code_data/1_code/2_libraries_functions'

library(devtools)
load_all(paste(github_repo_path, libfun_path, '/nonlinearTseries', sep=""))

```

# **NOTE** Remember to source the `cao97_functions.R` and `cao97sub.so`

```
homepath <- Sys.getenv("HOME")
github_path <- '/phd/phd-thesis'
path_cao97_functions_R <- '/0_code_data/1_code/2_libraries_functions/rfunctions/embedding_parameters/withCao1997/cao97_functions.R'

################################################################################
## CAO's Algorithm
##
source(paste(github_path, path_cao97_functions_R, sep=''))
```



set up `cao97sub.so` 
at `/0_code_data/1_code/2_libraries_functions/rfunctions/embedding_parameters/withCao1997/cao97_functions.R`

```
#### Setting up paths
homepath <- Sys.getenv("HOME")
github_path <- '/phd/phd-thesis'
path_cao97sub_so <- '/0_code_data/1_code/2_libraries_functions/rfunctions/embedding_parameters/withCao1997/cao97sub.so'
```



# `extra_rqa.R`


```
github_repo_path <- getwd()
libfun_path <- '/0_code_data/1_code/2_libraries_functions'
rfunctions_extra_rqa_R <- '/rfunctions/extra_rqa.R'

### Calling `functions_extra_nonlinearTseries` 
source( paste(github_repo_path, libfun_path, rfunctions_extra_rqa_R, sep='') )
```

# `ollin_cencah.R` 



```
github_repo_path <- getwd()
libfun_path <- '/0_code_data/1_code/2_libraries_functions'
rfunctions_ollin_cencah_R <- '/rfunctions/ollin_cencah.R'

### Calling `functions_ollin_cencah` 
source( paste(github_repo_path, libfun_path, rfunctions_ollin_cencah_R, sep='') )
```




