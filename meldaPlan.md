#R Books for Melda Platform

##Summary: In this project It is aimed to transform R books to make it work in melda platform.Firstly the official R book names 
and links are searched.Then Html/XML items parsed for extracing the book data. "Httr","Rvest","jsonlite",
"dplyr" libraries are used in this project.

###1)Choosing the site where is going to extract the book data.


**Aim**:To write a script thats scrap the book links automatically then generates books chapter link.


**Method**:

1.1)Send a get request to the "https://bookdown.org".

1.2)Find  html cells using css selector or manually.

1.3)Clean the extracted data if needed.

1.4)Save the results as data frame or list.

**Hours**:1st week

### 2)Extract/Splitting the book data.


**Method**: 

2.1)Send a get request to the "https://rstudio-education.github.io/hopr/".

2.2)Find the cells which include chapters name.

2.3)Examine the structure  of the chapter link.( Eg; "booknames/" + "chaptername" + ".html" )

2.4)Write a function that accepts input the chapter number/name and generates a link for chapters.
    2.4.1)go to  li element which class' name is "chapter"
    2.4.2)find the attribute of li element
    2.4.3)append this element attribute to the end of link.
   
2.5)Write a function that accepts  link of chapter of the function generates the sub chapters link as output.
    2.5.1)go to "a" element using "html_nodes()" function.
    2.5.2)find the attribute of "a" elements using html_attr function.
    2.5.3)append this element attribute to the end of the sub chapters link.("booknames/chaptername.html" +"#" + "subchapter-name")
    
2.6)Extract the text and r-chunks using the chapters sub link.
    2.6.1)write a regular expression with "gsub" or "string_replace" for the class="sourceCode"
	
2.7)Test the R chunks in the book for one chapter/subchapter.
    2.7.1)check for libraries,install libraries if needed
    2.7.2)use libraries
    2.7.3)if chunks run go to next step
    2.7.4)Repeat this step above until there are no chapters.
    
**Hours**: 2nd -5th weeks

### 3)Export as melda.io JSON format

**Method**:
3.1)export the book data as melda.io JSON format using "jsonlite" library.

**Hours**: 5th-6th weeks
Features:


*Presentation Notes
**how should you improve the melda.io platform?
give an detailed example, 
**tell your plans to audience, how you solved the problems with steps basically?    
**which problem you are solving with your product? 
**don't say the blah blah words
**don't make it your project insignificiant
**positive/negative experience about 
*use grammarly to fix spelling errors.
