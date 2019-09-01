


# Fri 30 Aug 21:50:55 BST 2019

## pdflatex

```
$ pdflatex --version
pdfTeX 3.14159265-2.6-1.40.20 (TeX Live 2019)
kpathsea version 6.3.1
Copyright 2019 Han The Thanh (pdfTeX) et al.
There is NO warranty.  Redistribution of this software is
covered by the terms of both the pdfTeX copyright and
the Lesser GNU General Public License.
For more information about these matters, see the file
named COPYING and the pdfTeX source.
Primary author of pdfTeX: Han The Thanh (pdfTeX) et al.
Compiled with libpng 1.6.36; using libpng 1.6.36
Compiled with zlib 1.2.11; using zlib 1.2.11
Compiled with xpdf version 4.01
```

## inkscape 


```
$ inkscape -V
Inkscape 0.92.4 (unknown)
```

## make

```
$ make -v
GNU Make 4.1
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2014 Free Software Foundation, Inc.
Licence GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```



## vim 



```
$ vim --v
VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Jun 06 2019 17:31:41)
Unknown option argument: "--v"
More info with: "vim -h"
```

## R

```

$ R --version
R version 3.6.1 (2019-07-05) -- "Action of the Toes"
Copyright (C) 2019 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License versions 2 or 3.
For more information about these matters see
https://www.gnu.org/licenses/.


```



```
$ R
> sessionInfo()
R version 3.6.1 (2019-07-05)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 18.04.3 LTS

Matrix products: default
BLAS:   /usr/lib/x86_64-linux-gnu/openblas/libblas.so.3
LAPACK: /usr/lib/x86_64-linux-gnu/libopenblasp-r0.2.20.so

locale:
 [1] LC_CTYPE=en_GB.UTF-8       LC_NUMERIC=C              
 [3] LC_TIME=en_GB.UTF-8        LC_COLLATE=en_GB.UTF-8    
 [5] LC_MONETARY=en_GB.UTF-8    LC_MESSAGES=en_GB.UTF-8   
 [7] LC_PAPER=en_GB.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=en_GB.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

loaded via a namespace (and not attached):
[1] compiler_3.6.1
> 

```



```
$ R
>  installed.packages(.Library, priority = "high")
           Package      LibPath              Version    Priority     
base       "base"       "/usr/lib/R/library" "3.6.1"    "base"       
boot       "boot"       "/usr/lib/R/library" "1.3-23"   "recommended"
class      "class"      "/usr/lib/R/library" "7.3-15"   "recommended"
cluster    "cluster"    "/usr/lib/R/library" "2.1.0"    "recommended"
codetools  "codetools"  "/usr/lib/R/library" "0.2-16"   "recommended"
compiler   "compiler"   "/usr/lib/R/library" "3.6.1"    "base"       
datasets   "datasets"   "/usr/lib/R/library" "3.6.1"    "base"       
foreign    "foreign"    "/usr/lib/R/library" "0.8-72"   "recommended"
graphics   "graphics"   "/usr/lib/R/library" "3.6.1"    "base"       
grDevices  "grDevices"  "/usr/lib/R/library" "3.6.1"    "base"       
grid       "grid"       "/usr/lib/R/library" "3.6.1"    "base"       
KernSmooth "KernSmooth" "/usr/lib/R/library" "2.23-15"  "recommended"
lattice    "lattice"    "/usr/lib/R/library" "0.20-38"  "recommended"
MASS       "MASS"       "/usr/lib/R/library" "7.3-51.4" "recommended"
Matrix     "Matrix"     "/usr/lib/R/library" "1.2-17"   "recommended"
methods    "methods"    "/usr/lib/R/library" "3.6.1"    "base"       
mgcv       "mgcv"       "/usr/lib/R/library" "1.8-28"   "recommended"
nlme       "nlme"       "/usr/lib/R/library" "3.1-141"  "recommended"
nnet       "nnet"       "/usr/lib/R/library" "7.3-12"   "recommended"
parallel   "parallel"   "/usr/lib/R/library" "3.6.1"    "base"       
rpart      "rpart"      "/usr/lib/R/library" "4.1-15"   "recommended"
spatial    "spatial"    "/usr/lib/R/library" "7.3-11"   "recommended"
splines    "splines"    "/usr/lib/R/library" "3.6.1"    "base"       
stats      "stats"      "/usr/lib/R/library" "3.6.1"    "base"       
stats4     "stats4"     "/usr/lib/R/library" "3.6.1"    "base"       
survival   "survival"   "/usr/lib/R/library" "2.44-1.1" "recommended"
tcltk      "tcltk"      "/usr/lib/R/library" "3.6.1"    "base"       
tools      "tools"      "/usr/lib/R/library" "3.6.1"    "base"       
utils      "utils"      "/usr/lib/R/library" "3.6.1"    "base"       
           Depends                                          
base       NA                                               
boot       "R (>= 3.0.0), graphics, stats"                  
class      "R (>= 3.0.0), stats, utils"                     
cluster    "R (>= 3.3.0)"                                   
codetools  "R (>= 2.1)"                                     
compiler   NA                                               
datasets   NA                                               
foreign    "R (>= 3.0.0)"                                   
graphics   NA                                               
grDevices  NA                                               
grid       NA                                               
KernSmooth "R (>= 2.5.0), stats"                            
lattice    "R (>= 3.0.0)"                                   
MASS       "R (>= 3.1.0), grDevices, graphics, stats, utils"
Matrix     "R (>= 3.2.0)"                                   
methods    NA                                               
mgcv       "R (>= 2.14.0), nlme (>= 3.1-64)"                
nlme       "R (>= 3.4.0)"                                   
nnet       "R (>= 2.14.0), stats, utils"                    
parallel   NA                                               
rpart      "R (>= 2.15.0), graphics, stats, grDevices"      
spatial    "R (>= 3.0.0), graphics, stats, utils"           
splines    NA                                               
stats      NA                                               
stats4     NA                                               
survival   "R (>= 2.13.0)"                                  
tcltk      NA                                               
tools      NA                                               
utils      NA                                               
           Imports                                            LinkingTo
base       NA                                                 NA       
boot       NA                                                 NA       
class      "MASS"                                             NA       
cluster    "graphics, grDevices, stats, utils"                NA       
codetools  NA                                                 NA       
compiler   NA                                                 NA       
datasets   NA                                                 NA       
foreign    "methods, utils, stats"                            NA       
graphics   "grDevices"                                        NA       
grDevices  NA                                                 NA       
grid       "grDevices, utils"                                 NA       
KernSmooth NA                                                 NA       
lattice    "grid, grDevices, graphics, stats, utils"          NA       
MASS       "methods"                                          NA       
Matrix     "methods, graphics, grid, stats, utils, lattice"   NA       
methods    "utils, stats"                                     NA       
mgcv       "methods, stats, graphics, Matrix, splines, utils" NA       
nlme       "graphics, stats, utils, lattice"                  NA       
nnet       NA                                                 NA       
parallel   "tools, compiler"                                  NA       
rpart      NA                                                 NA       
spatial    NA                                                 NA       
splines    "graphics, stats"                                  NA       
stats      "utils, grDevices, graphics"                       NA       
stats4     "graphics, methods, stats"                         NA       
survival   "graphics, Matrix, methods, splines, stats, utils" NA       
tcltk      "utils"                                            NA       
tools      NA                                                 NA       
utils      NA                                                 NA       
           Suggests                                    
base       "methods"                                   
boot       "MASS, survival"                            
class      NA                                          
cluster    "MASS, Matrix"                              
codetools  NA                                          
compiler   NA                                          
datasets   NA                                          
foreign    NA                                          
graphics   NA                                          
grDevices  "KernSmooth"                                
grid       "lattice"                                   
KernSmooth "MASS"                                      
lattice    "KernSmooth, MASS, latticeExtra"            
MASS       "lattice, nlme, nnet, survival"             
Matrix     "expm, MASS"                                
methods    "codetools"                                 
mgcv       "parallel, survival, MASS"                  
nlme       "Hmisc, MASS"                               
nnet       "MASS"                                      
parallel   "methods"                                   
rpart      "survival"                                  
spatial    "MASS"                                      
splines    "Matrix, methods"                           
stats      "MASS, Matrix, SuppDists, methods, stats4"  
stats4     NA                                          
survival   NA                                          
tcltk      NA                                          
tools      "codetools, methods, xml2, curl, commonmark"
utils      "methods, xml2, commonmark"                 
           Enhances                                License                    
base       NA                                      "Part of R 3.6.1"          
boot       NA                                      "Unlimited"                
class      NA                                      "GPL-2 | GPL-3"            
cluster    NA                                      "GPL (>= 2)"               
codetools  NA                                      "GPL"                      
compiler   NA                                      "Part of R 3.6.1"          
datasets   NA                                      "Part of R 3.6.1"          
foreign    NA                                      "GPL (>= 2)"               
graphics   NA                                      "Part of R 3.6.1"          
grDevices  NA                                      "Part of R 3.6.1"          
grid       NA                                      "Part of R 3.6.1"          
KernSmooth NA                                      "Unlimited"                
lattice    "chron"                                 "GPL (>= 2)"               
MASS       NA                                      "GPL-2 | GPL-3"            
Matrix     "MatrixModels, graph, SparseM, sfsmisc" "GPL (>= 2) | file LICENCE"
methods    NA                                      "Part of R 3.6.1"          
mgcv       NA                                      "GPL (>= 2)"               
nlme       NA                                      "GPL (>= 2) | file LICENCE"
nnet       NA                                      "GPL-2 | GPL-3"            
parallel   "snow, nws, Rmpi"                       "Part of R 3.6.1"          
rpart      NA                                      "GPL-2 | GPL-3"            
spatial    NA                                      "GPL-2 | GPL-3"            
splines    NA                                      "Part of R 3.6.1"          
stats      NA                                      "Part of R 3.6.1"          
stats4     NA                                      "Part of R 3.6.1"          
survival   NA                                      "LGPL (>= 2)"              
tcltk      NA                                      "Part of R 3.6.1"          
tools      NA                                      "Part of R 3.6.1"          
utils      NA                                      "Part of R 3.6.1"          
           License_is_FOSS License_restricts_use OS_type MD5sum
base       NA              NA                    NA      NA    
boot       NA              NA                    NA      NA    
class      NA              NA                    NA      NA    
cluster    NA              NA                    NA      NA    
codetools  NA              NA                    NA      NA    
compiler   NA              NA                    NA      NA    
datasets   NA              NA                    NA      NA    
foreign    NA              NA                    NA      NA    
graphics   NA              NA                    NA      NA    
grDevices  NA              NA                    NA      NA    
grid       NA              NA                    NA      NA    
KernSmooth NA              NA                    NA      NA    
lattice    NA              NA                    NA      NA    
MASS       NA              NA                    NA      NA    
Matrix     NA              NA                    NA      NA    
methods    NA              NA                    NA      NA    
mgcv       NA              NA                    NA      NA    
nlme       NA              NA                    NA      NA    
nnet       NA              NA                    NA      NA    
parallel   NA              NA                    NA      NA    
rpart      NA              NA                    NA      NA    
spatial    NA              NA                    NA      NA    
splines    NA              NA                    NA      NA    
stats      NA              NA                    NA      NA    
stats4     NA              NA                    NA      NA    
survival   NA              NA                    NA      NA    
tcltk      NA              NA                    NA      NA    
tools      NA              NA                    NA      NA    
utils      NA              NA                    NA      NA    
           NeedsCompilation Built  
base       NA               "3.6.1"
boot       "no"             "3.6.1"
class      "yes"            "3.5.2"
cluster    "yes"            "3.6.1"
codetools  "no"             "3.5.2"
compiler   NA               "3.6.1"
datasets   NA               "3.6.1"
foreign    "yes"            "3.6.1"
graphics   "yes"            "3.6.1"
grDevices  "yes"            "3.6.1"
grid       "yes"            "3.6.1"
KernSmooth "yes"            "3.5.0"
lattice    "yes"            "3.5.1"
MASS       "yes"            "3.6.1"
Matrix     "yes"            "3.6.1"
methods    "yes"            "3.6.1"
mgcv       "yes"            "3.6.1"
nlme       "yes"            "3.6.1"
nnet       "yes"            "3.5.0"
parallel   "yes"            "3.6.1"
rpart      "yes"            "3.6.1"
spatial    "yes"            "3.5.0"
splines    "yes"            "3.6.1"
stats      "yes"            "3.6.1"
stats4     NA               "3.6.1"
survival   "yes"            "3.6.1"
tcltk      "yes"            "3.6.1"
tools      "yes"            "3.6.1"
utils      "yes"            "3.6.1"
> 


```
