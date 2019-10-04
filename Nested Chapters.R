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

for(i in 3:length(jsonList)){
  if(chapterURLS[i,3] == "Chapter"){
    print("yeh i am chapter")
    chr <- tempList[[i]][[1]]
    jsonList[[i]][[1]] <- ""
    for(z in 1:length(jsonList[[i]])){
      temp <- vector(mode = "list",length= 20)
      j <- 1
      for(t in 1:length(chr[[1]])){
        if(grepl(paste("<div id=", '\"', parseSubChapterElements(i+1),'\"',sep=""),chr[[1]][[t]])){
          print(paste("j is " , j, "and break" ))
          break()
          
        }else if(!grepl( "sourceCode" ,chr[[1]][[t]])){
          temp[[j]] <-paste(temp[[j]],chr[[1]][[t]],"\n", sep="")
          names(temp[[j]]) <- "HTML"
        }else{
          j <- j + 1
          temp [[ j ]] <- chr[[1]][[t]]
          names(temp[[j]]) <- "R"
          j <- j + 1
        }
      
        }
        jsonList[[i]] <- temp
        jsonList[[i]]<- jsonList[[i]][!unlist(lapply(jsonList[[i]], is.null))]
        
        }  

    }
}


#clean comments





#clean comments for subchapter which has subchapters
for(a in 3:length(jsonList)){
  for(b in 1:length(jsonList[[a]])){
    if(chapterURLS[a,3] == "Chapter"){
      if(names(jsonList[[a]][[b]]) == "R" && grepl("sourceCode r",jsonList[[a]][[b]])){
        
        print(paste("a is:" , a , "  b is ", b))
        page <- read_html(jsonList[[a]][[b]])
        
        node <- html_nodes(page,'.sourceLine') 
        
        #create an empty character list for converted nodes
        code <-vector(mode="character", length = length(as(node,"character")))
        
        #Convert nodes as character
        for (i in 1:length(as(node,"character"))){
          code[[i]] <- strsplit(as(node, "character"), "\n")[[i]]
        }
        
        
        #removing comment outputs
        for(j in 1:length(code)){
          
          if(grepl("#",html_text(read_html(code[[j]]))) && grepl("#>",html_text(read_html(code[[j]])))){
            print("This is a comment")
            code[[j]] <- NA
            print("line is deleted")
            
          }else{
            print("this is not line")
          }
        }
        
        
        #remove NA's
        code <- code[!unlist(lapply(code, is.na))]
        
        jsonList[[a]][[b]] <- ""
        #remove html tags
        for(i in 1:length(code)){
          code[[i]] <- paste(html_text(read_html(code[[i]])),"\n",sep="")
          jsonList[[a]][[b]]<- paste(jsonList[[a]][[b]],code[[i]])
          names(jsonList[[a]][[b]]) <- "R"
        }
        
        
        
        
      }else{
        print(paste("this is not a chapter","and i is:",i,"a and b is:   ", a, "and", b))
      }
    }
  }
}







#save.image()
