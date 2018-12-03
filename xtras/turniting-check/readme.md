Similarity Report


A typical submission made to an assignment in Turnitin generates a Similarity Report. 
The Similarity Report is the result of comparison between the text of the 
submission against the search targets selected for the assignment; 
this may include billions of pages of active and archived internet information, 
a repository of works previously submitted to Turnitin, 
and a repository of tens of thousands of periodicals, journals, and publications. [0]

The Match Overview gives you a breakdown of all the matches 
that have been found in the paper and allows you to clearly 
view the similarity score. Matches are ordered by the highest 
instance of similarity down to the lowest. 
Each match has a color and a number attached to it. 
These color tags will help you to find the match on the paper itself. [1]


Reference

[0](https://guides.turnitin.com/01_Manuals_and_Guides/Instructor_Guides/Turnitin_Classic_(Deprecated)/21_The_Similarity_Report/Viewing_the_Similarity_Report)
Viewing the Similarity Report

[1](https://guides.turnitin.com/01_Manuals_and_Guides/Student_Guides/Feedback_Studio/15_The_Similarity_Report/Viewing_the_Similarity_Report)
Viewing the Similarity Report

[2](https://www.youtube.com/watch?v=tgfvEh0yWek) 
How to get and interpret a Turnitin Originality Report



# Files 

## Reducing the pdf file size
```
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=output.pdf thesisMPX_optimised.pdf
```

-dPDFSETTINGS=/screen lower quality, smaller size. (72 dpi)  
-dPDFSETTINGS=/ebook for better quality, but slightly larger pdfs. (150 dpi)  
-dPDFSETTINGS=/prepress output similar to Acrobat Distiller "Prepress Optimized" setting (300 dpi)  
-dPDFSETTINGS=/printer selects output similar to the Acrobat Distiller "Print Optimized" setting (300 dpi)  
-dPDFSETTINGS=/default selects output intended to be useful across a wide variety of uses, possibly at the expense of a larger output file  

Reference
[1](https://askubuntu.com/questions/113544/how-can-i-reduce-the-file-size-of-a-scanned-pdf-file)



## Extracting similarity-report

```
pdftk thesisMPX_optimised.pdf cat 256-296 output similarity-report.pdf
```


## message

According to @turnitin:
The similarity score is a percentage of the paper's matches to other sources
and it is not an assessment of whether the paper includes plagiarized material.

This is my turnitin chekc report for my PhD thesis: 










