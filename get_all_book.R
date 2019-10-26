#!/usr/bin/env Rscript

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
    
    random <- runif(1,min=25,max=75)
    
    cat(paste("This is",chapterURLS[x,3], " extracted\n after ",random," secs",sep = ""))
    
    Sys.sleep(random)

    page <- read_html(chapterURLS[x,1])

    node <- html_node(page, paste("#",parseSubChapterElements(x),sep = ""))

    as(xml_children(node), "character")
    

  }else{

    rnd <- runif(1,min = 28,max=65) #generating random sleep sec for not to be banned by the server

    print(paste(chapterURLS[x,2],"  ","after " , rnd, " seconds"))

    Sys.sleep(rnd)

    cat(paste("This is",chapterURLS[x,3], "extracted\n after ",rnd," secs",sep = ""))

    page <- read_html(chapterURLS[x,1])

    node <- html_node(page, paste("#",parseChapterElements(x),sep = ""))

    as(xml_children(node), "character")
  }
}

# getting chapters text and code
# getChapters <- function(x){
  # if(chapterURLS[x,3] == "Chapter"){
    # print(paste("ChapterName is ", chapterURLS[x,2] , " and  url is: ", chapterURLS[x,1], sep=""))
    # 
    # rnd <- runif(1,min = 3,max=15) #generating random sleep sec for not to be banned by the server
    # 
    # print(paste(chapterURLS[x,2],"  ","after " , rnd, " seconds"))
    # 
    # Sys.sleep(rnd)
    # 
    # print(paste("This ",chapterURLS[x,2], "is a chapter",sep = ""))
    # 
    # page <- read_html(chapterURLS[x,1])
    # 
    # node <- html_node(page, paste("#",parseChapterElements(x),sep = ""))
    # 
    # as(xml_children(node), "character")  
#   }
# }-




# scraping and saving the book data
for(i in 1:length(subChapterList)){
  subChapterList[[i]] <- tryCatch(getSubChapters(i),error = function(e){"NA"})
  
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
