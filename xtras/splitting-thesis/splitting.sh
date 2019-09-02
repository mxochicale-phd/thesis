##################
# USAGE
# sh splitting.sh
#


#################################
# NOTE: Running this shell takes 
# a bit of time! (Not sure what is the reason)



# PhD Working Path
WP=$HOME/phd/thesis 
#echo "$WP" 





###abstract
pdftk $WP/thesis.pdf cat 3 output $WP/xtras/splitting-thesis/pdfs/abstract.pdf

###chapter1
pdftk $WP/thesis.pdf cat 21-38 output $WP/xtras/splitting-thesis/pdfs/ch1.pdf

###chapter2
pdftk $WP/thesis.pdf cat 39-52 output $WP/xtras/splitting-thesis/pdfs/ch2.pdf

###chapter3
pdftk $WP/thesis.pdf cat 53-74 output $WP/xtras/splitting-thesis/pdfs/ch3.pdf

###chapter4
pdftk $WP/thesis.pdf cat 75-86 output $WP/xtras/splitting-thesis/pdfs/ch4.pdf

##chapter5
pdftk $WP/thesis.pdf cat 87-122 output $WP/xtras/splitting-thesis/pdfs/ch5.pdf

##chapter6
pdftk $WP/thesis.pdf cat 123-148 output $WP/xtras/splitting-thesis/pdfs/ch6.pdf

##chapter7
pdftk $WP/thesis.pdf cat 149-158 output $WP/xtras/splitting-thesis/pdfs/ch7.pdf

##appendixes
pdftk $WP/thesis.pdf cat 159-252 output $WP/xtras/splitting-thesis/pdfs/appendixes.pdf

#references
pdftk $WP/thesis.pdf cat 253-266 output $WP/xtras/splitting-thesis/pdfs/references.pdf



