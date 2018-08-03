@article{GOMEZGARCIA2014148,

@article{gomezgarcia2014,
title = "Non uniform Embedding based on Relevance Analysis with reduced computational complexity: Application to the detection of pathologies from biosignal recordings",
journal = "Neurocomputing",
volume = "132",
number = "Supplement C",
pages = "148 - 158",
year = "2014",
note = "Innovations in Nature Inspired Optimization and Learning Methods Machines learning for Non-Linear Processing",
issn = "0925-2312",
author = "Jorge A. Gómez-García and Juan I. Godino-Llorente and Germán Castellanos-Dominguez",
keywords = "Nonlinear dynamics, Non uniform embedding, Time-delay embedding"
}

doi = "https://doi.org/10.1016/j.neucom.2013.01.059",
url = "http://www.sciencedirect.com/science/article/pii/S0925231213009016",

# 15 December 2017 at 15:17

from:	Miguel P. Xochicale <perez.xochicale@gmail.com>
to:	jorge.gomez.garcia@upm.es
date:	15 December 2017 at 15:17
subject:	source code for one of your publications?
mailed-by:	gmail.com

Dear Jorge,

I am wondering if you have any repository of your code from your paper:

"Non uniform Embedding based on Relevance Analysis with reduced
computational complexity: Application to the detection of pathologies
from biosignal recordings"

I want to understand more about the the implementation of the
algorithms and replicate your results.

Regards



# Tuesday 16 January 2017

jorge.gomez.garcia@upm.es, ignacio.godino@upm.es, cgcastellanosd@unal.edu.co
source code for Non uniform Embedding ...

Dear All

I am wondering if you have any repository of your code from your paper:
"Non uniform Embedding based on Relevance Analysis with reduced
computational complexity: Application to the detection of pathologies
from biosignal recordings"


I want to understand more about the implementation of your algorithms
and the replication of your results.

Regards


# RAW Comments on Wednesday 17 January 2018


The authors review seven approaches to compute the delays  for the
nonuniform time-delay embedding
(Minimum Description Length \cite{judd1998}, False Nearest Neighbours,
feed-forward neural network, statistic methods, geometrical criterion,
evolutionary algorithms and objective function) in order to conclude that
none of the previous methods offer a method to find the best delay values
and these are generally computational expensive.


Considering the premise that biological signals have high nonlinearity, complexity, and non-stationarity,
\cite{gomezgarcia2014} et al. perform experiments to test different approaches to reconstruct dinamical 
beheaviors of biological signals.
Particularly, they focused on the differences that uniform and non-uniform time delay embedding techniques
provide the best classification rate for pattern recognition using a k-nn algorithm.
One interesting result is the comparison of the Uniform 1 method whihc is the traditional approach
computing minimum dimension with False Nearest Neighborhood and minimum delay with Average Mutual Information.
The seatback (problem) with Uniform 1 method is when the signal have multiple periodicties for which 
different values of $\tau$ can be considered, for instance, for high frequencies a short time delay 
might be optimal for the reconstruction whereas for low frequency signals a long delay proper to 
reconstruct the signal. 

Uniform 2 method takes advantage of finding an embedding window instead of finding the embedding 
parameteres separately. In general, Uniform 2 method computes m with FNN algortighm and 
$\tau$ is computed as $\tau= d_w / (m-1)$, where $d_w$ is given by 
the minimisation of the 
Minimum Description Lenght function by estimating the model
prediction error for increasing values of the embedding window \cite{small2004}.
With regard to the classification, Uniform 2 method offers better performance for the three signals using 
different dynamic invariants.
In terms of computational performance, Uniform 1 method is more than Uniform 2.

The Non Uniform 1 method is based on the MDL procedure to compute the time delay vector, however 
Non Uniform 1 method is not optimal as it does not consider the whole set of possible relationships 
among the candidate delay elements which is a mere successive inclusion of delay elements.
With that in mind, the Non Uniform 2 method is based on an irrelevance and redudancy analysis method
which is performed with an Unsupervised Minimal Redudancy/Maximal Relevance \cite{xu2010}.

The methodology is based on (1) preprocessing: normalisation of the amplitude [-1,1].
(2) State Space Reconstruction: Uniform 1, Uniform 2, Non Uniform 1 and Non Uniform 2 methods
(3) Characterization: Correlation Dimension, the Largest Lyapunov Exponent and Recurrence Period Density Entropy.
(4) Classification: k-nn classifier with k ranging from 3 to 11.

Besides that, \cite{gomezgarcia2014} et al. test its approach with three different datasets
(Kay-Elemetrics database, Heart murmurs database and Epilepsy database)
 which provide nonstationary signals and hight nonlinearity and complexity.
With that, four experiemts were performed of which 
Experiemtns III and IV were with the epilepsy dataset which is characterised with the 
high non-stationarity of the registers and the best results for classification were optanined.
Also the classification results present a subtle improvement for Experiment II 
with Heart Murmurs datasets, the non-stationarity is also present in this dataset.

It is highlighted that performance of NonUniform 2 method over NonUniform 1 method and uniform 1 and 2
methods is better for pattern recognition tasks using k-nn classifier, specially for automatic pathology 
detection tasks. Such conclusion are made with after experimenting with three different datasets that 
provide signals that are hight nonlinear and are non-stationary.

Althought the adtantage of the Non Uniform 2 method is computational inexpensive compare 
ot the other methods, it is not optimal because of its dependace to the a priori embedding dimension,
which, if it choosen wrongly, might introduce redundancy in the reconstruction and therefore
effect the quality of the reconstructe state space.



 










