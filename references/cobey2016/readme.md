12
https://scholar.google.com/scholar?um=1&ie=UTF-8&lr&cites=16643493755138346104

Tue  8 Jan 05:48:20 GMT 2019


```
@article{10.1371/journal.pone.0169050,
    author = {Cobey, Sarah AND Baskerville, Edward B.},
    journal = {PLOS ONE},
    publisher = {Public Library of Science},
    title = {Limits to Causal Inference with State-Space Reconstruction for Infectious Disease},
    year = {2016},
    month = {12},
    volume = {11},
    url = {https://doi.org/10.1371/journal.pone.0169050},
    pages = {1-22},
    number = {12},
    doi = {10.1371/journal.pone.0169050}
}
```




Authors explains the use of the takens theorme
for a model of convergent cross-mapping

In the paper, the authors explain the use of the takens theorem as
a basis for casual inference  
which

if Y drives(causes) X, information about X is embedeed in the  time series of Y.
Such statement is important to explore the relationships
between the time-delay embeddigns  of the time-series of X and Y.
which can be
that X drives Y  or Y drives X, both or netiher. which are the basic tools
for analyse causation in  nonlinear dynamic systems
READ MORE ABOUT CAUSATION WITH NONLINEAR DYMANICS IN:


17. Sugihara G, May R, Ye H, h Hsieh C, Deyle E, Fogarty M, et al. Detecting Causality in Complex Ecosys-
tems. Science. 2012; 338(6106):496–500. doi: 10.1126/science.1227079 PMID: 22997134
18. Ye H, Deyle ER, Gilarranz LJ, Sugihara G. Distinguishing time-delayed causal interactions using con-
vergent cross mapping. Nature Sci Rep. 2015; 5:14750. doi: 10.1038/srep14750
19. Clark AT, Ye H, Isbell F, Deyle ER, Cowles J, Tilman GD, et al. Spatial convergent cross mapping to
detect causal relationships from short time series. Ecology. 2015; 96(5):1174–1181. doi: 10.1890/14-
1479.1 PMID: 26236832
20. Deyle ER, Maher MC, Hernandez RD, Basu S, Sugihara G. Global environmental drivers of influenza.
Proceedings o



Their work also Methods to select the delay and embedding dimmension
for takens theorem.



three methods use the unifrom embeddings:

1. Univariate prediction method:
2. Maximum cross-correlation method:
3. Random projection method



and one use nonuniform embedding which is a series  of different
 delays  

 4. Nonuniform method:

 



# Code
Code implementing the state-space reconstruction methods is publicly
available at https://github.com/cobeylab/pyembedding. The complete code for
the analysis and figures is publicly available at https://github.com/cobeylab/causality_manuscript; individual analyses include
references to the Git commit version identifier in the ‘pyembedding’ repository.

The simulated time series on which the analyses were performed are available
from the authors on request.
