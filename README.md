# Executable R Books for Melda.io
Scraping  R Books and making executable on [melda.io](https://www.melda.io) platform!

## Introduction

In this project, it is aimed to download the data of current open source R books and convert them to [melda.io](https://www.melda.io) json   format by using R.    [melda.io](https://www.melda.io)  is a new, innovative, web-based cloud-native data science platform. You can create data analysis projects with R, python, publish your work, interact and co-create with others.

The R books are taken from [BOOKDOWN](https://bookdown.org)  


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


### 1.Extracting Urls in Book  
`get_all_urls.R`
In this script, a data fram	e named `chapterURLS` containing all links in the book, title and subtitle names has been created.
The href attribute of anchor elements extracted using the `html_node`  and `html_attr` function.
`getChapters` function  returns all chapter/subchapter data as  an output 


### 2. Scraping Book Data
`get_all_book.R`
In this script, all the book data is downloaded and stored as R object.  

`parseSubChapterElement` function accepts urls as  a input and give the outputs of div elements.  
`parseChapterElement` function accepts urls as  a input and gives output of div element of link  

### 3.Removing duplicated parts  
`nested_book.R`  

When we download all the data of the book, we see that the subchapters are duplicated because we are using fragments identifier. (eg:2.1 SubChapter occurs 2 times,
2.2.1 SubSubChapter occurs 3 times)

--| 2. Chapter  
--|--| 2.1 SubChapter  
--|--| 2.2 SubChapter   
--|--|--|2.2.1 SubSubChapter  
--|--|--|2.2.2 SubSubChapter  

we just need to delete all the subchapters to extract the  only data in the 2nd chapter.
### 4. Splitting Text and Code Blocks  
`merge_and_sort.R`    

The text and code blocks are seperated  and assigned to a  named list element.("HTML" or "R")
  


### 5.Cleaning R Code Output  
`remove_comments.R`  

In this section, the code blocks are read line by line, the code outputs are deleted.
Lines starting with `"#>"` are the code output.Lines starting with `"#"` comments.

### 6.Relative / Absolute Links
`html_links.R`  

In this section, chapter names at the beginning of relative links have been removed.(eg: `href = "chaptername#subchaptername"` to href = `"#subchaptername"`).Because chapters are exported as a stage in melda.io json format.The `target = _blank` has been added to all absolute links in the book  to open links on a new tab.


### 7.Export as melda.io json format
`export_as_melda_json.R`  

In this section example of melda.io json file is converted to  R object using `jsonlite` library.Then the number of cells to be generated  is determined by using `getCellNumber` function.
(eg: 3. chapter has 26 named "HTML"  and  14 named "R" list element, we need 40  cell for JSON file. getCellNumber(3) == 40).R list is created that contains as many cells as the number of named list elements in the book. Finally the R object is exported as a  melda.io json file.

## Published Books

-[Fundamentals of Data Visualizaion](https://www.melda.io/projects/fundamentals-of-data-visualizations/)  
  
-[Tidy Text Mining](https://www.melda.io/projects/tidy-text-mining/)  
  
-[R Packages](https://www.melda.io/projects/r-packages-hadley-wickham/)
   
-[R for Data Science](https://www.melda.io/projects/r-for-data-science-hadley-wickham/)

