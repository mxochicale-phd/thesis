

@article{krakovska2015,
title = "Use of False Nearest Neighbours for Selecting Variables and Embedding Parameters for State Space Reconstruction",
journal = "Journal of Complex Systems",
volume = "2015",
number = "932750",
year = "2015",
author = "Anna Krakovska and Kristina Mezeiova and Hana Budacova",
}
doi = "http://dx.doi.org/10.1155/2015/932750",
url = "10.1155/2015/932750",




Use of False Nearest Neighbours for Selecting Variables and Embedding Parameters for State Space Reconstruction
Anna Krakovská, Kristína Mezeiová, and Hana Budáčová
https://www.hindawi.com/archive/2015/932750/


Krakovská, Anna, RNDr. CSc.
http://www.um.sav.sk/sk/oddelenie-03/anna-krakovska.html
E-mail: 	krakovska@savba.sk


# CONTACT

I contacted Anna on 9 August 2017
to ask about the implementation code for the proposal of this
algorithm but she has not replied yet.



```
from:	Miguel P. Xochicale <perez.xochicale@gmail.com>
to:	krakovska@savba.sk
date:	9 August 2017 at 22:17
subject:	code for the False First Nearest Neighbors
mailed-by:	gmail.com

Dear Anna*

I am wondering if the source code to compute the False First Nearest
Neighbors in [1] is available? I want to replicate some of your
results as well as doing further experiments.


[1] https://www.hindawi.com/archive/2015/932750/
*http://www.um.sav.sk/en/department-03/anna-krakovska.html

Regards
```



```
from:	Miguel P. Xochicale <perez.xochicale@gmail.com>
to:	krakovska@savba.sk
date:	12 December 2017 at 12:14
subject: False First Nearest Neighbour

Dear Anna,
I am reading your work of the method of "False First Nearest Neighbour [1]".
I understand that you might be very busy to reply my email, but I am  wondering
if you can share your code to do further with your results and provide an
appropriate review for a manuscript that I am preparing on
the use of time-delay embedding methodologies.


[1] https://www.hindawi.com/archive/2015/932750/
```


# OBSERVATIONS
## Tuesday 12 December 2017
Algorithm of False First Nearest Neighbour

1. Take the observable of the system, and for combination of
time delays and embedding dimensions, form time-delay reconstructions.

2. Both in m-dimensional and (m+1)-dimensional reconstruction,
identify the closest point
(the first neighbour in Eucliden sense)
to each point of the reconstructed trajectory.

3. Quantify the rank-based measure of the FFNN method as a percentage
of cases when the nearest neighbour to a point in m-dimensional space
ceases to be the nearest neighbour of the same point in the state
space of one higher dimension.

4. Visualise the results, for example, as a color-code map to detect
the best combinations of parameters for the state space reconstruction.
