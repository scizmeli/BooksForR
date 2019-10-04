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

for(i in 3:(length(jsonList)-1)){
  if(chapterURLS[i,3] == "SubChapter" && chapterURLS[i + 1,3] == "SubSubChapter"){
    print(paste("Subchapters which have subchapters:  " , i ,"  ."))


    jsonList[[i]] <- ""
    for(z in 1:length(subChaptersList[[i]])){
        temp <- vector(mode = "list",length= 20)
        j <- 1
        for(t in 1:length(subChaptersList[[i]])) {
          if(grepl(paste("<div id=", '\"', parseSubChapterElements(i+1),'\"',sep=""),subChaptersList[[i]][[t]])){
            print(paste("j is " , z, "and break" ))
            break()
          }
          else if(!grepl( "sourceCode" , subChaptersList[[i]][[t]]) ){

            temp[[j]] <-paste(temp[[j]],subChaptersList[[i]][[t]],"\n", sep="")
            names(temp[[j]]) <- "HTML"
          }else{
            j <- j + 1
            temp[[ j ]] <-subChaptersList[[i]][[t]]
            names(temp[[j]]) <- "R"
            j <- j + 1
          }
        
          }
        jsonList[[i]] <- temp
        jsonList[[i]]<- jsonList[[i]][!unlist(lapply(jsonList[[i]], is.null))]
      
    }

  }
}


#clean comments for subchapter which has subchapters
for(a in 3:length(jsonList) - 1){
  for(b in 1:length(jsonList[[a]])){
    if(chapterURLS[a,3] == "SubChapter" && chapterURLS[a+1,3] == "SubSubChapter"){
      if(names(jsonList[[a]][[b]]) == "R" && grepl("sourceCode r",jsonList[[a]][[b]])){
        
        print(paste("a is:" , a , "  b is ", b))
        page <- read_html(jsonList[[a]][[b]])
        
        node <- html_nodes(page,'.sourceLine') 
        
        #create an empty character list for converted nodes
        code <-vector(mode="character", length = length(as(node,"character")))
        
        #Convert nodes as character
        for (i in 1:length(as(node,"character"))){
          code[[i]] <- strsplit(as(node, "character"), "\n")[[i]]
        }
        
        
        #removing comment outputs
        for(j in 1:length(code)){
          
          if(grepl("#",html_text(read_html(code[[j]]))) && grepl("#>",html_text(read_html(code[[j]])))){
            print("This is a comment")
            code[[j]] <- NA
            print("line is deleted")
            
          }else{
            print("this is not line")
          }
        }
        
        
        #remove NA's
        code <- code[!unlist(lapply(code, is.na))]
        
        jsonList[[a]][[b]] <- ""
        #remove html tags
        for(i in 1:length(code)){
          code[[i]] <- paste(html_text(read_html(code[[i]])),"\n",sep="")
          jsonList[[a]][[b]]<- paste(jsonList[[a]][[b]],code[[i]])
          names(jsonList[[a]][[b]]) <- "R"
        }
        
        
        
        
      }else{
        print(paste("this is not a chapter","and i is:",i,"a and b is:   ", a, "and", b))
      }
    }
  }
}










