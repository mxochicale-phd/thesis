@article{PhysRevE.65.056201,
  title = {Markov models from data by simple nonlinear time series predictors in delay embedding spaces},
  author = {Ragwitz, Mario and Kantz, Holger},
  journal = {Phys. Rev. E},
  volume = {65},
  issue = {5},
  pages = {056201},
  numpages = {12},
  year = {2002},
  month = {Apr},
  publisher = {American Physical Society},
  doi = {10.1103/PhysRevE.65.056201},
  url = {https://link.aps.org/doi/10.1103/PhysRevE.65.056201}
}




# Wollstadt et al. 2014 

```
@article{10.1371/journal.pone.0102833,
    author = {Wollstadt, Patricia AND Martínez-Zarzuela, Mario AND Vicente, Raul AND Díaz-Pernas, Francisco J. AND Wibral, Michael},
    journal = {PLOS ONE},
    publisher = {Public Library of Science},
    title = {Efficient Transfer Entropy Analysis of Non-Stationary Neural Time Series},
    year = {2014},
    month = {07},
    volume = {9},
    url = {https://doi.org/10.1371/journal.pone.0102833},
    pages = {1-21},
    number = {7},
    doi = {10.1371/journal.pone.0102833}
}
```



Wollstadt et al. examplify the the state varaibles witht he use of the pendulum
exmaple where for instance a random variable at Yt in its lowest point in the 
pendulum can be standing still, going left or going rigth to which
a collection of past random raviables help to describe the sate of the 
process. which can then be reconsctruicted using Takens' method


present the background on Stationarity and non-stationarity in experimental time series

Addtinally, Wollstadt et al. 2014 pointed out the importance 
fo the selection embedding parmeters for time-delay embedding matrix.
Where for example The origninal Takens theomre mainly works for 
lowdimenseion determiistic sytems (such as the pendulum) 
which are not the case for real signals
which esentially ahd high dimensional stochastic determistic systems
(well descripbed by nonlinear Langevin questions).
With that in mind, Wolltadt et al. 2014 refer to Ragwitz and Kantz 2002
whom proposed that the scalar observables can be approximated
with a finite order, one-dimensional Markov-process.



# little2007

@Article{Little2007,
author="Little, Max A.
and McSharry, Patrick E.
and Roberts, Stephen J.
and Costello, Declan AE
and Moroz, Irene M.",
title="Exploiting Nonlinear Recurrence and Fractal Scaling Properties for Voice Disorder Detection",
journal="BioMedical Engineering OnLine",
year="2007",
month="Jun",
day="26",
volume="6",
number="1",
pages="23",
issn="1475-925X",
doi="10.1186/1475-925X-6-23",
url="https://doi.org/10.1186/1475-925X-6-23"
}

similarly, little et al. 2007 employed the langevin equations
( udot(t)= f( u(t) )  + \epsilon(t) , where epsilon constitute stochastic system and unknown f (.)
consitutes the deterministic part )
of which given an initianl conditons to u(0) then 
solutions of this dymamical systems are called trajectories 
whcih "can satisfy the properties of a stochastic process
with finite memory as known as higher-der Markov chain".
such dynamical systems is used to  model speech singals 
which are not only considered as determinis but also 
with its stochascrit properties. 

Little et al. 2007 pointed out that 
classical methods (e.g. false nearest neightbours and average mutial information)
to compute the embedding paratermers only work for 
"pure determinisc signals" for which alternative methods 
like Ragwitz and Kantz 2002 are employed to optimse 
the calculation of those parameters
for signals that come from both determinsic and stochastic systems.







# Wibral et al. 2013
http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0055809


@article{10.1371/journal.pone.0055809,
    author = {Wibral, Michael AND Pampu, Nicolae AND Priesemann, Viola AND Siebenhühner, Felix AND Seiwert, Hannes AND Lindner, Michael AND Lizier, Joseph T. AND Vicente, Raul},
    journal = {PLOS ONE},
    publisher = {Public Library of Science},
    title = {Measuring Information-Transfer Delays},
    year = {2013},
    month = {02},
    volume = {8},
    url = {https://doi.org/10.1371/journal.pone.0055809},
    pages = {1-19},
    number = {2},
    doi = {10.1371/journal.pone.0055809}
}


# linder2011

@Article{Lindner2011,
author="Lindner, Michael
and Vicente, Raul
and Priesemann, Viola
and Wibral, Michael",
title="TRENTOOL: A Matlab open source toolbox to analyse information flow in time series data with transfer entropy",
journal="BMC Neuroscience",
year="2011",
month="Nov",
day="18",
volume="12",
number="1",
pages="119",
issn="1471-2202",
doi="10.1186/1471-2202-12-119",
url="https://doi.org/10.1186/1471-2202-12-119"
}

Ragwitz criterion
https://bmcneurosci.biomedcentral.com/articles/10.1186/1471-2202-12-119#Sec2




https://trentool.github.io/TRENTOOL3/
https://github.com/trentool/TRENTOOL3/blob/master/TEprepare.m



# lizier2014

https://www.frontiersin.org/articles/10.3389/frobt.2014.00011/full

@ARTICLE{10.3389/frobt.2014.00011,
  
AUTHOR={Lizier, Joseph T.},   
	 
TITLE={JIDT: An Information-Theoretic Toolkit for Studying the Dynamics of Complex Systems},      
	
JOURNAL={Frontiers in Robotics and AI},      
	
VOLUME={1},      

PAGES={11},     
	
YEAR={2014},      
	  
URL={https://www.frontiersin.org/article/10.3389/frobt.2014.00011},       
	
DOI={10.3389/frobt.2014.00011},      
	
ISSN={2296-9144},   
   
}

https://jlizier.github.io/jidt/




# Wibral et al. 2018


 ... https://arxiv.org/pdf/1412.0291.pdf
the negatives for choosing other parameters thant the optimal
regarding the computation of transfer entropy


which can lead to 
* "   to  false  positive  findings  and reversed  directions  
of  information  transfer  (Vicente  et  al.,  2011); "

* failer to compute transfer entropy
(Smirnov, 2013);

* impediment of clear identificaion of coherent movig structures
 (Lizier et al., 2008c).














