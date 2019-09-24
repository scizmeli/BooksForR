library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)

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
  
  chaptersList[[i]] <-getChapters(i)
  
}
#chaptersList[[5]][[2]]


sortText <- function(x){
  count <- 0
  
subChaptersList <- chaptersList  

for(i in 1:length(subChaptersList)){
  names(subChaptersList)[i] <- chapterURLS[i,2]
}

#we need an empty list for the sorted and seperated data
emptyListCreate <- function(i){
count <- 0    
      for(t in 1:length(chaptersList[[i]])){
            #print(paste("i: ", i , "t: " , t , sep  = " "))
               if(grepl( "sourceCode" , chaptersList[[i]][[t]])){
                 count <- count + 1
                 count
                  }
        
    }
  
  }
}

emptyListCreate(65)
# chaptersList[[164]] <- "EMPTY SUBCHAPTER"
# chaptersList[[165]] <- "EMPTY SUBCHAPTER"
# chaptersList[[60]] <- "EMPTY SUBCHAPTER"



count <- emptyListCreate(15)
temp <- vector(mode = "list",length= count + 2)  
j <- 1
  for(i in 1:length(mylist)) {
    if(!grepl( "sourceCode" , mylist[[i]]) ){
      temp[[j]] <-paste(temp[[j]],mylist[[i]],"\n", sep="")
    }else{
      j <- j + 1
      temp[[ j ]] <- mylist[[i]]
      j <- j + 1
    }
  }
  
  jsonList[x] <- temp
  print(paste(x, " is completed"))
  #chapterURLS[x,7] <- temp
















#creating empty list with desire length
temp <- vector(mode = "list", length = 3)

!is.na(temp[1])
#args(paste)
for(i in 1:length(mylist)){
  if(mylist[[i]]  == "a"){
    
    if(!is.na(temp[i])){
      
      print(paste("I am the first a","  ",j, sep = ""))
      
      
      temp[[j]] <- mylist[[i]]
      
    }else{
      
      
      print( paste("i am in the second if else blog", j ,sep = ))
      
      
      temp[[j]] <- paste(mylist[[i]],mylist[[i - 1]],sep ="")
    }    
    j = j + 1
  }else{
    temp[ j ] <- mylist[[i]]
    print("i am the B", j)
   #jsonList[[i]]
  }
}








# for(nodes in page){
#     print(html_node(page,'#intro-outline' ))
#   }

# 
# for(i in 1:length( OnlyChapter$links )){
# 
#   page <- read_html( OnlyChapter$DirtyText[[i]] )
# 
#   print(is.null(html_nodes(page,'.r')))
#   html_text(html_nodes(page,'.r'))
#   ax <- html_nodes(page,'.r')
#   ax[1]
# }
save.env
