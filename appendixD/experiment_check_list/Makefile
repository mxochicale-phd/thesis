fileinfo := LaTeX Makefile
author := Miguel P. Xochicale
version := alpha1

#############
# HOW TO USE
#


#########
# TODO:
# *add some of the following tools http://www.cs.berkeley.edu/~jaein/notes/Makefile.pdflatex 
#

##########
# CHANGES:

# Thu Nov 12 10:00:04 GMT 2015
#http://ubuntuforums.org/showthread.php?t=689282
#Passing an argument through a makefile? 

# MAPX (2015-03-24):
# * Bumped version to alpha1
# * added LATEX, BIB variables


FILENAME = cl
LATEX = pdflatex -shell-escape -interaction=nonstopmode -file-line-error
BIB = bibtex

all:
	$(LATEX) $(FILENAME).tex
	$(LATEX) $(FILENAME).tex
#	$(BIB) $(FILENAME)
#	$(BIB) $(FILENAME)
	$(LATEX) $(FILENAME).tex
	$(LATEX) $(FILENAME).tex
	evince $(FILENAME).pdf &
	@echo "================================================"
	@echo "All done! pdf has been created. - Miguel"
	@echo "================================================"

clean:         
	rm -f *~
	rm -rf *.backup
	rm -f `ls $(FILENAME).* | grep -v .tex | grep -v .pdf`
	echo "Cleaning complete!"



# all: 
# 	$(LATEX) $(FILENAME).tex
# 	$(BIB) $(FILENAME)
# 	$(LATEX) $(FILENAME).tex
# 	$(LATEX) $(FILENAME).tex
# 	evince $(FILENAME).pdf &
# 	@echo "================================================"
# 	@echo "All done! report.pdf has been created. - Miguel"
# 	@echo "================================================"

# clean:         
# 	rm -f *~
# 	rm -rf *.backup
# 	rm -f `ls $(FILENAME).* | grep -v .tex | grep -v .pdf`
# 	echo "Cleaning complete!"


