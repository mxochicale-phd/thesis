## 16 Google Scholar Citations by 23 January 2018
https://scholar.google.co.uk/scholar?um=1&ie=UTF-8&lr&cites=4455608238957255290
FILE: https://scholar.google.co.uk/scholar?cluster=4455608238957255290&hl=en&as_sdt=0,5&sciodt=0,5
FILE: https://www.researchgate.net/profile/Charles_Webber/publication/266313858_Webber_CL_Jr_Marwan_N_Editors_2015_Recurrence_Quantification_Analysis_Theory_and_Best_Practices_Springer_series_Understanding_Complex_Systems_Springer_International_Publishing_Cham_Switzerland_httplin/links/55b9fe7308ae9289a090ea1a/Webber-CL-Jr-Marwan-N-Editors-2015-Recurrence-Quantification-Analysis-Theory-and-Best-Practices-Springer-series-Understanding-Complex-Systems-Springer-International-Publishing-Cham-Switzerland-h.pdf
 

# BibTex-File
```
@incollection{marwan2015,
  author    = {Norbert Marwan and Charles L. Webber}, 
  title={Mathematical and Computational Foundations of Recurrence Quantifications}, 
  editor = {Charles L. Webber and Norbert Marwan}, 
  booktitle = {Recurrence Quantification Analysis: Theory and Best Practices},
  publisher = {Springer, Cham},
  edition   = 1,
  isbn      = {978-3-319-07154-1},
  year= 2015, 
  pages       = "3-43",
  chapter     = 1
}
```
# Mathematical and Computational Foundations of Recurrence Quantifications

## Author(s) / Organisation

Norbert Marwan at Potsdam Institute for Climate Impact Research.
http://www.agnld.uni-potsdam.de/~marwan/intro.php
https://www.pik-potsdam.de/members/marwan/dr-norbert-marwan

Charles L Webber at Loyola University Chicago, Stritch School of Medicine - Health Sciences Division. 
http://cwebber.sites.luc.edu/


## Abstract
Real-world systems possess deterministic trajectories, phase singularities and noise. 
Dynamic trajectories have been studied in temporal and frequency domains, but these are 
linear approaches. Basic to the field of nonlinear dynamics is the representation of 
trajectories in phase space. A variety of nonlinear tools such as the Lyapunov exponent, 
Kolmogorov-Sinai entropy, correlation dimension, etc. have successfully characterized 
trajectories in phase space, provided the systems studied were stationary in time. 
Ubiquitous in nature, however, are systems that are nonlinear and nonstationary, 
existing in noisy environments all of which are assumption breaking to otherwise 
powerful linear tools. What has been unfolding over the last quarter of a century, 
however, is the timely discovery and practical demonstration that the recurrences 
of system trajectories in phase space can provide important clues to the system 
designs from which they derive. In this chapter we will introduce the basics of 
recurrence plots (RP) and their quantification analysis (RQA). We will begin by 
summarizing the concept of phase space reconstructions. Then we will provide the 
mathematical underpinnings of recurrence plots followed by the details of recurrence 
quantifications. Finally, we will discuss computational approaches that have been 
implemented to make recurrence strategies feasible and useful. As computers become 
faster and computer languages advance, younger generations of researchers will be 
stimulated and encouraged to capture nonlinear recurrence patterns and quantification 
in even better formats. This particular branch of nonlinear dynamics remains wide open 
for the definition of new recurrence variables and new applications untouched to date.


### Article link
https://www.researchgate.net/publication/265003619_Mathematical_and_Computational_Foundations_of_Recurrence_Quantifications [accessed Jan 06 2018].


### Posting date (2015)

## Overview
1.1 Phase Space Trajectories

1.2 Recurrence Plots
1.2.1. Definition of Recurrence Plots
1.2.2. Structure in Recurrence Plots

1.3 Recurrence Quantifications
1.3.1 Classical Recurrence Quantification Analysis
1.3.2 Extended Recurrence Quantification Analysis
1.3.3 Recurrence Time Based Measures
1.3.4 Complex Network Based Quantifications
1.3.5 Advance Quantifications
1.3.6 Windowing Techniques 
1.3.7 Remark on Significance
1.3.8 Example: Rossler System with Regime Transitions

1.4 Bivariate Extensions of Recurrent Analysis
1.4.1 Cross Recurrence Plots
1.4.2 Join Recurrence Plot
1.4.3 Comparison between CRP and JRP

1.5 Computational Foundations of Recurrence Quantification Analysis
1.5.1 Brief Historical Background
1.5.2 Computational Strategies
1.5.3 Example Program Runs
1.5.3.1 Programs RQD, KRQD and JRQD
1.5.3.2 Programs RQS, KRQS and JRQS
1.5.3.2 Programs RQE, KRQE and JRQE
1.5.4 Advanced Topics


## Novelty / difference

## Method 

## Results

## Further References
* http://www.recurrence-plot.tk/

# RAW REVIEW on 29JANUARY2018-2FEBRUARY2018

* Introduction

Marwan et al. \cite{marwan2015} pointed out that additionally to the state space 
reconstruction methodologies and other nonlinear tools such as Lyapunov exponent, 
Kolmogorov-Sinai entropy, the recurrences of the trajectories in the phase space 
can provide important clues to characterise natural process that present, for
instance, periodicities (as Milankovitch cycles) or irregular cycles 
(as El Nin\~o Southern Oscillation).

Recurrences in the dynamics of a system can be visualised using recurrence plots (RP)
which have been introduced by Eckmann et al. 1987 \cite{ekcman1987}.

The intention of Eckmann et al. \cite{eckmann1987}  was to propose a tool,
called recurrence plot, that provides insights into high-dimensional dynamical 
systems where trajectories are very difficul to visualise.
As explained by Marwan et al. \cite{marwan2015} "RP helps us to investigate 
the $m-$ dimensional phase space trajectory through a two-dimensional representation
of its recurrences".
 
Let $X(i)$ be the $i-$th point in the orbit describing a dynamical system in a 
$m-$ dimensional space, for $i=1,\dots,N$. The recurrence plot, therefore, is 
a two-dimensional $N \times N$ square matrix, $R$, where a dot is placed at $(i,j)$
whenever $X(i)$ is sufficient close to $X(j)$: 
\begin{equation}
R^{m,\epsilon_i}_{i,j} = \Theta ( \epsilon_i - || X(i) - X(j) ||, \quad X(i) \in \mathbb{R}^m, \quad i,j=1,\dots,N
\end{equation}
where $N$ is the number of considered states $X(i)$, $\epsilon$ is a threshold 
distance, $|| \cdotp ||$ a norm, and $\Theta(\cdotp)$ the Heaviside function \cite{eckmann1987,marwan2015}.
RP has a line of identity (LOI) which is a black main diagonal line because of $ R_{i,j}=1 (i,j=1,\dots,N)$. 


From the original methodology \cite{marwan2015}, 
the creating of recurrence plot is based on time series $ \{ u_i \}$ for which, 
we first  compute the state space reconstruction, $X(i)$, with an embedding dimension $d$
$X(i)=( u(i, u_{i-\tau}, \dots, u_{i -(d-1)\tau })$. Then, one chooses $r(i)$ 
such that the ball of radios $r(i)$ centred at $x(i)$ in $\mathbb{R}^d$ contains 
a reasonable number of other points $X(j)$ of the orbit. Finally, one plots 
a dot at each point $(i,j)$ for which $X(j)$ is in the ball of radius $r(i)$
centred at $X(i)$. 
Most recent methods include the fixed amount of nearest neighbours where a fixed 
radius $\epsilon_i, \forall i$ \cite{marwan2015}.


Marwan et al. reviewed RP algorithm where different criterios for neightbours can be used
as well as norms and recurrence thresohold parameter $\epsilon_i$ of which 
many of them is currently under developemnt as they are remained as open questions,
specially the thereshold $\epsilon_i$ which can be selected according to a certain 
pertencetage of the signal, the amount of noise or using a factor based on the standard
deviation of the obesrvational noise. [first paragraph of page 9].


* Structures of Recurrence Plots

Recurrence plots can be visually characterised by the pattern formations which
are either large-scale typology or small-scale texture.
For the case of large-scale topology as 
homogeneous (), 
periodic (), 
drift (), and
disrupted ()
\cite{eckmann1987, marwan2015}.
%TODO: Replicate Figure 1.2 comment the differences in the figure description and made references in this part.
With regard to small-scale texture, these can include 
single, isolated recurrent points (),
dots forming diagolan lines (),
dots forming vertical/horizontal lines (),
or dots clustering to inscribe rectangular regions ().

%What is interesting is the small-scale texture whre short lines parallel to the diagonal 
%of the recurrence plots of which lenght is related to the inverse of the 
%Largest lyapunov exponent, also it can be noticed a checkboard texture where, 
%for the case of Lorenz system, $X(i)$ moves on a spiral, sometimes around one,
%sometimes around the other of the two simetric points of the system


Althought, each of the previous characteristics in the RP offer a good idea of the
characteristics of the dynamical system, these might be misinterpreted and 
conclusions might tend to be subjectibve as these require the interpretation 
of an experiences researcher.
Because of that, recurrence quantification methodologies
offer an objective to meausing such visual characteristics in the patterns of the RP.


* Recurrence Quantifications


(1st variable) Percentage of recurrance (REC) or recurrance rate (RR)
\begin{equation}
RR(\epsilon,N)= \frac{1}{N^2 - N} \sum^{N}_{i \neq j = 1} R^{m,\epsilon}_{i,j},
\end{equation}
enumarates the black dots in the RP excluding the line of identity.
RR is a measure of the relative density of recurrence points in the sparse matrix
and it is related to the definition of the correlation sum \cite{marwan2015}

%REC is computed as follow with the nonlinearTseries package \cite{nonlinearTseries} 
%  hist = getHistograms(neighs, ntakens, lmin, vmin)
%  # calculate the number of recurrence points from the recurrence rate. The
%  # recurrence rate counts the number of points at every distance in a concrete
%  # side of the main diagonal.
%  # Thus, sum all points for all distances, multiply by 2 (count both sides) and
%  # add the maindiagonal
%  numberRecurrencePoints = sum(hist$recurrenceHist) + ntakens
%  # calculate the recurrence rate dividing the number of recurrent points at a
%  # given distance by all points that could be at that distance
%  recurrence_rate_vector = hist$recurrenceHist[1:(ntakens - 1)] / ((ntakens - 1):1)
%  # percentage of recurrent points
%  REC = (numberRecurrencePoints) / ntakens ^ 2



(2nd variable) The percent determnism (DET) is defined as the fraction of recurrence points
that form diagonal lines
\begin{equation}
DET=\frac{\sum^{N}_{l=d_{min}} l H_D{l} }{\sum^{N}_{i,j=1} R_{i,j} },
\end{equation}
where $H_D{l}$ is the histogram of the lengths of the diagonal structures in the RP.

DET can be interpreted as the predictibility of the system 
for periodic signals which have longer diagonal lines than chaotic signals which have short lines
or stochastic signals where diagonal lines are absent, we refer the reader to \cite{marwan2015}
for detailed explanations.

%percent determinism (DET) is computed as follow with the nonlinearTseries package \cite{nonlinearTseries}  
% calculateDiagonalParameters = function(ntakens, numberRecurrencePoints,
%                                       lmin = 2, lDiagonalHistogram,
%                                       recurrence_rate_vector, maxDistanceMD) {
%  #begin parameter computations
%  num = sum((lmin:ntakens) * lDiagonalHistogram[lmin:ntakens])
%  DET = num / numberRecurrencePoints



(X variable) RATIO is defined as the ratio of DET to RR and it is calculated from 
the frequency distributions of the lenghts of the diaginal lines,
RATIO is useful to discover dynamic transitions \cite{marwan2015}.

%  diagP = calculateDiagonalParameters(
%    ntakens, numberRecurrencePoints, lmin, hist$diagonalHist,
%    recurrence_rate_vector, maxDistanceMD
%  )
% calculateDiagonalParameters = function(ntakens, numberRecurrencePoints,
%                                       lmin = 2, lDiagonalHistogram,
%                                       recurrence_rate_vector, maxDistanceMD) {
%  #begin parameter computations
%  num = sum((lmin:ntakens) * lDiagonalHistogram[lmin:ntakens])
%  DET = num / numberRecurrencePoints
% 
%
%    RATIO = diagP$DET / REC
%



(3er variable) $D_{max}$ is the maximal line lenght in the diagonal direction
\begin{equation}
D_{max}= \operatorname*{arg,\max}_{l} H_{D}(l)
\end{equation}
$D_{max}$ is an indicator for the divergence of the trajectory segments,
for instance, the smaller $D_{max}$ the more divergent are the trajectories \cite{marwan2015}

%#'  \item \emph{Lmax}: Length of the longest diagonal line.
%calculateDiagonalParameters = function(ntakens, numberRecurrencePoints,
%                                       lmin = 2, lDiagonalHistogram,
%                                       recurrence_rate_vector, maxDistanceMD) {
%  #pick the penultimate
%  Lmax = tail(which(lDiagonalHistogram > 0), 2)[1]
%  if (is.na(Lmax) || Lmax == ntakens) {
%    Lmax = 0
%  }
  


(X variable) The average diagonal line lenght
\begin{equation}  
\langle D \rangle = \frac{ \sum^{N}_{l=d_{min}} l H_D(l) }{ \sum^{N}_{l=d_{min}}  H_D(l)}
\end{equation}
is the avarage tieme of two segments of the trajectory that are close to each other
and it can be interpreted as the mean prediction time \cite{marwan2015}.



%#'  \item \emph{Lmean}: Mean length of the diagonal lines. The main diagonal is
%#'   not taken into account.
%
% calculateDiagonalParameters = function(ntakens, numberRecurrencePoints,
%                                        lmin = 2, lDiagonalHistogram,
%                                       recurrence_rate_vector, maxDistanceMD) {
%  DET = num / numberRecurrencePoints
%  Lmean = num / sum(lDiagonalHistogram[lmin:ntakens])
%  aux.index = lmin:(ntakens - 1)
%  LmeanWithoutMain = (
%    sum((aux.index) * lDiagonalHistogram[aux.index]) /
%      sum(lDiagonalHistogram[aux.index])
%  )
  



(4th variable) The Shannon entropy of the frequency distribution
of the diagonal line lengths (ENT) defined as
\begin{equation}
ENT= - \sum^{N}_{l=d_{min}} p(l) ln p(l) \quad with \quad p(l)=\frac{ H_D(l) }{ \sum^{N}_{ l=d_{min} } H_D(l) }.
\end{equation}
ENT is used to show the complexity of the deterministic structure in the system.
For instance, "the higher the ENT the more complex the dynamics" on the contrary
for rather small values of ENT the complexity of the system is low and that comes
from "for uncorrelated noise or oscillations signals" \cite{marwan2015}.

%#'  \item \emph{ENTR}: Shannon entropy of the diagonal line lengths distribution

%calculateDiagonalParameters = function(ntakens, numberRecurrencePoints,
%                                       lmin = 2, lDiagonalHistogram,
%                                       recurrence_rate_vector, maxDistanceMD) {
%
%  pl = lDiagonalHistogram / sum(lDiagonalHistogram)
%  diff_0 = which(pl > 0)
%  ENTR = -sum(pl[diff_0] * log(pl[diff_0]))

 

(5th variable) Trend (TND) "is a linear regression coefficient over the
recurrence point density of the diagonals parallel to the LOI" and is defined as
\begin{equation}
TND= \frac{ \sum^{\~N}_{i=1}  (1- \~N /2 )( RR_i - \langle RR_i  \rangle )  }{  \sum^{\~N}_{i=1}  (i-\~N/2)^2  }.
\end{equation}
Trend value "gives information about the stationarity versus nonstationarity in the process".
TNT values near to zero represent quasi-stationary dynamics and TNT values far from zero
represent nonstationary dynamics wich reveals "drift in the dynamics" \cite{marwan2015}.



%#'  \item \emph{TREND}: Trend of the number of recurrent points depending on the
%#'   distance to the main diagonal
%calculateDiagonalParameters = function(ntakens, numberRecurrencePoints,
%                                       lmin = 2, lDiagonalHistogram,
%                                       recurrence_rate_vector, maxDistanceMD) {
%  
%  # use only recurrent points with a distance to the main diagonal < maxDistance
%  recurrence_rate_vector = recurrence_rate_vector[1:maxDistanceMD]
%  mrrv = mean(recurrence_rate_vector)
%  #auxiliar vector for the linear regresion: It is related to the general regression
%  #formula xi-mean(x)
%  auxiliarVector = (1:maxDistanceMD - (maxDistanceMD + 1) / 2)
%  auxiliarVector2 = auxiliarVector * auxiliarVector
%  # divide by two because we are having into account just one side of the main diag
%  num = sum(auxiliarVector * ((recurrence_rate_vector - mrrv) / 2))
%  den = sum(auxiliarVector2)
%  TREND = num / den




The previous variables for recurrence plots are based on lenght, number and distrubution
of diaginla lines, however another patterns in the horizontal and vertical lines can 
also be noticed for which the following metrics are used.

(6th variable) Laminarity (LAM) computes the pertentage of recurrence ppint in vertical lines
which is anagaloogus to DET varaible which computes the percentage of diagonal lines
in the RP, refer to \cite{marwan2015} for algorithm implementation.

%#'  \item \emph{LAM}: Percentage of recurrent points that form vertical lines.
%calculateVerticalParameters = function(ntakens, numberRecurrencePoints,
%                                       vmin = 2, verticalLinesHistogram) {
%  #begin parameter computations
%  num = sum((vmin:ntakens) * verticalLinesHistogram[vmin:ntakens])
%  LAM = num / numberRecurrencePoints
 

(7th variable) Consequently, trapping time (TT) variable which computes the 
avarage lenght of vertical lines. "TT contains information about the amount
and lenght of vertical structures in the RP" which represents 
"the mean time the system will" stay "at a specific time"

(8th variable) The maximal lenght of the vertical structures Vmax computes 
"longest vertical line in the RP" which is analogous to Dmax. According
to Marwan et al. \cite{marwan2015} the dynamical interpretation of this 
variable is not enterily clear but only as a relationship with 
"singular states in wich the system is stuck in a holding pattern
inscribing rectangles in the RP"


%#'  \item \emph{Vmax}: Longest vertical line.
%#'  \item \emph{Vmean}: Average length of the vertical lines. This parameter is
%#'  also referred to as the Trapping time.
%
%calculateVerticalParameters = function(ntakens, numberRecurrencePoints,
%                                       vmin = 2, verticalLinesHistogram) {
%  #begin parameter computations
%  num = sum((vmin:ntakens) * verticalLinesHistogram[vmin:ntakens])
%  Vmean = num / sum(verticalLinesHistogram[vmin:ntakens])
%  if (is.nan(Vmean)) {
%    Vmean = 0
%  }
%  #pick the penultimate
%  histogramWithoutZeros = which(verticalLinesHistogram > 0)
%  if (length(histogramWithoutZeros) > 0) {
%    Vmax = tail(histogramWithoutZeros, 1)
%  } else {
%    Vmax = 0
%  }
 

Marwan et al. \cite{marwan2015} pointed out the the last variable are useufl
for undestandint the chaos-chaos transcitions.

 
we refer the reader 
to \cite{marwan2015} for more details about the equations and 
for the computation to nonlinearTseries package \cite{nonlinearTseries}.



Marwan et al. \cite{marwan2015} present further research regarsing advanced
quantification of the RP based on complex networks statics, calculation
of dynamic invariants with the diaginal lines in the RR, windowing technques or
the study of bivariate recurrence analysis for correlations, couplings,
coupling directions or syncronisation between dynamical systems






