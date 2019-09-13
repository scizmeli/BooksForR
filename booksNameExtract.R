#scraping the links for available books
library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)





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




# 
url <- GET(chapterURLS[3,1])
Sys.sleep(3)
page <- read_html(url)
node <- html_node(page,'#section-')

cleanText <- html_text(node)
node <-html_nodes(page,'p')
html_text(node)
a <- html_text(node)
chapterURLS[1,2] <- cleanText





#Subsetting only chapters 
OnlyChapter<-chapterURLS[chapterURLS$V3 == "Chapter",]
OnlyChapter$Text <- OnlyChapter$links


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
OnlyChapter$DirtyText <- OnlyChapter$ChapterName


getDirtyText <- function(x){
  url <- GET(OnlyChapter[x,1])
  Sys.sleep(30)
  page <- read_html(url)
  node <- html_node(page,'#section-')
  node

  
  
  #cleanText <- html_text(node)
  #cleanText
  }

x <- data.frame(a = c(1,2,3,4,5,6,7,8),
                b = c(1,2,3,4,5,6,7,8),
                c = c(1,2,3,4,5,6,7,8))


# for(i in 1:length(x)){
#   if(length(node) %% 2 == 1 ){
#     print(paste(node[i] ,"\n",node[i+1]))
#   i = i + 2
#   }else{
#     i = i + 1
#   }
# }














for(x in 1:length(OnlyChapter[,1])){

  OnlyChapter[x,5] <- as.character(getDirtyText(x))
  
}





write.csv
write.csv(OnlyChapter, file = "rPackages",sep=";",fileEncoding = "UTF-8")


#Searching for pattern 
# x <- "aasd"
# y <- "s"
# grepl(y,x)




