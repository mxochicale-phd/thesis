


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




