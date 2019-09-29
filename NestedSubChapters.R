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
for(i in 1:length(jsonList)){
  for(j in 1:length(jsonList[[i]])){
    if(chapterURLS[i,3] == "SubSubChapter"){
      print(paste("i is :" , i , "  j is ", j, sep= ""))
      pattern <- jsonList[[i]][[j]]
      for(z in 1:length(jsonList)){
        for(m in 1:length(jsonList[[z]])){
          if(chapterURLS[z,3] == "SubChapter"){
            replace <- ""
            jsonList[[z]][[m]] <- str_replace_all(jsonList[[z]][[m]],fixed(pattern),replace)
          }
        }
      }
      }
    }
  
}
    
# 
# pattern <- "aaaa"
# replace <- "This is DUPLICATED"
# test <- list("XXXXXXXXX")



