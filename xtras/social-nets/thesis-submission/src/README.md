


# extracting pdf pages 


pdftk ../../../../thesis.pdf cat 34 output to.pdf
pdftk ../../../../thesis.pdf cat 54 output rss.pdf
pdftk ../../../../thesis.pdf cat 75 output hii.pdf
pdftk ../../../../thesis.pdf cat 77 output hhi.pdf
pdftk ../../../../thesis.pdf cat 105 output bprqa.pdf
pdftk ../../../../thesis.pdf cat 141 output 3drqa.pdf

# converting pdf to png


convert -density 150 to.pdf -quality 90 to.png
convert -density 150 rss.pdf -quality 90 rss.png
convert -density 150 hii.pdf -quality 90 hii.png
convert -density 150 hhi.pdf -quality 90 hhi.png
convert -density 150 bprqa.pdf -quality 90 bprqa.png
convert -density 150 3drqa.pdf -quality 90 3drqa.png




## sources

https://about.zenodo.org/static/img/logos/zenodo-gradient-round.svg
Mon 29 Oct 01:00:54 GMT 2018


https://about.zenodo.org/static/img/logos/zenodo-gradient-1000.png
Mon 29 Oct 01:03:01 GMT 2018


https://www.drupal.org/project/ghpages
Mon 29 Oct 01:26:18 GMT 2018


https://blogs.napier.ac.uk/open-access/wp-content/uploads/sites/17/2014/11/OAlogo.jpg
Mon 29 Oct 01:31:35 GMT 2018
