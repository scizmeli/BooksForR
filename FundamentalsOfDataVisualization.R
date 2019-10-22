#! /usr/bin/env RScript


#scraping the links for available books
library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)

#Getting all href links in the li element.
url <- "https://serialmentor.com/dataviz"

#This function scraps all chapter url and  subchapter urls.
chapterLink <- function(){
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
  if(chapterURLS[x,3] == "asdChapter"){
    
    random <- runif(1,min=15,max=65)
    
    print(paste("Sleeping time is:", " ",random, "seconds" , sep = ""))
    
    Sys.sleep(random)
    
    page <- read_html(chapterURLS[x,1])
    
    node <- html_node(page, paste("#",parseSubChapterElements(x),sep = ""))
    

    print(paste(x,".","Subchapter succesfully downloaded into SubChapterList")) 
    # a function that returns NA regardless of what it's passed
    return(as(xml_children(node), "character"))
  }else if (chapterURLS[x,3] == "Chapter"){
	

    
      rnd <- runif(1,min = 5,max=30)
      print(paste("system will sleep " , rnd, " seconds"))
      Sys.sleep(rnd)
      
      print(paste("This ",chapterURLS[[i,2]], "is a chapter",sep = ""))
      
      page <- read_html(chapterURLS[i,1])
      
      node <- html_node(page, paste("#",parseChapterElements(i),sep = ""))
      return(as(node, "character")
      )    
  }
}


# scraping and saving the subchapters data
for(i in 1:length(chapterURLS[,1])){
  
  subChapterList[[i]] <- tryCatch(getSubChapters(i),error = function(e){NA})
  
}

save.image("fundementals.RData")


temp <-""
for(i in 2:length(subChapterList)){
  if(chapterURLS[i,3] == "Chapter" && is.list(subChapterList[[i]])){
    temp <- subChapterList[[i]][[1]]
    print(i)
    subChapterList[[i]] <- "EM"
    # subChapterList[[i]] <- ""
    subChapterList[[i]] <- temp
    
  }

temp <- ""  

}
