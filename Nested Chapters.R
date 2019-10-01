#This script scrap the data in chapter part. 
#Because the chapters contains all of the subchapters.

library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)



#this loops scrapes the chapters and stores in tempList
completeBook <- function(x){
  for(i in 3:length( chapterURLS[,1])){
    if(chapterURLS[[i,3]] == "Chapter" ){
      print(paste("i is ", i , " and  url is: ", chapterURLS[i,1], " \n the json is " ,tempList[[i]][[1]]))
      rnd <- runif(1,min = 32,max=74)
      print(paste("system will sleep " , rnd, " seconds"))
      Sys.sleep(rnd)
      
      print(paste("This ",chapterURLS[[i,2]], "is a chapter",sep = ""))
      
      page <- read_html(chapterURLS[i,1])
      
      
      
      node <- html_node(page, paste("#",parseChapterElements(i),sep = ""))
      
      chr <- strsplit(as(node, "character"), "\n")
      
      
      tempList[[i]][[1]] <- chr
      
    }
  }
}

jsonList <-tempList
#this loops seperate the chapter from subchapters
for(i in 3:length(jsonList)){
  if(chapterURLS[i,3] == "Chapter"){
    print(paste("This is the begining i is :" ,i ))
     chr <- tempList[[i]][[1]]
     jsonList[[i]][[1]] <- ""
     for(j in 1:length(chr[[1]])){
       if(grepl(paste("<div id=", '\"', parseSubChapterElements(i+1),'\"',sep=""),chr[[1]][[j]])){
          print(paste("j is " , j, "and break" ))
         break()
  
       }else{
         
         jsonList[[i]][[1]] <- paste( jsonList[[i]][[1]], chr[[1]][[j]] )
         names(jsonList[[i]]) <- "HTML"
        }
     }


  }
}

#save.image()