library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)
#subChaptersList contains mess unsorted data.(only subchapters)

#tempList contains jsonLists + Chapters 

#chapterLists is the final list.(text and code sorted/merged.)

#jsonLists containts clean code(only code and only comments)

#creating name of div elements for each subchapter
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


#scraping and saving the subchapters data
# for(i in 10:length(chapterURLS[,1])){
#   
#   # chaptersList[[i]] <-getChapters(i)
#   
# }


#subChapterList contains unsorted , mess data
chaptersList <- subChaptersList
#There are some  empty ( list character(0) )
chaptersList[[164]] <- "EMPTY SUBCHAPTER"
chaptersList[[165]] <- "EMPTY SUBCHAPTER"
chaptersList[[60]] <- "EMPTY SUBCHAPTER"



mergeAndSortSubChapters <- function(i){
  if(chaptersList[[i]] != chaptersList[[1]] || chaptersList[[i]] != chaptersList[[60]]){
    temp <- vector(mode = "list",length= 20)  
    j <- 1
    for(t in 1:length(chaptersList[[i]])) {
      if(!grepl( "sourceCode" , chaptersList[[i]][[t]]) ){
        
        temp[[j]] <-paste(temp[[j]],chaptersList[[i]][[t]],"\n", sep="")
        names(temp[[j]]) <- "HTML"
      }else{
        j <- j + 1
        temp[[ j ]] <- chaptersList[[i]][[t]]
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
for(i in 1:length(chaptersList)){
  tryCatch(chaptersList[[i]] <- mergeAndSortSubChapters(i))
  chaptersList[[i]] <- chaptersList[[i]][!unlist(lapply(chaptersList[[i]], is.null))]
}


#deleting null elements.
for(i in 1:length(jsonList)){
  chaptersList[[i]] <- chaptersList[[i]][!unlist(lapply(chaptersList[[i]], is.null))]
}









#Removing the html tags from code parts
# for(i in 1:length(jsonList)){
#   for(t in 1:length(jsonList[[i]])){
#     if(grepl( "sourceCode" , jsonList[[i]][[t]]) ){
#       jsonList[[i]][[t]] <-html_text(read_html(jsonList[[i]][[t]]))
#       
#       
#     }else{
#       print(paste("There is no code in subchapter","   ", i,".","t"))
#     }
#   }
# }



#namecheck
namecheck <- function(jsonList){
if(class(jsonList) == "list" ){
  for(i in 1:length(jsonList)){
    for(t in 1:length(jsonList[[i]])){
      if(is.null(names(jsonList[[i]][[t]]))){
        print(paste("i:",i,"  t:",t,"  is no names"))
  
            }
    
      }
    

    }

}else{
    print("This is not list")
  }

  }
