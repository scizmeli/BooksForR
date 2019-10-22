#This script scrap the data in chapter part. 
#Because the chapters contains all of the subchapters.

library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)



#this loops scrapes the chapters and stores in tempList
for(i in 3:length(subChapterList)){ 
   if(chapterURLS[[i,3]] == "Chapter" ){
      print(paste("i is ", i , " and  url is: ", chapterURLS[i,1], " \n the json is "))
      rnd <- runif(1,min = 35,max=54)
      print(paste("system will sleep " , rnd, " seconds"))
      Sys.sleep(rnd)
      
      print(paste("This ",chapterURLS[[i,2]], "is a chapter",sep = ""))
      page <- read_html(chapterURLS[i,1])
      node <- html_node(page, paste("#",parseChapterElements(i),sep = ""))
      chr <- as(node, "character")
      
      
      subChapterList[[i]] <- chr
      
      
    }
  }

  
  for(i in 3: length(subChapterList) ){

    subChapterList[[i]] <- tryCatch(completeBook(i) , error = function(e){NA} )
}


jsonList <- subChapterList
#this loops seperate the chapter from subchapters
for(i in 3: (length(jsonList) - 1)){
  if(chapterURLS[i,3] == "Chapter"){
    print(paste("This is the begining i is :" ,i ))
     chr <- strsplit(subChapterList[[i]] , "\n")
     jsonList[[i]] <- ""
     for(z in 1:length( jsonList[[i]] )){
       temp <- vector(mode = "list",length= 20)
       j <- 1
        for(t in 1:length(chr[[1]])){
          if(chapterURLS[i + 1, 3] != "Chapter"){
            print(paste("the next is NOTT chapter and i is:", i))
            if( grepl(paste("<div id=", '\"', parseSubChapterElements(i+1),'\"',sep=""),chr[[1]][[t]]) ){
              print(paste("j is " , j, "and break" ))
              break()
              
            }else if(!grepl( "sourceCode" , chr[[1]][[t]]) ){
              
              temp[[j]] <-paste(temp[[j]],chr[[1]][[t]],"\n", sep="")
              names(temp[[j]]) <- "HTML"
            }else{
              j <- j + 1
              temp[[ j ]] <-chr[[1]][[t]]
              names(temp[[j]]) <- "R"
              j <- j + 1
              
            }
          }else if (chapterURLS[i + 1, 3] == "Chapter"){
            print(paste("the next is chapter and i is:", i))
            if( grepl(paste("<div id=", '\"', parseChapterElements(i+1),'\"',sep=""),chr[[1]][[t]]) ){
              print(paste("j is " , j, "and break" ))
              break()
              
            }else if(!grepl( "sourceCode r" , chr[[1]][[t]]) ){
              
              temp[[j]] <-paste(temp[[j]],chr[[1]][[t]],"\n", sep="")
              names(temp[[j]]) <- "HTML"
            }else{
              j <- j + 1
              temp[[ j ]] <-chr[[1]][[t]]
              names(temp[[j]]) <- "R"
              j <- j + 1
              
            }
          }
        }
    
     }
   jsonList[[i]] <- temp
   jsonList[[i]]<- jsonList[[i]][!unlist(lapply(jsonList[[i]], is.null))]


  }
}

#save.image()