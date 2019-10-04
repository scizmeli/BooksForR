#This script exports the chapters of "R Packages" book  as melda.io JSON format
#just type the chapter number you want to export eg:  JsonCreator(1) exports chapter 1 as melda.io JSON format. 

library(jsonlite)
tjson <- jsonlite::fromJSON("input.json",simplifyDataFrame = FALSE)



#this function defines chapters index numbers
getChapterIndex <- function(){
    indexNums <<- list()
  for(i in 3:length(jsonList)){
    if(chapterURLS[i,3] == "Chapter"){
      indexNums <<- append(indexNums,i)
    }
  }
indexNums
}


getChapterIndex()
#this function calculates how many cells in one chapter.
calculateChapter <- function(x){
  if(x != length(indexNums)){
    distance <- indexNums[[x + 1]] - indexNums[[x]]
    print(paste("chapter 1 is begin from index", indexNums[[x]],"ends in:",indexNums[[x + 1]],"total iteration:", distance))
    distance
    # chapter 1 : 2-1
  }else{
    distance <- (length(chapterURLS[,1]) -2) - indexNums[[x]]
    print(paste("chapter 1 is begin from index", indexNums[[x]],"ends in:",length(chapterURLS[,1]),"total iteration:", distance))
    distance
  }
  
  
}


#this function creates a list for chapters to export as a melda.io json file
emptyJSON<- function(x){
  distance <- calculateChapter(x)
  tjson <- jsonlite::fromJSON("input.json",simplifyDataFrame = FALSE)
  for(i in 1:distance){
    tjson$project$stages[[1]][[8]] <- append(tjson$project$stages[[1]][[8]],tjson$project$stages[[1]][[8]][1])
    print("creating lists")  
  }
  tjson$project$stages[[1]][[8]]
}


#go 
GO <- function(x){
  tjson <- jsonlite::fromJSON("input.json",simplifyDataFrame = FALSE)
  tjson$project$stages[[1]][[8]] <<- emptyJSON(x)
  print("DONE!!")
}




JsonCreator<- function(x){
  j <- 1
  z <- 0
  tjson <- jsonlite::fromJSON("input.json",simplifyDataFrame = FALSE)
  GO(x)
  for(i in indexNums[[x]]:(indexNums[[x+1]] - 1)){
    for(t in 1:length(jsonList[[i]])){
      if(names(jsonList[[i]][[t]]) == "HTML"){
        print(paste("i is:", i," t is:",t, " j is:",j ))
        #code:
        tjson$project$stages[[1]][[8]][[j]][[3]] <- jsonList[[i]][[t]]
        
        #language:
        tjson$project$stages[[1]][[8]][[j]][[4]] <- names(jsonList[[i]][[t]])
        
        # index:
        tjson$project$stages[[1]][[8]][[j]][[5]] <- z
        print(paste("z is :", z))
        
        #output:
        tjson$project$stages[[1]][[8]][[j]][[10]][[1]][[1]][[1]] <-jsonList[[i]][[t]]
        print(paste("IN HTML PART","j:" , j, "i:" , i, "and t is:" , t))
        z <- z +1
        j <- j + 1
      }else if (names(jsonList[[i]][[t]]) == "R"){
        print(paste("i is:", i," t is:",t, " j is:",j ))
        #code:
        tjson$project$stages[[1]][[8]][[j]][[3]] <- jsonList[[i]][[t]]
        
        #language:
        tjson$project$stages[[1]][[8]][[j]][[4]] <- names(jsonList[[i]][[t]])
        
        #index:
        tjson$project$stages[[1]][[8]][[j]][[5]] <- z
        print(paste("z is :", z))
        #output:
        #tjson$project$stages[[1]][[8]][[j]][[10]][[1]][[1]][[1]] <- ""
        print(paste("IN R PART","j:" , j, "i:" , i, "and t is:" , t))
        z <- z +1
        j <- j + 1
      }
      tjson$project$forkedFrom <- "null"
      tjson$project$rating <- 0
      tjson$project$languages <- as.list(tjson$project$languages)
      tjson$project$keywords<- as.list(tjson$project$keywords)
      
    }
  }
  output <- toJSON(tjson,auto_unbox = TRUE)
  write(output,paste("RPackages/","chapter",x,".json"))
  
  
}



createJson <- function(x){
  
if(x != length(indexNums)){
  GO(x)
  z <<- 0
  j <<- 1
  for(i in indexNums[[x]]:indexNums[[x+1]]){  
    for(t in 1:length(jsonList[[i]])){
      if(names(jsonList[[i]][[t]]) == "HTML"){
        #code:
        tjson$project$stages[[1]][[8]][[j]][[3]] <- jsonList[[i]][[t]]
        
        #language:
        tjson$project$stages[[1]][[8]][[j]][[4]] <- names(jsonList[[i]][[t]])
        
        #index:
        tjson$project$stages[[1]][[8]][[j]][[5]] <- z
        z <- z + 1
        j <- j + 1
        #output:
        tjson$project$stages[[1]][[8]][[j]][[10]][[1]][[1]][[1]] <-jsonList[[i]][[t]]
        print(paste("writing for the", j,".", "iteration"))
        
      }else{
        #code:
        tjson$project$stages[[1]][[8]][[j]][[3]] <- jsonList[[i]][[t]]
        
        #language:
        tjson$project$stages[[1]][[8]][[j]][[4]] <- names(jsonList[[i]][[t]])
        
      
        #index:
        tjson$project$stages[[1]][[8]][[j]][[5]] <- z
        
        #output:
        tjson$project$stages[[1]][[8]][[j]][[10]][[1]][[1]][[1]] <- ""
        print(paste("writing for the", j,".", "iteration"))
        
        j <- j + 1
        z < z + 1
      }
      
    }
    
    
  }  
  print("final touches")
  
  tjson$project$forkedFrom <- "null"
  tjson$project$rating <- "null"
  tjson$project$languages <- as.list(tjson$project$languages)
  tjson$project$keywords<- as.list(tjson$project$keywords)
}else{
  j <- 1
  for(i in ( 231 : indexNums[[x]])){
    for(t in 1:length(jsonList[[i]])){
      if(names(jsonList[[i]][[t]]) == "HTML"){
        #code:
        tjson$project$stages[[1]][[8]][[j]][[3]] <- jsonList[[i]][[t]]

        #language:
        tjson$project$stages[[1]][[8]][[j]][[4]] <- names(jsonList[[i]][[t]])

        #index
        tjson$project$stages[[1]][[8]][[j]][[5]] <- z
        z <- z + 1


        #output:
        tjson$project$stages[[1]][[8]][[j]][[10]][[1]][[1]][[1]] <-jsonList[[i]][[t]]
        print(paste("writing for the", j,".", "iteration"))

        j <- j + 1

      }else{
        #code:
        tjson$project$stages[[1]][[8]][[j]][[3]] <- jsonList[[i]][[t]]

        #language:
        tjson$project$stages[[1]][[8]][[j]][[4]] <- names(jsonList[[i]][[t]])


        #index:
        tjson$project$stages[[1]][[8]][[j]][[5]] <- z
        z <- z + 1
        #output:
        tjson$project$stages[[1]][[8]][[j]][[10]][[1]][[1]][[1]] <- ""
        print(paste("writing for the", j,".", "iteration"))

        j <- j + 1

      }
    }
  }
  print("final touches")
  tjson$project$forkedFrom <- "null"
  tjson$project$rating <- "null"
  tjson$project$languages <- as.list(tjson$project$languages)
  tjson$project$keywords<- as.list(tjson$project$keywords)
}

  
  
  
chapter <<- toJSON(tjson,auto_unbox = TRUE,pretty = FALSE)    
write(chapter,paste(x,".chapter",".json",sep=""))
print("json file created")
}






tjson <- jsonlite::fromJSON("exampleJSON.json")
chapterOne <- toJSON(tjson)
write(chapter,paste("xchapter",".json",sep=""))





toJSON(scalars)

input <- fromJSON("input.json",simplifyDataFrame = FALSE)
output <- toJSON(tjson,auto_unbox = TRUE)
write(output,"jsonTests/helpGod.json")
save()
chapterOne <- toJSON(tjson,auto_unbox = TRUE,pretty = FALSE)


#presentation notes
# *Presentation Notes
# **how should you improve the melda.io platform?
#   give an detailed example, 
# **tell your plans to audience, how you solved the problems with steps basically?
#   **which problem you are solving with your product? 
#   **don't say the blah blah words
# **don't make it your project insignificiant
# **positive/negative experience about 
# *use grammarly to fix spelling errors.

