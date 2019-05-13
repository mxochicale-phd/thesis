Corrections for the online version
---

* [ ] amend appends for further graphical results
using github code and data

Sun 12 May 21:52:28 BST 2019


* [ ] create appendix in thesis to explain 
	how can anyone clone and replicate
	the thesis
	Thu Apr 25 05:59:02 BST 2019



```
CHAPTER 1
\section{Open access PhD thesis}
In 1901 the University of Birmingham published the first PhD thesis, 
in July 2011 the first electronic thesis were uploaded to e-thesis 
\citep{ethesis-bham}, 
and then, to the best of my knowledge, in 2019 my PhD thesis is the 
first published open accessed PhD thesis with code and data.
Hence, a github repository has been created for this thesis 
where references to open access software tools and data are 
available for others to use and perhaps help 
them to advance this field \citep{xochicale2018}.
%See Appendix F for an explanation on how 
%the code and data can be accessed 
%and its replication.
```

added: Mon  6 May 11:26:17 BST 2019



* [ ] links for github repositories for figures and code


Mon 29 Apr 01:21:30 BST 2019






* [ ] change samples by time index in plots of chapter3



3.3
3.4
3.5
3.6
3.7 C to G

`$HOME/phd/phd-thesis/0_code_data/1_code/4_figs_ch3 `

	added: Sun 12 May 18:00:51 BST 2019



* [ ] polish `\subsection*{Surrogate data analysis}` in Chapter 7

	Tue  7 May 12:34:15 BST 2019





* [ ]	Tidy up use of formulas and symbolic 
	representations of methods of nonlinear analysis.
	
Mon  6 May 12:24:18 BST 2019









* [ ] plot time series for all participants with code

```
To visualise the time series of the previous activities, Figs 
\ref{fig:hii-sts} show time series using smoothed gyroscope of Y and Z 
for the sensor HS01 of participant 01.
See Appendix \ref{appendix:d:ts} for 
time series of all participants and activities. 
```

	added: Mon  6 May 16:30:51 BST 2019


* [ ] update slides of the presentation
	`$HOME/phd/phd-thesis/xtras/viva/slides/src`
	
	added: Mon 29 Apr 06:04:27 BST 2019





* [ ] NAO code for animations (check old computer)
	

* [ ] add NAO mechanics and dynamics capabilities in appendix

BASED on
```
@inproceedings{Gouaillier:2009:MDN:1703775.1703795,
 author = {Gouaillier, David and Hugel, Vincent and Blazevic, Pierre and Kilner, Chris and Monceaux, J{\'e}r\^{o}me and Lafourcade, Pascal and Marnier, Brice and Serre, Julien and Maisonnier, Bruno},
 title = {Mechatronic Design of NAO Humanoid},
 booktitle = {Proceedings of the 2009 IEEE International Conference on Robotics and Automation},
 ```

~/phd-thesis/references/gouaillier2009 













# sorted 


* [x] replace hwum2018 by xochicale2018

FROM
	the figure is available from \cite{hwum2018}.
TO
	R code to reproduce the figure is available in \cite{xochicale2018}.

added again: Sun 12 May 18:16:38 BST 2019


SORTED Mon 13 May 02:23:07 BST 2019



* [x] create figures with data for chapter6



cd $HOME/phd/phd-thesis/0_code_data/1_code/8_figs_ch6 

```
07_fig6.10-6.11/  

SORTED: Sun 12 May 19:29:42 BST 2019


08_fig6.12/  

SORTED:
Sun 12 May 20:14:16 BST 2019



09_fig6.13/  

SORTED:
Sun 12 May 20:39:51 BST 2019


10_fig6.14/

SORTED
Sun 12 May 20:55:42 BST 2019

```





added: Mon  6 May 14:12:42 BST 2019




* `07_fig6.10-6.11/`

```
cd $HOME/phd/phd-thesis/0_code_data/1_code/8_figs_ch6/07_fig6.10-6.11/code 


R
source(  paste( getwd(), '/AA_rqa_topology_HS01_HNHF.R', sep=''), echo=TRUE )
source(  paste( getwd(), '/AB_rqa_topology_HS01_VNVF.R', sep=''), echo=TRUE )

source(  paste( getwd(), '/BA_rqa_topology_RS01_HNHF.R', sep=''), echo=TRUE )
source(  paste( getwd(), '/BB_rqa_topology_RS01_VNVF.R', sep=''), echo=TRUE )
```




* `08_fig6.12/`

```
cd $HOME/phd/phd-thesis/0_code_data/1_code/8_figs_ch6/08_fig6.12/code 

R
source(  paste( getwd(), '/A_rqa_topology_w100.R', sep=''), echo=TRUE )
source(  paste( getwd(), '/B_rqa_topology_w250.R', sep=''), echo=TRUE )
source(  paste( getwd(), '/C_rqa_topology_w500.R', sep=''), echo=TRUE )
source(  paste( getwd(), '/D_rqa_topology_w750.R', sep=''), echo=TRUE )
```



* `09_fig6.13/`


```
cd $HOME/phd/phd-thesis/0_code_data/1_code/8_figs_ch6/09_fig6.13/code

R

source(  paste( getwd(), '/A_rqa_topology_sg0.R', sep=''), echo=TRUE )
source(  paste( getwd(), '/B_rqa_topology_sg1.R', sep=''), echo=TRUE )
source(  paste( getwd(), '/C_rqa_topology_sg2.R', sep=''), echo=TRUE )

```



* `10_fig6.14/`
```
cd $HOME/phd/phd-thesis/0_code_data/1_code/8_figs_ch6/10_fig6.14/code 


R

source(  paste( getwd(), '/B_rqa_topology_p02.R', sep=''), echo=TRUE )
source(  paste( getwd(), '/D_rqa_topology_p04.R', sep=''), echo=TRUE )


```


added:  Tue  7 May 15:19:40 BST 2019

















* [x] fix embedding parameters and recurrence thresholds indices
for the following: 

CHAPTER5
\newpage
\section{Weaknesses and strengths of RQA} \label{wsRQAhii}
Surfaces for RQA metrics (REC, DET, RATIO, ENTR) are computed with the 
variation of embedding values by an increase of one 
($0 \ge m \le 10$, $0 \ge \tau \le 10$) 
and recurrence thresholds by an increase of 0.1 ($0.2 \ge \epsilon \le 3$).
Hence, we show different characteristics of 3D surfaces of RQA considering 
different activities, sensors, window size lengths and level of smoothness 
and participants.


added: Mon Apr 22 20:09:10 BST 2019
sorted: first week of May 2019







* [x] fix embedding parameters and plots for m=9 and tao=6
	to 
	m0=6 and tau0=9

SORTED Mon  6 May 12:21:27 BST 2019





* [x] CODE_AND_DATA

The following references help me to organise the code and data 
path: 
https://towardsdatascience.com/how-to-keep-your-research-projects-organized-part-1-folder-structure-10bd56034d3a
http://cs.queensu.ca/~audrey/papers/GHC2009.BOFslides.pdf


However it required to be refined

```

~/phd/phd-thesis/0_code_data$ tree -d
.
├── 0_data
├── 1_code
│   ├── 0_machineinfo
│   ├── 1_dependencies
│   ├── 2_libraries_functions
│   │   ├── nonlinearTseries
│   │   │   ├── inst
│   │   │   ├── man
│   │   │   ├── R
│   │   │   ├── rfunctions
│   │   │   │   └── embedding_parameters
│   │   │   │       ├── mututalInformation
│   │   │   │       │   └── plots_path
│   │   │   │       └── withCao1997
│   │   │   │           ├── examples
│   │   │   │           └── references
│   │   │   ├── src
│   │   │   │   └── ANN
│   │   │   ├── tests
│   │   │   │   ├── testdata
│   │   │   │   ├── testextra
│   │   │   │   │   └── rqa
│   │   │   │   └── testthat
│   │   │   └── vignettes
│   │   └── rfunctions
│   │       └── embedding_parameters
│   │           ├── mututalInformation
│   │           │   └── plots_path
│   │           └── withCao1997
│   │               ├── examples
│   │               └── references
│   └── 3_figs_ch3
│       ├── fig_3.1
│       │   ├── code
│       │   ├── src
│       │   │   ├── extras
│       │   │   └── versions
│       │   └── vector
...
│       └── fig_3.7
│           ├── code
│           ├── data
│           ├── src
│           │   └── epsilons
│           └── vector
├── 2_pipeline
│   └── tmp
│       └── code_templates
└── 3_output
    ├── data
    └── figs
```

Sun 28 Apr 19:47:28 BST 2019





