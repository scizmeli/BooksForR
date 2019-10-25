# BooksForR
Scraping executable R Books for melda.io platform!

## Introduction

In this project, it is aimed to download the data of current open source R books and convert them to [melda.io](https://www.melda.io) json   format by using R.  

The R books are taken from [BOOKDOWN](bookdown.org)  


Some of the popular R books are:  
-[Hands-On Programming with R](https://rstudio-education.github.io/hopr/)  
-[R Packages](https://r-pkgs.org/)  
-[Advanced R](https://adv-r.hadley.nz/)  
-[R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/)  
-[R for Data Science](https://r4ds.had.co.nz/)



### Where to get  
with    `git`     by running:
  `git clone https://github.com/suleymantaspinar/BooksForR.git`


### How to Run
`download_book.R` 
Type the one of the open source book url  from [BOOKDOWN](bookdown.org)  

`extract_book.R`
Type the cleanComments option and chapter numbers that will export as   [melda.io](https://www.melda.io) json  format. 


### Extracting Urls in Book  
##`get_all_urls.R`
In this script, a data fram	e named `chapterURLS` containing all links in the book, title and subtitle names has been created.
The href attribute of anchor elements extracted using the `html_node`  and `html_attr` function.
`getChapters` function  returns all chapter/subchapter data as  an output 


### Scraping Book Data  
##`nested_book.R` 

When we download all the data of the book, we see that the subchapters are duplicated because we are using fragments identifier. (eg:2.1 SubChapter occurs 2 times,
2.2.1 SubSubChapter occurs 3 times)

--| 2. Chapter  
--|--| 2.1 SubChapter  
--|--| 2.2 SubChapter   
--|--|--|2.2.1 SubSubChapter  
--|--|--|2.2.2 SubSubChapter  




