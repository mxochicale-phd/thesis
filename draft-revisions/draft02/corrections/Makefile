fileinfo := LaTeX Makefile
author := Miguel P. Xochicale
version := alpha2


ALLTEX = $(wildcard *.tex)
TEXFILE = $(basename $(ALLTEX))
#TEXFILE = mx-revisions-v03

LATEX = pdflatex -shell-escape -interaction=nonstopmode -file-line-error
BIB = bibtex

all:
	$(LATEX) $(TEXFILE).tex
	$(LATEX) $(TEXFILE).tex
	#$(BIB) $(TEXFILE)
	#$(BIB) $(TEXFILE)
	$(LATEX) $(TEXFILE).tex
	$(LATEX) $(TEXFILE).tex
	@echo "================================================"
	@echo "All done! pdf file has been created. "
	@echo "================================================"
	evince $(TEXFILE).pdf &

clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.toc
	rm -f *.backup
	@echo "================================================"
	@echo "All cleaned!  "
	@echo "================================================"

	
