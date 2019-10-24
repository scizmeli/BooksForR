temp <- vector(mode = "list",length= 30)

#creating list to export as
jsonList <- subChapterList

#this loops seperate the chapter from subchapters
for(i in 3: (length(jsonList) - 1)){
  
  if(chapterURLS[i,3] == "Chapter"){
    
    print(paste("This is the begining i is :" ,i ))
    
    chr <- strsplit(subChapterList[[i]] , "\n")
    
    jsonList[[i]] <- ""
    
    temp <- vector(mode = "list",length= 20)
    j <- 1
    
    for(t in 1:length(chr)){
      
      if( chapterURLS[i + 1, 3] != "Chapter" && length(chr[[t]]) != 0 ){
        print(paste("the next is NOTT chapter and i is:", i))
        if( grepl(paste("<div id=", '\"', parseSubChapterElements(i+1),'\"',sep=""),chr[[t]]) ){
          break()
          print(paste("j is " , j, "and break" ))
          
        }else{
          
          temp[[j]] <-paste(temp[[j]],chr[[t]],"\n", sep="")
          names(temp[[j]]) <- "HTML"
        }
      }else if (chapterURLS[i + 1, 3] == "Chapter" && length(chr[[t]]) != 0){
        print(paste("the next is chapter and i is:", i))
        if( grepl(paste("<div id=", '\"', parseChapterElements(i+1),'\"',sep=""),chr[[t]])  && length(chr[[t]]) != 0){
          print(paste("j is " , j, "and break" ))
          break()
          
        }else{
          
          temp[[j]] <-paste(temp[[j]],chr[[t]],"\n", sep="")
          names(temp[[j]]) <- "HTML"
        }
      }
    }
    
    
    jsonList[[i]] <- temp
    jsonList[[i]]<- jsonList[[i]][!unlist(lapply(jsonList[[i]], is.null))]
    
    
  }
}



#seperatings subchapters from subsubchapter
for(i in 3:(length(jsonList)) ){
  if( i != length(jsonList)){
    if(chapterURLS[i,3] == "SubChapter" && chapterURLS[i + 1,3] == "SubSubChapter"){
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
  
}


