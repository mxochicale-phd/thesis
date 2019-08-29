fileinfo := LaTeX Makefile
author := Miguel P. Xochicale
version := alpha1

#########
# TODO:
# *add some of the following tools http://www.cs.berkeley.edu/~jaein/notes/Makefile.pdflatex
#


FILENAME = surrogatedata
LATEX = pdflatex -shell-escape -interaction=nonstopmode -file-line-error
BIB = bibtex

all:
	$(LATEX) $(FILENAME).tex
	$(LATEX) $(FILENAME).tex
	$(BIB) $(FILENAME)
	$(BIB) $(FILENAME)
	$(LATEX) $(FILENAME).tex
	$(LATEX) $(FILENAME).tex
	$(BIB) $(FILENAME)
	evince $(FILENAME).pdf &
	@echo "================================================"
	@echo "All done! pdf file has been created".
	@echo "================================================"

clean:
	rm -f *~
	rm -rf *.backup
	rm *.aux *.bbl *.blg *.log
	rm -f `ls $(FILENAME).* | grep -v .tex | grep -v .pdf`
	echo "Cleaning complete!"
