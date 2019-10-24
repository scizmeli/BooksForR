library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)


#first create an empty list for store the subchapters data
subChapterList<- vector(mode ="list", length = length(chapterURLS[,1]))

#This function accepts urls and give the outputs as div element of links
parseSubChapterElements <- function(x){
  if( grepl( "#" , chapterURLS[x,1] )){
    
    chapterURLS[x,1] <- gsub("([+.])","\\\\\\1", chapterURLS[x,1]) #escaping special characters
    
    y <- regexpr( "(?<=#).*" , chapterURLS[x,1] , perl = TRUE)
    
    div <- regmatches( chapterURLS[x,1],y ) #getting the div names

    return(div)
    
    
    #read_html(page,paste())
  }else{
    warning("This url is not subchapter")
  }
}

#This function accepts urls and give the outputs as div element of links 
parseChapterElements <- function(x){
  if( !grepl( "#" , chapterURLS[x,1] )){
    y <- gsub( paste(url,"/",sep="") , "" , chapterURLS[x,1] )
    div <- gsub(".html","",y)
    div <- gsub("([+.])","\\\\\\1", div)
    
    return(div)
    
  }else{
    warning("This url is  not chapter")
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
    

  }
}

#getting chapters text and code
getChapters <- function(x){
  print(paste("i is ", i , " and  url is: ", chapterURLS[i,1], " \n the json is "))
  
  rnd <- runif(1,min = 35,max=124) #generating random sleep sec for not to be banned by the server
  
  print(paste("system will sleep " , rnd, " seconds"))
  
  Sys.sleep(rnd)
  
  print(paste("This ",chapterURLS[[i,2]], "is a chapter",sep = ""))
  
  page <- read_html(chapterURLS[i,1])
  
  node <- html_node(page, paste("#",parseChapterElements(i),sep = ""))
  
  as(xml_children(node), "character")  
}-




# scraping and saving the book data
for(i in 1:length(chapterURLS[,1])){
  
  subChapterList[[i]] <- tryCatch(getSubChapter(i),error = function(e){"NA"})
  
  subChapterList[[i]] <- tryCatch(getChapters(i),error = function(e){"NA"})
  
}




if(!dir.exists ( file.path(bookname))){
  dir.create( file.path(bookname) )
  cat("Directory created")
}else{
  cat("Directory exist")
}


if(!dir.exists ( file.path(bookname,"Images"))){
  
  dir.create( file.path(bookname,"Images") )
  cat("Directory created")
}else{
  cat("Directory exist")
}



save.image( paste(file.path(getBookName(url),"Images"), "/all_book",Sys.Date(),".RData" , sep ="") )
