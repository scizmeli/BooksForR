#This script exports the chapters of "R Packages" book  as melda.io JSON format
#just type the chapter number you want to export eg:  JsonCreator(1) exports chapter 1 as melda.io JSON format. 



library(jsonlite)
tjson <- jsonlite::fromJSON("input.json",simplifyDataFrame = FALSE)


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
    numberofcell <- 0
    for(y in indexNums[[x]]: (indexNums[[x + 1]])){
      for(u in 1:length(jsonList[[y]])){
        if(!is.null(jsonList[[y]][[u]])){
          numberofcell <- numberofcell + 1 
        }    
      }
    }
    print("hel")
    numberofcell - 1
  }else{
    distance <- (length(chapterURLS[,1])) - indexNums[[x]]
    print(paste("chapter 1 is begin from index", indexNums[[x]],"ends in:",length(chapterURLS[,1]),"total iteration:", distance))
    numberofcell <- 0
    for(y in indexNums[[x]]: length(chapterURLS[,1])){
      for(u in 1:length(jsonList[[y]])){
        if(!is.null(jsonList[[y]][[u]])){
          numberofcell <- numberofcell + 1 
        }    
      }
    }
    print("hel")
    numberofcell -1
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

GO <- function(x){
  tjson <- jsonlite::fromJSON("input.json",simplifyDataFrame = FALSE)
  tjson$project$stages[[1]][[8]] <<- emptyJSON(x)
  print("DONE!!")
}


JsonCreator<- function(x){
  j <<- 1
  z <<- 0
  tjson <<- jsonlite::fromJSON("input.json",simplifyDataFrame = FALSE)
  GO(x)
  if(x != length(indexNums)){
    for(i in indexNums[[x]]:(indexNums[[x+1]]  - 1 )){
      
      for(t in 1:length(jsonList[[i]])){
        
        if(names(jsonList[[i]][[t]]) == "HTML"){
          print(paste("BEGINING HTML PART","j:" , j, "i:" , i, "and t is:" , t))
          
          #code:
          
          tjson$project$stages[[1]][[8]][[j]][[3]] <<- jsonList[[i]][[t]]
          
          
          #language:
          
          tjson$project$stages[[1]][[8]][[j]][[4]] <<- names(jsonList[[i]][[t]])
          
          
          # index:
          
          tjson$project$stages[[1]][[8]][[j]][[5]] <<- z
          
          print(paste("z is :", z))
          
          
          #output:
          
          tjson$project$stages[[1]][[8]][[j]][[10]][[1]][[1]][[1]] <<-jsonList[[i]][[t]]
          
          print(paste("ENDING HTML PART","j:" , j, "i:" , i, "and t is:" , t))
          
          z <<- z +1
       
          j <<- j + 1
          
        }else if (names(jsonList[[i]][[t]]) == "R"){
          print(paste("BEGINING R PART","j:" , j, "i:" , i, "and t is:" , t))
          
          
          
          #code:
          
          tjson$project$stages[[1]][[8]][[j]][[3]] <<- jsonList[[i]][[t]]
          
          
          #language:
          
          tjson$project$stages[[1]][[8]][[j]][[4]] <<- names(jsonList[[i]][[t]])
          
          
          #index:
          
          tjson$project$stages[[1]][[8]][[j]][[5]] <<- z
          
          print(paste("z is :", z))
          
          
          
          #output:
          tjson$project$stages[[1]][[8]][[j]][[10]] <<- list()          

          # evaluated
          tjson$project$stages[[1]][[8]][[j]][[11]] <<- FALSE
          
          #hiddenCode 
          tjson$project$stages[[1]][[8]][[j]][[12]] <<- FALSE
          
          print(paste("ENDING R PART","j:" , j, "i:" , i, "and t is:" , t))
          
          z <<- z +1
          
          j <<- j + 1
        }
        
        # #name
        # tjson$name <- "rpackages"
        # 
        # #stages$uri
        # tjson$project$uri <- paste("suleyman-taspinar/","rpackages/",sep = "")
        # #title
        # tjson$project$title <-  "rpackages" 
        # 
        # #uri
        # tjson$project$stages[[1]]$uri <- paste("suleyman-taspinar/","rpackages/","rpackages",sep="")
        # 
        # #title in stages
        # tjson$project$stages[[1]]$title <- "rpackages"
        
        tjson$project$forkedFrom <<- "null"
        
        tjson$project$rating <<- 0
        
        tjson$project$languages <<- as.list(tjson$project$languages)
        
        tjson$project$keywords<<- as.list(tjson$project$keywords)
        
        
      }
      
    }
    
    
    output <<- toJSON(tjson,auto_unbox = TRUE,pretty = TRUE)
    
    write(output,paste("RPackages/","chapter",x,".json",sep = ""))
    
  }else{
    for(i in indexNums[[x]]:length(jsonList)){
      
      for(t in 1:length(jsonList[[i]])){
        
        if(names(jsonList[[i]][[t]]) == "HTML"){
          print(paste("BEGINING AT HTML PART","j:" , j, "i:" , i, "and t is:" , t))
          
          #code:
          
          tjson$project$stages[[1]][[8]][[j]][[3]] <<- jsonList[[i]][[t]]
          
          
          #language:
          
          tjson$project$stages[[1]][[8]][[j]][[4]] <<- names(jsonList[[i]][[t]])
          
          
          # index:
          
          tjson$project$stages[[1]][[8]][[j]][[5]] <<- z
          
          print(paste("z is :", z))
          
          
          #output:
          
          tjson$project$stages[[1]][[8]][[j]][[10]][[1]][[1]][[1]] <<-jsonList[[i]][[t]]
          
          print(paste("ENDING HTML PART","j:" , j, "i:" , i, "and t is:" , t))
          
          z <<- z +1
          
          j <<- j + 1
          
        }else if (names(jsonList[[i]][[t]]) == "R"){
          
          print(paste("BEGINNING OF  R PART","j:" , j, "i:" , i, "and t is:" , t))
          
          #code:
          
          tjson$project$stages[[1]][[8]][[j]][[3]] <<- jsonList[[i]][[t]]
          
          
          #language:
          
          tjson$project$stages[[1]][[8]][[j]][[4]] <<- names(jsonList[[i]][[t]])
          
          
          #index:
          
          tjson$project$stages[[1]][[8]][[j]][[5]] <<- z
          
          print(paste("z is :", z))
          
          
          
          #output:
          
          tjson$project$stages[[1]][[8]][[j]][[10]] <<- list() 
          
          
          
          paste("ENDING OF  R PART","j:" , j, "i:" , i, "and t is:" , t)
          z <<- z +1
          
          j <<- j + 1
          
        }
        
        tjson$project$forkedFrom <<- "null"
        
        tjson$project$rating <<- 0
        
        tjson$project$languages <<- as.list(tjson$project$languages)
        
        tjson$project$keywords<<- as.list(tjson$project$keywords)
        
        
      }
      
    }
    
    
    output <<- toJSON(tjson,auto_unbox = TRUE)
    
    write(output,paste("RPackages/","chapter",x,".json"))
    
  
    
      
    }


  
    }
        

    

  