6 citations
https://scholar.google.co.uk/scholar?cites=16254877525990718724
Wed 25 Jul 17:49:43 BST 2018



@INPROCEEDINGS{6926253, 


@INPROCEEDINGS{guneysu2014, 
author={A. Guneysu and R. D. Siyli and A. A. Salah}, 
booktitle={The 23rd IEEE International Symposium on Robot and Human Interactive Communication}, 
title={Auto-evaluation of motion imitation in a child-robot imitation game for upper arm rehabilitation}, 
year={2014}, 
volume={}, 
number={}, 
pages={199-204}, 
doi={10.1109/ROMAN.2014.6926253}, 
ISSN={1944-9445}, 
month={Aug},
}



\cite{guneysu2014} studied atumatic evaluation of upper body actions
with children using Range of Motion(RoM) and Dynamic Time Warping(DTW).

In the experiment eight healthy children mimiced NAO, an humanoid robot,
and a kinect which collected skeleton data with join angles.
Evaluation of five threapish using Intracals correlation coefficient.


\cite{guneysu2014} used a moving average filter with a window size of 
50 frames to smooth the data and eliminate unnesary fluctations 
of local minimas and maximas.
Then peak detection of smoothend and unsmoothed data were peformed to find 
aligment of motion directions.

Following the work of Ranatunga et al. which use DTW for the evaluation 
of similarlty of movements  performance between robot and person,
\cite{guneysu2014} impleted DTW with a window size of three frames.
\cite{muller} dynamic time warping

\cite{guneysu2014} evaluated physiothreapist's evalition suing intraclass
correlation coefficient based on pooled variance within subjects and 
variane of the trait between subjebts, however the original formala
prposed in [http://www.john-uebersax.com/stat/icc.htm]
were modified as true values were not known. 

\cite{guneysu2014} reported physiopthreapist's evaluation
using ICC which differs based on levels of experience as 
two of them were interns. Also the motions complexity is diffrente
for which physioterapist compensate that misunderstanding
of the children while the metrics simply performed the computation
with the availble data from the angles.
The work of \cite{guneysu2014} do not considered latency of motions,  velococity or simetry of motion.
Also, it is mentioned that considering latency of motion can be used
as an indicator of attention deficit, boredoom, or lack of perception.


added: Wed 25 Jul 18:57:36 BST 2018


