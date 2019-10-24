#scraping the links for available books
library(httr)
library(rvest)
library(jsonlite)
library(dplyr)
library(XML)

#Getting all href links in the li element.
# url <- "https://otexts.com/fpp2"


getBookName <- function(BookUrl){
  page <- read_html(BookUrl)
  nodes <- html_nodes(page,'.title')
  title <- html_text(nodes)
  title <- gsub("([+.])","\\\\\\1", title ) #escaping special characters
  title <- gsub(" ", "", title)
  return(title)
}

bookname <- getBookName(url)

#This function scraps all chapter url and  subchapter urls.
chapterLink <- function(){
  rnd <- runif(1,min = 2,max=4)
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



save.image( paste(file.path(bookname ,"Images"), "/all_book_url",Sys.Date(),".RData",sep ="") )

# new_folder_path <- paste(getwd(),"new_folder",sep = "/")      

