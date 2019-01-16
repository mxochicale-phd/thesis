

#reference
#https://cran.r-project.org/web/packages/scholar/vignettes/scholar.html

library(scholar)


## Define the id for Richard Feynman
id <- 'B7vSqZsAAAAJ'

## Get his profile
l <- get_profile(id)

## Print his name and affliation
l$name


ct <- get_citation_history(id)


## Plot citation trend
library(ggplot2)
ggplot(ct, aes(year, cites)) + geom_line() + geom_point()



# Visualizing and comparing network of coauthors

# Be careful with specifying too many coauthors as the visualization of the
# network can get very messy.
coauthor_network <- get_coauthors('amYIKXQAAAAJ&hl', n_coauthors = 7)
#coauthor_network

plot_coauthors(coauthor_network)



