#!/usr/bin/env Rscript

library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)

temp <- vector(mode = "list",length= 70)

#creating list to export as
jsonList <- subChapterList

#this loops seperate the chapter from subchapters
for(i in 3: (length(jsonList) - 1)){
  
  if(chapterURLS[i,3] == "Chapter" && chapterURLS[i+1,3] == "SubChapter" ){
    
    print(paste("This is the begining i is :" ,i ))
    
    chr <- subChapterList[[i]] 
    
    jsonList[[i]] <- ""
    
    temp <- vector(mode = "list",length= 70)
    j <- 1
    
    for(t in 1:length(chr)){
      
      if( chapterURLS[i + 1, 3] != "Chapter" && length(chr[[t]]) != 0 ){
        print(paste("the next is NOTT chapter and i is:", i))
        if( grepl(paste("<div id=", '\"', parseSubChapterElements(i+1),'\"',sep=""),chr[[t]]) ){
          break()
          print(paste("j is " , j, "and break" ))
          
        }else{
          
          temp[[j]] <-paste(temp[[j]],chr[[t]],"\n", sep="")
          names(temp[[j]]) <- "HTML"
        }
      }else if (chapterURLS[i + 1, 3] == "Chapter" && length(chr[[t]]) != 0){
        print(paste("the next is chapter and i is:", i))
        if( grepl(paste("<div id=", '\"', parseChapterElements(i+1),'\"',sep=""),chr[[t]])  && length(chr[[t]]) != 0){
          print(paste("j is " , j, "and break" ))
          break()
          
        }else{
          
          temp[[j]] <-paste(temp[[j]],chr[[t]],"\n", sep="")
          names(temp[[j]]) <- "HTML"
        }
      }
    }
    
    
    jsonList[[i]] <- temp
    jsonList[[i]]<- jsonList[[i]][!unlist(lapply(jsonList[[i]], is.null))]
    
    
  }
}


#seperate subchapters from subsubchapters
for(i in 3:(length(jsonList)-1)){
  if(chapterURLS[i,3] == "SubChapter" && chapterURLS[i + 1,3] == "SubSubChapter"){
    print(paste("Subchapters which have subchapters:  " , i ,"  ."))
    
    
    jsonList[[i]] <- ""
    for(z in 1:length(subChapterList[[i]])){
      temp <- vector(mode = "list",length= 70)
      j <- 1
      for(t in 1:length(subChapterList[[i]])) {
        if(grepl(paste("<div id=", '\"', parseSubChapterElements(i+1),'\"',sep=""),subChapterList[[i]][[t]])){
          print(paste("j is " , z, "and break" ))
          break()
        }
        else if(!grepl( "sourceCode" , subChapterList[[i]][[t]]) ){
          
          temp[[j]] <-paste(temp[[j]],subChapterList[[i]][[t]],"\n", sep="")
          names(temp[[j]]) <- "HTML"
        }else{
          j <- j + 1
          temp[[ j ]] <-subChapterList[[i]][[t]]
          names(temp[[j]]) <- "R"
          j <- j + 1
        }
        
      }
      jsonList[[i]] <- temp
      jsonList[[i]]<- jsonList[[i]][!unlist(lapply(jsonList[[i]], is.null))]
      
    }
    
  }
}


temp <- vector(mode = "list",length= 70)  

mergeAndSort <- function(i){
  if( length(jsonList[[i]]) != 0 ){
    temp <- vector(mode = "list",length= 70)  
    j <- 1
    print(paste("this is BEGINNING and i is:",i))
    
    for(t in 1:length(jsonList[[i]])) {
      if(!grepl( "sourceCode r" , jsonList[[i]][[t]]) ){
        print(paste("this is html chunk and i is:",i,", t is:", t))
        temp[[j]] <-paste(temp[[j]],jsonList[[i]][[t]],"\n", sep="")
        names(temp[[j]]) <- "HTML"
      }else{
        print(paste("this is sourceCode chunk and i is:",i,", t is:", t))
        j <- j + 1
        temp[[ j ]] <- jsonList[[i]][[t]]
        names(temp[[j]]) <- "R"
        j <- j + 1
      }
    }
  }else{
    print("this functions only works for subchapters")  
  }  
  temp
}

for( i in 1:length(jsonList) ){
  
  jsonList[[i]] <- mergeAndSort(i)
  jsonList[[i]] <- jsonList[[i]][!unlist(lapply(jsonList[[i]], is.null))]
}


