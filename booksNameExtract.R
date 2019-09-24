#scraping the links for available books
library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)

#Getting all href links in the li element.
url <- GET("https://r-pkgs.org")

#This function scraps all chapter url and  subchapter urls.
chapterLink <- function(){
  page <- read_html(url)
  
  Sys.sleep(50)
 
   nodes <- html_nodes(page,'li.chapter a')
  
  paste("https://r-pkgs.org/",html_attr(nodes,"href"),sep="")
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

#Deleting manually duplicated chapter[1:2] == "R packages"
#chapterNumbers[1:2] <- NULL
#233 is the length(ChapterURLS)
chapterURLS$ChapterName <-chapterNumbers[2 : 234]


for(i in 1:length(OnlyChapter$DirtyText)){
  
  page <-read_html(OnlyChapter$DirtyText[[1]])
  html_nodes(page,'#.r')
  html_text(page)
  
  node <- html_node
}

#saving the results 
for(i in 1:length(chapterURLS[,1])){
  chapterURLS[i,2] <- urlFunc(i)
}


#creating new column
chapterURLS$Chapter <- chapterURLS$V2


#assigning the chapter urls chapter or subchapter
for(x in 1:length(chapterURLS[,1])){
  ifelse ( !grepl( "#" , chapterURLS[x,1] ),
           chapterURLS[x,3] <-"Chapter" ,
           chapterURLS[x,3] <-"SubChapter" )
}


#This function accepts urls and give the outputs as div element of links
parseSubChapterElements <- function(x){
  if( grepl( "#" , chapterURLS[x,1] )){
    
    y <- regexpr( "\\#.*" , chapterURLS[8,1] )

        div <- regmatches( chapterURLS[8,1],y )
    #page <- read_html(chapterURLS[8,1])
    #print("some sleep" , Sys.sleep(8))
    #node <- html_node(page, div)
    
    
    if(is.null(grepl("sourceCode r", node)))    
      #read_html(page,paste())
  }else{
    warning("This url is not subchapter")
  }
}
#This function accepts urls and give the outputs as div element of links 
parseChapterElements <- function(x){
  if( !grepl( "#" , chapterURLS[x,1] )){
    y <- gsub("https://r-pkgs.org/","",chapterURLS[x,1])
    div <- gsub(".html","",y)
    
    
  }else{
    warning("This url is  not chapter")
  }
}


#Subsetting only chapters for after use if needed.
OnlyChapter<-chapterURLS[chapterURLS$V3 == "Chapter",]
OnlyChapter$Text <- OnlyChapter$links


#Parsing all chapters texts(both text and code)
getChapterText <- function(x){
 
  url <- GET(OnlyChapter[x,1])
  
  Sys.sleep(55)
  
  page <- read_html(url)
  
  node <- html_node(page,'#section-')
  
  cleanText <- html_text(node)
  
  cleanText
}



for(x in 1:length(OnlyChapter[,1])){
  OnlyChapter[x,4] <- getChapterText(x)
  #  OnlyChapter[x,5] <- getDirtyText(x)
}








#Creating new column for all chapters dirty html texts
OnlyChapter$DirtyText <- OnlyChapter$ChapterName
getDirtyText <- function(x){
  url <- GET(OnlyChapter[x,1])
  
  Sys.sleep(30)
  
  page <- read_html(url)
  
  node <- html_node(page,'#section-')
  
  node
}
for(x in 1:length(OnlyChapter[,1])){
  
  OnlyChapter[x,5] <- as.character(getDirtyText(x))
  
}


#Searching for pattern
x <- "aasd"
y <- "s"
grepl(y,x)


save.image(file="subchaptersAvailable")


