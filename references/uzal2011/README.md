@article{PhysRevE.84.016223,
  title = {Optimal reconstruction of dynamical systems: A noise amplification approach},
  author = {Uzal, L. C. and Grinblat, G. L. and Verdes, P. F.},
  journal = {Phys. Rev. E},
  volume = {84},
  issue = {1},
  pages = {016223},
  numpages = {17},
  year = {2011},
  month = {Jul},
  publisher = {American Physical Society},
  doi = {10.1103/PhysRevE.84.016223},
  url = {https://link.aps.org/doi/10.1103/PhysRevE.84.016223}
}






E. Nonuniform delay coordinate reconstruction (page 14)
Pecora et al. introduces the concept of Nonuniform DC






uzal@cifasis-conicet.gov.ar; grinblat@cifasis-conicet.gov.ar; verdes@cifasis-conicet.gov.ar
uzal@cifasis-conicet.gov.ar


Dear Lucas et al.

In your paper titled "Optimal reconstruction of dynamical systems: A noise amplification approach",
your provide a reference to download the C code for the computation of the dinamic invartiants.
Unfortunatelly, the link [http://www.cifasis-conicet.gov.ar/uzal/archivos/optimal_embedding.tar.gz] is not available in the server. I am therefore interested in having a copy of your souce code to
make some replications of your results with the aim of getting a more intuitive understanding of
the time-delay embedding theorem.



# nonuniform Delay Coordinate
nDC has been extensively explored in the literature in recent years [12,30–42,46].

[12]
small2004
Optimal embedding parameters: a modelling paradigm
http://www.sciencedirect.com/science/article/pii/S0167278904001186?via%3Dihub

[30]
pi2008
Finding the Embedding Dimension and Variable Dependencies in Time Series
http://www.mitpressjournals.org/doi/pdfplus/10.1162/neco.1994.6.3.509

[31]
judd1998
Embedding as a modeling problem
http://www.sciencedirect.com/science/article/pii/S016727899800089X?via%3Dihub
"For more complex nonlinear dynamics we introduce variable embedding,
where, in a suitable sense, the embedding changes with the state of
the system."

[32]
tsui2002
The Construction of Smooth Models using Irregular Embeddings Determined by a Gamma Test Analysis
https://link.springer.com/article/10.1007%2Fs005210200004
"we conclude that the Gamma test is an effective tool in the determination
of irregular time series embeddings"

[33]
hirata2006
Reconstructing state spaces from multivariate data using variable delays
https://journals.aps.org/pre/abstract/10.1103/PhysRevE.74.026202
"A nonuniform embedding is a state space reconstruction which is more flexible
than the common delay coordinates with fixed delays since it contains variable
delays"


[34]
simon2007
High-dimensional delay selection for regression models with mutual information
and distance-to-diagonal criteria
http://www.sciencedirect.com/science/article/pii/S0925231206004784?via%3Dihub
"Delay selection for time series phase space reconstruction may be performed
using a mutual information (MI) criterion. However, the delay selection is in
that case limited to the estimation of a single delay using MI between two
variables only. A high-dimensional estimator of the MI may be used to select
more than one delay between more than two variables"

[35]
manabe2007
A novel approach for estimation of optimal embedding parameters of nonlinear
time series by structural learning of neural network
http://www.sciencedirect.com/science/article/pii/S0925231206003031?via%3Dihub
"The proposed scheme of optimal estimation of embedding parameters can be
viewed as a global non-uniform embedding. It has been found that the proposed
method is more efficient for estimating embedding parameters for reconstruction
of the attractor in the phase space than conventional uniform embedding methods."


[36]
tikka2008
Sequential input selection algorithm for long-term prediction of time series
http://www.sciencedirect.com/science/article/pii/S0925231208002233?via%3Dihub


[37]
ragulskis2009
Non-uniform attractor embedding for time series forecasting by fuzzy inference systems
http://www.sciencedirect.com/science/article/pii/S0925231208004980?via%3Dihub
"Simple deterministic method for the determination of non-uniform time lags
comprises the pre-processing stage of the time series forecasting algorithm
which is implemented in the form of a fuzzy inference system."


[38]
lukoseviciute2010
Evolutionary algorithms for the selection of time lags for time series
forecasting by fuzzy inference systems
http://www.sciencedirect.com/science/article/pii/S0925231210001554?via%3Dihub#fig1
" The weighted one-point crossover rule enables an effective identification of
near-optimal sets of non-uniform time lags which are better than the globally
optimal set of uniform time lags. Thus the reconstructed information on the
properties of the underlying dynamical system is directly elaborated in the
fuzzy prediction system."

[39]
holstein2009
Optimal Markov approximations and generalized embeddings
https://journals.aps.org/pre/abstract/10.1103/PhysRevE.79.056202

[40]
pecoras2007
http://aip.scitation.org/doi/10.1063/1.2430294
"We propose an alternative approach that views the problem of choosing all
embedding parameters as being one and the same problem addressable using a single
statistical test formulated directly from the reconstruction theorems. This allows
for varying time delays appropriate to the data and simultaneously helps decide
on embedding dimension."

[41]
garcia2005a
Nearest neighbor embedding with different time delays
https://journals.aps.org/pre/abstract/10.1103/PhysRevE.71.037204
"The possibility of using different time delays for consecutive dimensions is considered.""

[42]
garcia2005b
Multivariate phase space reconstruction by nearest neighbor embedding with different time delays
https://journals.aps.org/pre/abstract/10.1103/PhysRevE.72.027205
"A recently proposed nearest neighbor based selection of time delays for phase
space reconstruction is extended to multivariate time series, with an iterative
selection of variables and time delays."

[46]
huke2007
Embedding theorems for non-uniformly sampled dynamical systems
http://iopscience.iop.org/article/10.1088/0951-7715/20/9/011/meta
"We point out that non-uniform sampling might lead to better reconstructions than
uniform sampling, for certain kinds of time series."
