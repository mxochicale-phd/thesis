%%
%% This is file `bhamthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% bhamthesis.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% The following are copied from the template by Scott Pakin.
%% 
%% Copyright (C) 2009 by Tin Lok Wong
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.2 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of LaTeX version
%% 1999/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{bhamthesis}
    [2009/12/26 v3.3 UoB thesis class]
\ClassInfo{bhamthesis}
  {University of Birmingham (unofficial)\MessageBreak
   MPhil/PhD thesis document class\@gobble}
\newcommand{\bt@ptsize}{2}
\DeclareOption{10pt}{\renewcommand{\bt@ptsize}{0}}
\DeclareOption{11pt}{\renewcommand{\bt@ptsize}{1}}
\DeclareOption{12pt}{\renewcommand{\bt@ptsize}{2}}
\newif\if@paperspecexists \@paperspecexistsfalse
\DeclareOption{a4paper}
  {\PassOptionsToClass{a4paper}{report}\@paperspecexiststrue}
\DeclareOption{a5paper}
  {\PassOptionsToClass{a5paper}{report}\@paperspecexiststrue}
\DeclareOption{b5paper}
  {\PassOptionsToClass{b5paper}{report}\@paperspecexiststrue}
\DeclareOption{letterpaper}
  {\PassOptionsToClass{letterpaper}{report}\@paperspecexiststrue}
\DeclareOption{legalpaper}
  {\PassOptionsToClass{legalpaper}{report}\@paperspecexiststrue}
\DeclareOption{executivepaper}
  {\PassOptionsToClass{executivepaper}{report}\@paperspecexiststrue}
\newif\if@apxline   \@apxlinefalse
\newif\if@apxprefix \@apxprefixfalse
\DeclareOption{toclineappendix}{\@apxlinetrue}
\DeclareOption{prefixappendix}{\@apxprefixtrue}
\DeclareOption{reqfonts}{\AtEndOfClass{%
                          \RequirePackage[T1]{fontenc}
                          \RequirePackage{mathptmx}
                          \RequirePackage[scaled=0.89]{uarial}
                          \RequirePackage{courier}}}
\DeclareOption{fancyfonts}{\AtEndOfClass{%
                            \RequirePackage{mathptmx}
                            \RequirePackage{tgtermes}[2009/09/27]
                            \RequirePackage[matchlowercase]{tgheros}[2009/09/27]
                            \RequirePackage[matchlowercase]{tgcursor}[2009/09/10]}}
\newif\if@alldoublespace \@alldoublespacefalse
\DeclareOption{alldoublespace}{\@alldoublespacetrue}
\newif\if@nodoublespace \@nodoublespacefalse
\DeclareOption{nodoublespace}{\@nodoublespacetrue}
\DeclareOption{savespace}
  {\ExecuteOptions{10pt,nodoublespace,openany,draft}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\if\bt@ptsize0\PassOptionsToClass{10pt}{report}\else%
 \if\bt@ptsize1\PassOptionsToClass{11pt}{report}\else%
  \PassOptionsToClass{12pt}{report}\fi\fi
\if@paperspecexists\else\PassOptionsToClass{a4paper}{report}\fi
\LoadClass{report}
\RequirePackage{setspace}[2000/12/01]
\newcommand{\optsinglespacing}{\if@alldoublespace\else\singlespacing\fi}
\newenvironment{optsinglespace}
 {\if@alldoublespace\begingroup\else\begin{singlespace}\fi}
 {\if@alldoublespace\endgroup\else\end{singlespace}\fi}
\RequirePackage{perpage}[2006/07/15]
\AtEndOfClass{\RequirePackage{bhamthesis}}
\setlength  {\oddsidemargin} {3cm}
\addtolength{\oddsidemargin} {-1in}
\setlength  {\evensidemargin}{2cm}
\addtolength{\evensidemargin}{-1in}
\setlength  {\textwidth}{\paperwidth}
\addtolength{\textwidth}{-3cm}
\addtolength{\textwidth}{-2cm}
\setlength  {\topmargin}{3cm}
\addtolength{\topmargin}{-1in}
\addtolength{\topmargin}{-\headheight}
\addtolength{\topmargin}{-\headsep}
\setlength  {\textheight}{\paperheight}
\addtolength{\textheight}{-3cm}
\addtolength{\textheight}{-3cm}
\setlength  {\footskip}{1cm}
\newlength{\lmarginparwidth}
\newlength{\rmarginparwidth}
\setlength  {\lmarginparwidth}{3cm}
\addtolength{\lmarginparwidth}{-\marginparsep}
\addtolength{\lmarginparwidth}{-0.2in}
\setlength  {\rmarginparwidth}{2cm}
\addtolength{\rmarginparwidth}{-\marginparsep}
\addtolength{\rmarginparwidth}{-0.2in}
\reversemarginpar
\setlength{\marginparwidth}{\lmarginparwidth}
\let\oldnormalm@rginpar\normalmarginpar
\let\oldreversem@rginpar\reversemarginpar
\let\oldm@rginpar\marginpar
\renewcommand{\normalmarginpar}%
 {\oldreversem@rginpar%
  \setlength\marginparwidth\lmarginparwidth}
\renewcommand{\reversemarginpar}%
 {\oldnormalm@rginpar%
  \setlength\marginparwidth\rmarginparwidth}
\renewcommand\marginpar[2][\dummy@rg]%
 {\def\dummy@rg{#2}%
  \oldm@rginpar[\optsinglespacing#2]{\optsinglespacing#1}}
\renewcommand{\bibname}{List of References}
\author{[Author Missing]}
\title{[Title Missing]}
\renewcommand{\today}{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or
  December\fi~\number\year}
\newlength{\addsswidth}
\setlength{\addsswidth}{\z@}
\newlength{\bt@adjusti}
\newlength{\bt@adjustii}
\newlength{\bt@adjustiii}
\AtBeginDocument{%
  \@ifpackageloaded{tgtermes}
   {\setlength{\bt@adjusti}{-.457\baselineskip}
    \setlength{\bt@adjustii}{-.029\baselineskip}
    \setlength{\bt@adjustiii}{-.340\baselineskip}}
   {\@ifpackageloaded{mathptmx}
    {\setlength{\bt@adjusti}{-.454\baselineskip}
     \setlength{\bt@adjustii}{-.039\baselineskip}
     \setlength{\bt@adjustiii}{-.332\baselineskip}}
    {\setlength{\bt@adjusti}{-.430\baselineskip}
     \setlength{\bt@adjustii}{-.027\baselineskip}
     \setlength{\bt@adjustiii}{-.321\baselineskip}}}}
\renewcommand{\maketitle}{%
  \checkorder{1}\setcounter{currpart}{1}%
  \begin{titlepage}%
  \optsinglespacing
  \let\footnotesize\small
  \let\footnoterule\relax
  \let\footnote\thanks
  \raggedright\LARGE%
  \rule{0cm}{3cm}\\[\bt@adjusti]%
  \uppercase\expandafter{\@title}%
   \if@alldoublespace\\[.2\baselineskip]\else\\[\baselineskip]\fi
  {\large by}%
   \if@alldoublespace\\[.2\baselineskip]\else\\[\baselineskip]\fi
  \uppercase\expandafter{\@author}\\[\bt@adjustii]
  \rule{0cm}{5cm}\\[\bt@adjustiii]
  \large\noindent\@submissionstatement\\
  \MakeUppercase{\@degree}
  \vfill
  \ifdim\addsswidth>\z@\else%  %%
   \let\@tempcmd\thanks
   \renewcommand\thanks[1]{\footnotemark}
   \renewcommand\footnote[1]{\footnotemark}
   \settowidth{\addsswidth}{\@school}%
   \sbox\@tempboxa{\@college}%
   \ifdim\wd\@tempboxa>\addsswidth%
    \settowidth{\addsswidth}{\@college}%
   \fi
   \sbox\@tempboxa{\@university}%
   \ifdim\wd\@tempboxa>\addsswidth%
    \settowidth{\addsswidth}{\@university}%
   \fi
   \sbox\@tempboxa{\@date}%
   \ifdim\wd\@tempboxa>\addsswidth%
    \settowidth{\addsswidth}{\@date}%
   \fi
   \let\thanks\@tempcmd
   \let\footnote\@tempcmd
  \fi
  \begin{flushright}\begin{minipage}{\addsswidth}%
   \raggedright\large
   \@school\\
   \@college\\
   \@university\\
   \@date
  \end{minipage}\end{flushright}\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \@titleexiststrue%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\@submissionstatement\@empty
  \global\let\@degree\@empty
  \global\let\@college\@empty
  \global\let\@school\@empty
  \global\let\@university\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\submissionstatement\relax
  \global\let\degree\relax
  \global\let\school\relax
  \global\let\university\relax
  \global\let\and\relax
}
\renewenvironment{abstract}{%
    \global\@abstractexiststrue%
    \checkorder{2}\setcounter{currpart}{2}%
    \titlepage
    \null\vfil
    \@beginparpenalty\@lowpenalty
    \begin{center}%
      \bfseries \abstractname
      \@endparpenalty\@M
    \end{center}}%
   {\par\vfil\null\endtitlepage}
\newlength{\dedwidth}
\setlength{\dedwidth}{.5\textwidth}
\newcommand{\dedabove}{3}
\newcommand{\dedbelow}{8}
\newenvironment{dedication}
 {\if@twocolumn%
   \@restonecoltrue\onecolumn%
  \else%
   \@restonecolfalse\newpage%
  \fi%
  \checkorder{3}\setcounter{currpart}{3}%
  \if@openright\cleardoublepage\else\clearpage\fi
  \null\vspace*{\stretch{\dedabove}}%
  \begin{center}\begin{minipage}{\dedwidth}\raggedright}%
 {\end{minipage}\end{center}\vspace*{\stretch{\dedbelow}}\null%
  \if@restonecol\twocolumn \else \newpage \fi}
\newenvironment{acknowledgements}
 {\if@twocolumn%
   \@restonecoltrue\onecolumn%
  \else%
   \@restonecolfalse\newpage%
  \fi%
  \checkorder{4}\setcounter{currpart}{4}%
  \chapter*{\acknowname}}
 {\if@restonecol\twocolumn \else \newpage \fi}
\renewcommand{\tableofcontents}{\@tocexiststrue%
    \checkorder{5}\setcounter{currpart}{5}%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }
\renewcommand{\listoffigures}{%
    \checkorder{6}\setcounter{currpart}{6}%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
\renewcommand{\listoftables}{%
    \checkorder{7}\setcounter{currpart}{7}%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
      \@mkboth{%
          \MakeUppercase\listtablename}%
         {\MakeUppercase\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }
\newcommand{\toclineappendix}{\@apxlinetrue}
\newcommand{\prefixappendix}{\@apxprefixtrue}
\newcommand{\prefixappendixoff}{\@apxprefixfalse}
\renewcommand{\appendix}{%
  \checkorder{10}\setcounter{currpart}{10}
  \if@apxline%
   \addtocontents{toc}{\protect\contentsline {chapter}{\appendixname}{}}
  \fi\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}}
\renewenvironment{thebibliography}[1]
     {\checkorder{11}\setcounter{currpart}{11}%
      \begin{optsinglespace}%
      \chapter*{\bibname}%
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m%
      \if@nodoublespace\else%
       \if@alldoublespace\else%
        \addtolength{\itemsep}{\baselineskip}
       \fi
      \fi}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist\end{optsinglespace}}
\renewenvironment{theindex}
               {\checkorder{12}\setcounter{currpart}{12}%
                \if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi%
                \ClassWarningNoLine{bhamthesis}%
                 {No index should exist in theses}}%
\newcommand{\namepart}[1]%
 {\ifcase#1 Very Beginning\or Title Page\or
  \abstractname\or Dedication\or \acknowname\or \contentsname\or
  \listfigurename\or \listtablename\or List of Definitions and
  Abbreviations\or Main Text\or \appendixname\or \bibname\or
  \indexname\fi}
\newcounter{currpart}
\setcounter{currpart}{0}
\newcommand{\checkorder}[1]
  {\ifnum#1<\value{currpart}%
    \ClassWarningNoLine{bhamthesis}%
     {The \namepart{#1} should not
      come after the \namepart{\value{currpart}}}%
   \else\ifnum#1=\value{currpart}%
       \ClassWarningNoLine{bhamthesis}{There are two \namepart{#1}'s}%
     \fi%
   \fi}
\newif\if@titleexists \@titleexistsfalse
\newif\if@abstractexists \@abstractexistsfalse
\newif\if@tocexists \@tocexistsfalse
\newif\if@mainexists \@mainexistsfalse
\newif\if@frontexists \@frontexistsfalse
\newif\if@pagenumber \@pagenumbertrue
\newcommand{\frontmatter}{%
  \cleardoublepage
  \@pagenumberfalse
  \pagenumbering{roman}%
  \pagestyle{empty}%
  \@frontexiststrue%
  \ifnum\value{currpart}=0\else%
    \ClassWarningNoLine{bhamthesis}%
     {Please put \noexpand\frontmatter before everything}%
  \fi}%
\newcommand{\mainmatter}{%
    \cleardoublepage
  \@pagenumbertrue
  \pagenumbering{arabic}%
  \pagestyle{plain}%
  \@mainexiststrue%
  \checkorder{9}\setcounter{currpart}{9}}
\newcommand{\backmatter}{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@pagenumbertrue}
\AtEndDocument{%
 \if@titleexists\else%
  \ClassWarningNoLine{bhamthesis}{Remember to include a \namepart{1}}%
 \fi}
\AtEndDocument{%
 \if@abstractexists\else%
  \ClassWarningNoLine{bhamthesis}{Remember to include a \namepart{2}}%
 \fi}
\AtEndDocument{%
 \if@tocexists\else%
  \ClassWarningNoLine{bhamthesis}{Remember to include a \namepart{5}}%
 \fi}
\AtEndDocument{%
 \if@frontexists%
  \if@mainexists\else%
   \ClassWarningNoLine{bhamthesis}%
    {Remember to use \noexpand\mainmatter to activate page numbering}%
  \fi
 \else
  \if@mainexists%
   \ClassWarningNoLine{bhamthesis}%
    {Remember to use \noexpand\frontmatter to suppress page numbering}%
  \else
   \ClassWarningNoLine{bhamthesis}%
    {Remember to use \noexpand\frontmatter and \noexpand\mainmatter
     to tweak page numbering}%
  \fi%
 \fi}
\if@nodoublespace\else\doublespacing\fi
\let\display\quote
\let\enddisplay\endquote
\let\displaypar\quotation
\let\enddisplaypar\endquotation
\renewenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax
                \begin{optsinglespace}}
               {\end{optsinglespace}\endlist}
\renewenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax
                \begin{optsinglespace}}
               {\end{optsinglespace}\endlist}
\MakePerPage{footnote}
\renewcommand{\chapter}%
 {\if@openright\cleardoublepage\else\clearpage\fi
  \if@pagenumber\thispagestyle{plain}\else\thispagestyle{empty}\fi
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
 \ifnum \c@secnumdepth >\m@ne
  \refstepcounter{chapter}%
  \typeout{\@chapapp\space\thechapter.}%
  \ifnum\value{currpart}=10%
   \if@apxline%
    \addcontentsline{toc}{chapter}%
              {\protect\numberline{\thechapter}#1}%
   \else%
    \if@apxprefix%
     \addcontentsline{toc}{chapter}{\appendixname\nobreakspace\thechapter: #1}%
    \else%
     \addcontentsline{toc}{chapter}%
               {\protect\numberline{\thechapter}#1}%
    \fi%
   \fi%
  \else%
   \addcontentsline{toc}{chapter}%
             {\protect\numberline{\thechapter}#1}%
  \fi%
 \else
  \addcontentsline{toc}{chapter}{#1}%
 \fi
 \chaptermark{#1}%
 \addtocontents{lof}{\protect\addvspace{10\p@}}%
 \addtocontents{lot}{\protect\addvspace{10\p@}}%
 \if@twocolumn
   \@topnewpage[\@makechapterhead{#2}]%
 \else
   \@makechapterhead{#2}%
   \@afterheading
 \fi}
\renewcommand{\@makechapterhead}[1]{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \Large\centering
        \begin{optsinglespace}%
         \MakeUppercase{\@chapapp\space \thechapter}%
        \end{optsinglespace}%
        \par\nobreak
        \vskip 20\p@
    \fi
    \interlinepenalty\@M
    \LARGE\centering
    \begin{optsinglespace}%
     \MakeUppercase{#1}%
    \end{optsinglespace}%
    \par\nobreak
    \vskip 40\p@
  }}
\renewcommand{\@makeschapterhead}[1]{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum\value{currpart}=10%
        \Large\centering
        \begin{optsinglespace}%
         \MakeUppercase{\@chapapp}%
        \end{optsinglespace}%
        \par\nobreak
        \vskip 20\p@
    \fi
    \interlinepenalty\@M
    \LARGE\centering
    \begin{optsinglespace}%
     \MakeUppercase{#1}%
    \end{optsinglespace}%
    \par\nobreak
    \vskip 40\p@
  }}
\renewcommand{\@schapter}[1]{%
  \ifnum\value{currpart}=11%
   \addcontentsline{toc}{chapter}{#1}%
  \else%
   \ifnum\value{currpart}=10%
    \if@apxline%
     \addcontentsline{toc}{chapter}{#1}%
    \else%
     \if@apxprefix%
      \addcontentsline{toc}{chapter}{\protect\appendixname: #1}%
     \else%
      \addcontentsline{toc}{chapter}{#1}%
     \fi%
    \fi%
   \fi%
  \fi%
  \if@twocolumn
   \@topnewpage[\@makeschapterhead{#1}]%
  \else
   \@makeschapterhead{#1}%
   \@afterheading
  \fi}
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{\optsinglespacing%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\optsinglespacing\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}
\def\@ssect#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{\optsinglespacing%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M #5\@@par}%
    \endgroup
  \else
    \def\@svsechd{#4{\optsinglespacing\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}}
\iffalse
 \renewcommand{\floatpagefraction}{0.99999237}
\fi
\newcommand{\captiontext}{\@empty}
\newlength{\pl@tewidth}
\AtBeginDocument{\setlength{\pl@tewidth}  {\textwidth}
                 \addtolength{\pl@tewidth}{-\plateextramar}}
\newlength{\plateextramar}
\setlength{\plateextramar}{1cm}
\newcommand{\giveflo@tnum}{%
   \refstepcounter\@captype
   \expandafter\@firstofone
   \par
   \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
   \normalsize
   \@makepagecaption{\csname fnum@\@captype\endcsname}\par
   \endgroup}
\newcommand{\giveflo@tcaption}{%
 \if\captiontext\@empty\else%
  \@makepagecaption{\captiontext}%
 \fi%
 \addcontentsline{\csname ext@\@captype\endcsname}{\@captype}%
   {\protect\numberline{\csname the\@captype\endcsname}%
   {\ignorespaces \captiontext}}
 \renewcommand\captiontext\@empty}
\newcommand{\@makepagecaption}[1]{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1}%
  \ifdim \wd\@tempboxa >\hsize
    #1\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\newenvironment{figurepage}
  {\renewcommand{\caption}[1]%
    {\renewcommand{\captiontext}{{}##1}}%
   \@float{figure}[p]%
   \makebox[\plateextramar][l]%
    {\rule[-.5\textheight]%
     {\z@}{\textheight}}%
   \begin{minipage}[c]{\pl@tewidth}%
   \giveflo@tnum}%
  {\giveflo@tcaption%
   \end{minipage}%
   \end@float}
\newenvironment{tablepage}
  {\renewcommand{\caption}[1]%
    {\renewcommand{\captiontext}{{}##1}}%
   \@float{table}[p]%
   \makebox[\plateextramar][l]%
    {\rule[-.5\textheight]%
     {\z@}{\textheight}}%
   \begin{minipage}{\pl@tewidth}%
   \giveflo@tnum}%
  {\giveflo@tcaption%
   \end{minipage}%
   \end@float}
\endinput
%%
%% End of file `bhamthesis.cls'.
