#scraping the links for available books
library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)

#Getting all href links in the li element.
url <- "https://r4ds.had.co.nz"

#This function scraps all chapter url and  subchapter urls.
chapterLink <- function(){
  rnd <- runif(1,min = 32,max=74)
  print(paste("system will sleep " , rnd, " seconds"))
  Sys.sleep(rnd)
  page <- read_html(url)
  nodes <- html_nodes(page,'li.chapter a')
  paste(url,"/",html_attr(nodes,"href"),sep="")
}


#saving href link as data frame
chapterURLS <- data.frame(links = chapterLink())
anyNA(chapterURLS)
chapterURLS[,1] <-as.character(chapterURLS[,1])


#creating new column
chapterURLS$ChapterName<- chapterURLS$links


#urlFunc generates url for every part of book.
urlFunc <- function(x){
  page <- read_html(url)
  #parsing the html for h1
  node <- html_node(page,'h1')
  
  html_text(node)
  
}


#we can reach the all chapter names using any of the links
page <- read_html(chapterURLS$links[5])

#getting chapter names
chapterNumbers <- html_text(html_nodes(page,'a'))
chapterNumbers <- chapterNumbers[-1]
chapterURLS$ChapterName <-chapterNumbers[1 : (length(chapterURLS[,1]) )]




#creating new column
chapterURLS$Chapter <- chapterURLS$links


#assigning the chapter urls chapter or subchapter
for(x in 1:length(chapterURLS[,1])){
  ifelse ( !grepl( "#" , chapterURLS[x,1] ),
           chapterURLS[x,3] <-"Chapter" ,
           chapterURLS[x,3] <-"SubChapter" )
}

#check for double dot
#if double dot occurs , this is a subchapter of a subchapter.
for(i in 1:length(chapterURLS[,1])){
  if(chapterURLS[i,3] == "SubChapter" && str_count(substr(chapterURLS[i,2],1,10),"\\.") == 2){
    chapterURLS[i,3] <- "SubSubChapter"
    print(paste(i,". is done"))
  }
  
}

#This function accepts urls and give the outputs as div element of links
parseSubChapterElements <- function(x){
  if( grepl( "#" , chapterURLS[x,1] )){
    chapterURLS[x,1] <- gsub("([+.])","\\\\\\1", chapterURLS[x,1])
    
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

for(a in 1:length(jsonList)){
      print(a)
      names(jsonList)[[a]] <- chapterURLS[a,2]
  
}
