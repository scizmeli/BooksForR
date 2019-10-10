library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)
#subsubChapterList contains mess unsorted data.(only subchapters)

#tempList contains jsonLists + Chapters 

#chapterLists is the final list.(text and code sorted/merged.)

#jsonLists containts clean code(only code and only comments)

#creating name of div elements for each subchapter


#first create an empty list for store the subchapters data
subChapterList<- vector(mode ="list", length = length(chapterURLS[,1]))

parseSubChapterElements <- function(x){
  if( grepl( "#" , chapterURLS[x,1] )){
    
    y <- regexpr( "(?<=#).*" , chapterURLS[x,1] , perl = TRUE)
    
    div <- regmatches( chapterURLS[x,1],y )
    #page <- read_html(chapterURLS[8,1])
    #print("some sleep" , Sys.sleep(8))
    #node <- html_node(page, div)
    return(div)
    
    
    #read_html(page,paste())
  }else{
    warning("This url is not subchapter")
  }
}

#getting subchapters text and code
getSubChapters <- function(x){
  if(chapterURLS[x,3] != "Chapter"){
    
    random <- runif(1,min=15,max=65)
    
    print(paste("Sleeping time is:", " ",random, "seconds" , sep = ""))
    
    Sys.sleep(random)
    
     page <- read_html(chapterURLS[x,1])
     
     node <- html_node(page, paste("#",parseSubChapterElements(x),sep = ""))
     
     as(xml_children(node), "character")
    
        # a function that returns NA regardless of what it's passed
      
  }else{
    
    mylist <- "This is a chapter."
    
    mylist
  }
}


# scraping and saving the subchapters data
for(i in 1:length(chapterURLS[,1])){

  subChapterList[[i]] <- tryCatch(getSubChapters(i),error = function(e){NA})

}


html_text( subChapterList[[3]] )

#subChapterList contains unsorted , mess data
subChapterList <- subsubChapterList
#There are some  empty ( list character(0) )
# subChapterList[[164]] <- "EMPTY SUBCHAPTER"
# subChapterList[[165]] <- "EMPTY SUBCHAPTER"
# subChapterList[[60]] <- "EMPTY SUBCHAPTER"
# 


mergeAndSortSubChapters <- function(i){
  if(subChapterList[[i]] != subChapterList[[1]] || subChapterList[[i]] != subChapterList[[60]]){
    temp <- vector(mode = "list",length= 20)  
    j <- 1
    for(t in 1:length(subChapterList[[i]])) {
      if(!grepl( "sourceCode" , subChapterList[[i]][[t]]) ){
        
        temp[[j]] <-paste(temp[[j]],subChapterList[[i]][[t]],"\n", sep="")
        names(temp[[j]]) <- "HTML"
      }else{
        j <- j + 1
        temp[[ j ]] <- subChapterList[[i]][[t]]
        names(temp[[j]]) <- "R"
        j <- j + 1
      }
    }
  }else{
    print("this functions only works for subchapters")  
  }  
  temp
}
#saving the sorted results
for(i in 1:length(subChapterList)){
  tryCatch(subChapterList[[i]] <- mergeAndSortSubChapters(i))
  subChapterList[[i]] <- subChapterList[[i]][!unlist(lapply(subChapterList[[i]], is.null))]
}


#deleting null elements.
for(i in 1:length(jsonList)){
  subChapterList[[i]] <- subChapterList[[i]][!unlist(lapply(subChapterList[[i]], is.null))]
}









#Removing the html tags from code parts
for(i in 1:length(jsonList)){
  for(t in 1:length(jsonList[[i]])){
    if(grepl( "sourceCode" , jsonList[[i]][[t]]) ){
      jsonList[[i]][[t]] <-html_text(read_html(jsonList[[i]][[t]]))
      
      
    }else{
      print(paste("There is no code in subchapter","   ", i,".","t"))
    }
  }
}



