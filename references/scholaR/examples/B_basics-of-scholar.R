
#reference
#https://www.google.com/search?q=Delay%20embeddings%20for%20forced%20systems.%20II.%20Stochastic%20forcing.%20


#install.packages("scholar")
library(scholar)


# Storing GS ID
E <- "Myvc78MAAAAJ"  #Dasapta Erwin Irawan
ES <- "6U_YtvMAAAAJ" #Edy Soewono
Kh <- "4_asJ0MAAAAJ" #K. Khairurrijal
JT <- "P7FvGMEAAAAJ" #Jonathan Tennant



#Getting GS profiles information
E.profile <- get_profile(E)
ES.profile <- get_profile(ES)
Kh.profile <- get_profile(Kh)
JT.profile <- get_profile(JT)

E.profile
ES.profile
Kh.profile
JT.profile

# How many papers have they published?
E.num <- get_num_articles(E)
ES.num <- get_num_articles(ES)
Kh.num <- get_num_articles(Kh)
JT.num <- get_num_articles(JT)

#num <- c(E.num, ES.num, Kh.num, JT.num)
barplot(num,
        names.arg=c("E", "ES", "Kh", "JT")) 


#Plotting citation history
ES.hist <- ggplot(ES.cite.year, aes(year,cites)) + 
  geom_bar(stat='identity',fill=colors()[128]) +
  scale_x_continuous(
    breaks = c(2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017))
