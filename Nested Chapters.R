library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)

for(i in 3:length( chapterURLS[,1])){
  if(chapterURLS[[i,3]] == "Chapter" && tempList[[i]][[1]] == "This is a chapter.\n" ){
     print(paste("i is ", i , " and  url is: ", chapterURLS[i,1], " \n the json is " ,tempList[[i]][[1]]))
    rnd <- runif(1,min = 32,max=54)
    print(paste("system will sleep " , rnd, " seconds"))
    Sys.sleep(rnd)

    print(paste("This ",chapterURLS[[i,2]], "is a chapter",sep = ""))

    page <- read_html(chapterURLS[i,1])



    node <- html_node(page, paste("#",parseChapterElements(i),sep = ""))

    chr <- strsplit(as(node, "character"), "\n")

   
    tempList[[i]][[1]] <- node
    # for(j in 1:length(chr[[1]])){
    #   if(grepl(parseSubChapterElements(i+1),chr[[1]][[i]])){
    #     break()
    # 
    #   }else{
    #     jsonList[[i]][[1]] <- paste( jsonList[[i]][[1]], chr[[1]][[j]] )
    #     }
    # }


    }
}

for(i in 3:length(jsonList)){
  if(chapterURLS[i,3] == "Chapter"){
    print(paste("This is the begining i is :" ,i ))
     chr <- strsplit(as(tempList[[i]][[1]], "character"), "\n")
     jsonList[[i]][[1]] <- ""
     for(j in 1:length(chr[[1]])){
       if(grepl(parseSubChapterElements(i+1),chr[[1]][[j]])){
          print(paste("j is " , j, "and break" ))
         break()
  
       }else{

         jsonList[[i]][[1]] <- paste( jsonList[[i]][[1]], chr[[1]][[j]] )
       }
     }


  }
}

save.image()