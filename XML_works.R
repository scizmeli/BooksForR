library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)
#chapterLists is the final list.(text and code sorted/merged.)


#creating name of div elements for each subchapter
parseSubChapterElements <- function(x){
  if( grepl( "#" , chapterURLS[x,1] )){
    y <- regexpr( "\\#.*" , chapterURLS[x,1] )
    regmatches( chapterURLS[x,1],y )
    #read_html(page,paste())
  }else{
    warning("This url is not subchapter")
  }
}

#getting subchapters text and code
getChapters <- function(x){
  if(chapterURLS[x,3] == "SubChapter"){
    random <- runif(1,min=25,max=55)
    print(paste("Sleeping time is:", " ",random, "seconds" , sep = ""))
    Sys.sleep(random)
    
    page <- read_html(chapterURLS[x,1])
    node <- html_nodes(page, parseSubChapterElements(x))
    as.character(xml_children(node))
    
  }else{
    mylist <- "This is a chapter."
    mylist
  }
}

#creating list for store the subchapters
chaptersList <- vector(mode = "list", length = length(chapterURLS[,1]))

#scraping and saving the subchapters data
for(i in 10:length(chapterURLS[,1])){
  
  # chaptersList[[i]] <-getChapters(i)
  
}
#chaptersList[[5]][[2]]
chaptersList[[8]][[2]]

sortText <- function(x){
  count <- 0
  
  subChaptersList <- chaptersList  
  
  for(i in 1:length(chaptersList)){
    names(chaptersList)[i] <- chapterURLS[i,2]
  }
  
  #we need an empty list for the sorted and seperated data
  emptyListCounter <- function(i){
    count <- 0    
    for(t in 1:length(chaptersList[[i]])){
      #print(paste("i: ", i , "t: " , t , sep  = " "))
      if(grepl( "sourceCode" , chaptersList[[i]][[t]])){
        count <- count + 1
        numeric(count)
      }
      
    }
    count
  }
}


# chaptersList[[164]] <- "EMPTY SUBCHAPTER"
# chaptersList[[165]] <- "EMPTY SUBCHAPTER"
# chaptersList[[60]] <- "EMPTY SUBCHAPTER"
# 


mergeAndSortSubChapters <- function(i){
  if(chaptersList[[i]] != chaptersList[[1]] || chaptersList[[i]] != chaptersList[[60]]){
    count <- emptyListCounter(i)
    temp <- vector(mode = "list",length= 20)  
    j <- 1
    for(t in 1:length(chaptersList[[i]])) {
      if(!grepl( "sourceCode" , chaptersList[[i]][[t]]) ){
        temp[[j]] <-paste(temp[[j]],chaptersList[[i]][[t]],"\n", sep="")
      }else{
        j <- j + 1
        temp[[ j ]] <- chaptersList[[i]][[t]]
        j <- j + 1
      }
    }
  }else{
    print("this functions only works for subchapters")  
  }  
  temp
}
#saving the sorted results
for(i in 1:length(chaptersList)){
  tryCatch(chaptersList[[i]] <- mergeAndSortSubChapters(i))
}

#deleting null elements.
for(i in 1:length(jsonList)){
  chaptersList[[i]] <- chaptersList[[i]][!unlist(lapply(chaptersList[[i]], is.null))]
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



