@INPROCEEDINGS{emrani2017,
author={S. Emrani and H. Krim},
booktitle={2017 IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)},
title={A model-free causality measure based on multi-variate delay embedding},
year={2017},
pages={4163-4167},
keywords={causality;correlation methods;estimation theory;fractals;signal processing;time series;time-domain analysis;causal interaction extraction;causal interaction measure;correlation dimension estimation;fractal dimension;fractal-based method;generated point clouds;geometric model-free causality measure;multiple time series;multivariate delay embedding;nonlinear causal interaction detection;point cloud construction;time domain signals;Correlation;Delays;Estimation;Fractals;Three-dimensional displays;Time series analysis;Causal interaction;multivariate delay embedding;time series analysis},
doi={10.1109/ICASSP.2017.7952940},
month={March},}


http://ieeexplore.ieee.org/abstract/document/7952940/


COMMENTS on the 21 August 2017

What caught my eye from this paper is the use of the method for
Multi-variate Delay Embedding for which the notation is well-written and the
paper was submitted to
the 2017 42th IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP)
where I believe Martin Russell is familiar.



multi-variate delay embedding is used to tackle the problems
that methods for causal interaction create.

There is typo and misspelling with modelling in the introduction section:
"Most of these measures are rooted in linear regression *modeling*
*and* cannot identify the nonlinear interactions between signals.

NEGATIVES:
Being a paper from 2017, there is no deep investigation regarding the
body of literature with regard to the applications of the time-delay embedding
Abarnel et al. 1993 and Kantz et al. 1997
and the authors refer to their own investigation
Emrani et al. 2014 @ IEEE Signal Processing Letters
Emrani et al. 2015 @ EUSIPCO


Section 2.1 describe well the multivariate delay embedding
however, N meaning is missing which in the context of speech is known as sample length

X_n representation mathematical is the same for  univariate time-delay embedding
as for the multivariate time-delay embedding.
Equation 1 can be improved by a slight modification of the presentation by using
a univariate time-delay embedding per row as

"x_{p,n},x_{p,n-\tau},...,x_{p,n-(m_p-1)\tau}"

where $m=(m_1,m_2,...,m_p) is the embedding dimension vector that determine the
number of dimensions in each of the univaritate time-delay embeddings.

the same for equation (2)
"x_{p,n},x_{p,n-\tau_p},...,x_{p,n-(m_p-1)\tau_p}"

where $\tau= \tau_1, \tau_2,..., \tau_p$ is the time delay embedding vector.

For the non-uniform multivariate notation where is mentioned by the authors that
"is the most general embedding technique" which might be misleading since there
is no evidence or reference to make such statement.

and is a bit hard to follow
since the number of delay determined by $m_i$ are defined by
 $l_{ij}$,$j=1,...m_i$ and $i=1,...,p$

because it is not consistence with the previous equation (1) and (2)
