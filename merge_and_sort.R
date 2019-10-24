#subChapterList contains unsorted , mess data
temp <- vector(mode = "list",length= 30)  


mergeAndSortSubChapters <- function(i){
  if( chapterURLS[i,3] != "Chapter"){
      temp <- vector(mode = "list",length= 30)  
    j <- 1
    print(paste("this is BEGINNING and i is:",i))
    
    for(t in 1:length(subChapterList[[i]])) {
      if(!grepl( "sourceCode r" , subChapterList[[i]][[t]]) ){
        print(paste("this is html chunk and i is:",i,", t is:", t))
        temp[[j]] <-paste(temp[[j]],subChapterList[[i]][[t]],"\n", sep="")
        names(temp[[j]]) <- "HTML"
      }else{
        print(paste("this is sourceCode chunk and i is:",i,", t is:", t))
        j <- j + 1
        temp[[ j ]] <- subChapterList[[i]][[t]]
        names(temp[[j]]) <- "R"
        j <- j + 1
      }
    }
  }else{
    print("this functions only works for subchapters")  
  }  
  temp
}


#saving the sorted results
for( i in 3:length(subChapterList) ){
  subChapterList[[i]] <- mergeAndSortSubChapters(i)
  subChapterList[[i]] <- subChapterList[[i]][!unlist(lapply(subChapterList[[i]], is.null))]
}


