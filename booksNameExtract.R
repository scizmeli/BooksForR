#scraping the links for available books
library(httr)
library(rvest)
library(tidyverse)
library(dplyr)


#Getting all href links in the li element.
url <- GET("https://r-pkgs.org")

#This function scraps all chapter url and all subchapter urls.
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
    #chapterURLS[x,2] <- cleanText
}




#saving the results 
for(i in 1:length(chapterURLS[,1])){
  chapterURLS[i,2] <- urlFunc(i)
}


#creating new column
chapterURLS$Chapter <- chapterURLS$V2
for(x in 1:length(chapterURLS[,1])){
  ifelse ( !grepl( "#" , chapterURLS[x,1] ),
           chapterURLS[x,3] <-"Chapter" ,
           chapterURLS[x,3] <-"SubChapter" )
}



read_html(chapterURLS[x,1])


#This function accepts urls and give the outputs as div element of links
parseSubChapterElements <- function(x){
  if( grepl( "#" , chapterURLS[x,1] )){
    y <- regexpr( "\\#.*" , chapterURLS[x,1] )
    regmatches( chapterURLS[x,1],y )
    #read_html(page,paste())
  }else{
    warning("This url is not subchapter")
  }
}



#This function accepts urls and give the outputs as div element of links 
parseChapterElements <- function(x){
  if( !grepl( "#" , chapterURLS[x,1] )){
    y <- gsub("https://r-pkgs.org/","",chapterURLS[x,1])
    y <- gsub(".html","",y)
    y
  }else{
    warning("This url is  not chapter")
  }
}




# #Subsetting only chapters 
# OnlyChapter<-chapterURLS[chapterURLS$V3 == "Chapter",]
# OnlyChapter$Text <- OnlyChapter$links
# 
# getChapterText <- function(x){
#   url <- GET(OnlyChapter[x,1])
#   Sys.sleep(55)
#   page <- read_html(url)
#   node <- html_node(page,'#section-')
#   cleanText <- html_text(node)
#   cleanText
# }
# 
# 
# 
# 
# for(x in 1:length(OnlyChapter[,1])){
#   OnlyChapter[x,4] <- getChapterText(x)
# #  OnlyChapter[x,5] <- getDirtyText(x)
# }
# 



# xyz <- function(x){
#   ort <- x+1
#   lolo<- x+5
#   return(data.frame("ort"=ort,
#                     "lol"=lolo))
# }
# 
# 
# for(i in 1:5){
#   xyz <- xyz(i)
# }

#Creating new column for 
# OnlyChapter$DirtyText <- OnlyChapter$ChapterName


# getDirtyText <- function(x){
#   url <- GET(OnlyChapter[x,1])
#   Sys.sleep(30)
#   page <- read_html(url)
#   node <- html_node(page,'#section-')
#   node
#   #cleanText <- html_text(node)
#   #cleanText
#   }
















# for(x in 1:length(OnlyChapter[,1])){
# 
#   OnlyChapter[x,5] <- as.character(getDirtyText(x))
#   
# }
# 






#Searching for pattern 
# x <- "aasd"
# y <- "s"
# grepl(y,x)



save.image(file="environment")
