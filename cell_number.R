library(jsonlite)

#Hole book in one JSON
tjson <- jsonlite::fromJSON("input.json",simplifyDataFrame = FALSE)



#this function gives indices of chapters
getChapterIndex <- function(){
  indexNums <<- list()
  for(i in 1:length(jsonList)){
    if(chapterURLS[i,3] == "Chapter"){
      indexNums <<- append(indexNums,i)
    }
  }
  indexNums
}

getChapterIndex()


