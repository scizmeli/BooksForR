#check for double dot
#if double dot occurs , this is a subchapter of a subchapter.
for(i in 1:length(chapterURLS[,1])){
  if(chapterURLS[i,3] == "SubChapter" && str_count(substr(chapterURLS[i,2],1,10),"\\.") == 2){
    chapterURLS[i,3] <- "SubSubChapter"
    print(paste(i,". is done"))
    }

}
 
#remove duplicates (eg: Sub chapters contains subsubchapters, 
#2.8 contains 2.8.1 and 2.8.2,
#so 2.8.1 chapter occurs 2 times.)
# jsonList <- subChapterList
for(i in 3:(length(jsonList)-1)){
  if(chapterURLS[i,3] == "SubChapter" || chapterURLS[i + 1,3] == "SubSubChapter"){
    print(paste("Subchapters which have subchapters:  " , i ,"  ."))
    chr <- strsplit(subChapterList[[i]] , "\n")
    jsonList[[i]] <- ""
    for(z in 1:length(subChapterList[[i]])){
        temp <- vector(mode = "list",length= 30)
        j <- 1
        for(t in 1:length(chr)) {
          if(grepl(paste("<div id=", '\"', parseSubChapterElements(i+1),'\"',sep=""),chr[[t]])){
            print(paste("j is " , z, "and break" ))
            break()
          }
          else if(!grepl( "sourceCode" , chr[[t]]) ){

            temp[[j]] <-paste(temp[[j]],chr[[t]],"\n", sep="")
            names(temp[[j]]) <- "HTML"
          }else{
            j <- j + 1
            temp[[ j ]] <-chr[[t]]
            names(temp[[j]]) <- "R"
            j <- j + 1
          }
        
          }
        jsonList[[i]] <- temp
        jsonList[[i]]<- jsonList[[i]][!unlist(lapply(jsonList[[i]], is.null))]
      
    }

  }
}









