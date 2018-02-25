# Configurating thesis

## Front Matter
* Thesis Title : Sections/thesis-info.tex _LINE1_

## Configure Draft Mode
* Sections/Preamble/preamble.tex _LINE160_







# TODO LIST

* [ ] Description Template _( created: ; sorted:)_


* [ ] Add small abstracts for the chapters  _( created:20feb2018, sorted: )_





* [ ] Structuring the thesis (created:25feb2018, sorted: )
When you have a draft outline, carefully review it with your supervisor: is there
unnecessary material (i.e. not directly related to the research question/aim)?
If so, remove or rework it. Is there missing material? Then add it. Whenever you
want to make a major change to your work, outlining it first can help you to
consider new, more persuasive possibilities for structure.




* [ ] Print a dummy version of the thesis and check the margins and pagination
 or modify them with  `custommargin` in `thesis.tex` and `preamble.tex`  (created: 21feb2018, sorted: )

> 4.3 Margins and Pagination
The margin on the binding edge must be at least 3 cm. When photographs are mounted the
binding margin must be increased to 4 cm (see section 2.7 below).
It is desirable to leave 3 cm at the top and bottom of the page and about 2 cm at the outer
edge.
Preliminary pages (see section 3.2) are unnumbered, pagination beginning with the first page
of the text proper. Page numbers may either be placed at top-centre, 1 cm below the edge or
at the foot of the page, 2 cm above the edge. Be consistent in whichever style you choose.





* [ ] Add papers to the thesis  _( created:20feb2018, sorted: )_





* [ ] Read carefully the resources and requirements before to submit PhD thesis
at University of Birmingham  _( CRAETED:21August2017, SORTED:DATE )_




# SORTED LIST







* [x] create a structure of the thesis map as the one proposed by Australian
National University _( CRAETED:31August2017, SORTED:DATE )_



* [x] improve the structure with the "Structuring Guide" that includes:
Chapter Number, Chapter title, How long (number of words),
Deadline, What you have got?  _( CRAETED:31August2017, SORTED:25february2018 )_



* [x] Change chapters font to capitals. Check other thesis to check that
this request is completed. [etheses](http://etheses.bham.ac.uk/)

> 4.4 Chapter Headings and Sub-Headings
New chapters should always commence on a fresh page. Titles should be in capitals and
centered. Sub-headings within chapters should be left-justified.


```
% Style 2: Sets Page Number at the Bottom with Chapter/Section Name on LO/RE
\fancypagestyle{PageStyleII}{
  \renewcommand{\chaptermark}[1]{\markboth{##1}{}}
  \renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
  \fancyhf{}
  \fancyhead[RO]{\bfseries\nouppercase \rightmark}
  \fancyhead[LE]{\bfseries \nouppercase \leftmark}
  \fancyfoot[C]{\thepage}
}

```


There are other thesis that use slighly different principles:
* http://etheses.bham.ac.uk/7913/1/Blackmore17PhD.pdf
* http://etheses.bham.ac.uk/7795/1/Al-Ajeli17PhD.pdf
* http://etheses.bham.ac.uk/7808/1/Abdul_Aziz17PhD.pdf


(created:21feb2018, sorted: 25feb2018 1530)




* [x] Add a proper title page adapting this template [:link:](https://www.overleaf.com/latex/templates/university-of-birmingham-thesis-template/tvtnffzspmwv#.Wo3SWFzyhhE)

> 3.2.1 Title Page
The title of the thesis should be given between 5 and 7 cm from the top of the page, followed
by the name of the author and, after about a 5 cm space, a statement of the degree for which
the thesis is submitted:

By modifying the following lines at `PhDThesisPSnPDF.cls`
```
\newsavebox{\PHD@submissionUoB}
\newsavebox{\PHD@deptschunidatUoB}
```
the title page were amended to fit the uob requirements for the title page

(created:21feb2018, sorted: 24feb2018,19:00)



* [x] Make sure you meet the PhD requirements for your institution.

> Length of the Thesis. 7.4.2(d). The maximum number of words in the PhD thesis
for Engineering and Physical Sciences is 50,000 words and no minimum of words.
The calculation of the word length excludes: abstract,
acknowledgements, contents pages, appendices, tables, diagrams and figures
(including associated legends), the list of references, bibliography, footnotes
and endnotes and any bound published material.


> 4.1 Typing and Wordprocessing
You must make your own arrangements for the typing of your thesis. Use double line-spacing
throughout the body of the text. Single-spacing is acceptable for quotations, footnotes,
captions, etc and within items in the bibliography.

`\doublespacing` LINE95 at `preamble/preamble.tex`


> 4.2 Typeface and Point Size
Recommended fonts include Times Roman, Arial and Courier or other type-1 or true-type fonts.
To help ensure clarity, it is important that the point size is not too small.
Your thesis may be photocopied or reduced at a later stage, so a 12 point typeface
is the recommended standard for general use.   

`%\documentclass[a4paper,12pt,times,print,index,authoryear]{classes/PhDThesisPSnPDF}`LINE4 of `thesis.tex`


> 4.5 Paper You should use A4 paper.

`%\documentclass[a4paper,12pt,times,print,index,authoryear]{classes/PhDThesisPSnPDF}`LINE4 of `thesis.tex`


_( CRAETED:20August2017, SORTED:DATE )_





* [x] Use apalike references  _( created:20feb2018, sorted:21feb2018 )_
	* `\documentclass[a4paper,12pt,times,draft,index,authoryear]{classes/PhDThesisPSnPDF}`



* [x] Change CAPITAL letters at the begining of paths and cleaning the structure
of the repository (created: 20feb2018, done:20feb2018)


* [x] Clean the Appendix Sections for  thesis v0.1
_( CRAETED:, SORTED:21August2017 )_

* [x] Reorganise the sections and subsections of the thesis v0.1
_( CRAETED:, SORTED:21August2017 )_

* [x] Clean the template and put a reference in the main README for
future reference in case of looking for examples.  thesis v0.1
_( CRAETED:14August2017, SORTED:20August2017 )_

* [x] Create Subdirectories for Chapters and Appendix.  thesis v0.1
_( CRAETED:, SORTED:21August2017 )_
