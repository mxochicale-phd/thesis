##################
# USAGE
# sh splitting.sh
#



# PhD Working Path
WP=$HOME/phd 
#echo "$WP" 

# create tmp path
mkdir -p $HOME/phd/tmp



##abstract
#pdftk $WP/phd-thesis/thesis.pdf cat 3 output $WP/tmp/abstract.pdf

##chapter1
#pdftk $WP/phd-thesis/thesis.pdf cat 21-38 output $WP/tmp/ch1.pdf

###chapter5
#pdftk $WP/phd-thesis/thesis.pdf cat 87-122 output $WP/tmp/ch5.pdf

##chapter6
#pdftk $WP/phd-thesis/thesis.pdf cat 123-148 output $WP/tmp/ch6.pdf

##chapter7
#pdftk ../../thesis.pdf cat 147-155 output ../../../tmp/ch7.pdf


