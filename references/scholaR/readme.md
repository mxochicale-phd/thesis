scholar: Analyse Citation Data from Google Scholar
---


* requirements for scholar library
```
Depends:	R (≥ 3.4.0)
Imports:	R.cache, dplyr, httr, rvest, stringr, xml2, tidygraph, ggraph, ggplot2
Suggests:	knitr, prettydoc, roxygen2
```
https://cran.r-project.org/web/packages/scholar/index.html




# 1. install or upgrate R [more](https://github.com/mxochicale/phd-thesis-code-data/tree/master/code/dependencies)

ubuntu libraries: 
```
sudo apt-get install libudunits2-dev
```


# 2. installation scholar library

```
R 
> source(paste(getwd(),"/install-scholar.R", sep=""), echo=TRUE)
```

# references

* https://cran.r-project.org/web/packages/scholar/index.html
* https://github.com/jkeirstead/scholar
* https://cran.r-project.org/web/packages/scholar/vignettes/scholar.html



# Corresponding BibTeX entry:
```
  @Manual{,
    author = {James Keirstead},
    title = {scholar: analyse citation data from Google Scholar},
    year = {2016},
    note = {R package version 0.1.5},
    url = {http://github.com/jkeirstead/scholar},
  }
```

