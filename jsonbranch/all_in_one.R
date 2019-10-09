      library(jsonlite)
      
      #Hole book in one JSON
      tjson <- jsonlite::fromJSON("input.json",simplifyDataFrame = FALSE)
      
      chapterNum <- 18
      projectTitle <- "Rpackages-Hadley-The-Wickham-35"
      
      #creating empty li
      while(length(tjson$project$stages) != chapterNum){
      
        tjson$project$stages <- append(tjson$project$stages,tjson$project$stages[1])
      }
      
      
      emptyJSONN<- function(x){
        distance <<- calculateChapter(x)
        for(i in 1 :  distance){
          tjson$project$stages[[x]][[8]] <<- append(tjson$project$stages[[x]][[8]],tjson$project$stages[[x]][[8]][1])
          print("creating lists")  
        }
        tjson$project$stages[[x]][[8]]
      }
      
      
      
      GOO <- function(x){
        tjson$project$stages[[x]][[8]] <<- emptyJSONN(x)
        print("DONE!!")
        #project name
        tjson$name <<-tolower(projectTitle)
        
        tjson$project$title <<- tjson$name
        
        tjson$project$uri <<- tolower(paste("suleyman-taspinar/",tjson$name,sep = ""))
        
      }
      
      for(i in 1:chapterNum){
        GOO(i)
      }
      
      
      for(x in 1:chapterNum){
        j <- 1
        z <- 0
        if(x != length(indexNums)){
          for(i in indexNums[[x]]:(indexNums[[x+1]] - 1)){
            
            for(t in 1:length(jsonList[[i]])){
              
              if(names(jsonList[[i]][[t]]) == "HTML"){
                print(paste("BEGINING HTML PART","j:" , j, "i:" , i, "and t is:" , t," x is:" , x))
                
                #code:
                tjson$project$stages[[x]][[8]][[j]][[3]] <- jsonList[[i]][[t]]
                
                
                #language:
                tjson$project$stages[[x]][[8]][[j]][[4]] <- names(jsonList[[i]][[t]])
                
                
                # index:
                tjson$project$stages[[x]][[8]][[j]][[5]] <- z
                
                print(paste("z is :", z))
                
                #output:
                tjson$project$stages[[x]][[8]][[j]][[10]][[1]][[1]][[1]] <-jsonList[[i]][[t]]
                print(paste("ENDING HTML PART","j:" , j, "i:" , i, "and t is:" , t," x is:" , x))
  
                #evaluated
                tjson$project$stages[[x]][[8]][[j]][[11]] <- TRUE
                
                #hiddenCode 
                tjson$project$stages[[x]][[8]][[j]][[12]] <- TRUE
                
                
                z <- z +1
                j <- j + 1
                
              }else if (names(jsonList[[i]][[t]]) == "R"){
                print(paste("BEGINING R PART","j:" , j, "i:" , i, "and t is:" , t," x is:" , x))
                
                #code:
                tjson$project$stages[[x]][[8]][[j]][[3]] <- jsonList[[i]][[t]]
                
                #language:
                tjson$project$stages[[x]][[8]][[j]][[4]] <- names(jsonList[[i]][[t]])
                
                #index:
                tjson$project$stages[[x]][[8]][[j]][[5]] <- z
                
                print(paste("z is :", z))
                
                
                #output:
                tjson$project$stages[[x]][[8]][[j]][[10]] <- list()          
                
                # evaluated
                tjson$project$stages[[x]][[8]][[j]][[11]] <- FALSE
                
                #hiddenCode 
                tjson$project$stages[[x]][[8]][[j]][[12]] <- FALSE
                
                print(paste("ENDING R PART","j:" , j, "i:" , i, "and t is:" , t," x is:" , x))
                
                z <- z +1
                j <- j + 1
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
              
              
              #project name
              tjson$name <-tolower(projectTitle)
              #project title
              tjson$project$title <- tjson$name
              #project uri
              tjson$project$uri <- tolower(paste("suleyman-taspinar/",tjson$name,sep = ""))
              
              #order
              tjson$project$stages[[x]][[7]][[1]] <- x - 1
              
              #stage uri
              tjson$project$stages[[x]][[1]] <-paste(tjson$project$uri,"/",gsub(" ","-",chapterURLS[indexNums[[x]],2]),sep = "" ) 
              
              #stage name
              tjson$project$stages[[x]][[3]] <-chapterURLS[indexNums[[x]],2]
              
              #stage title
              tjson$project$stages[[x]][[1]] <- tolower(gsub(" ","-",chapterURLS[indexNums[[x]] , 2] ))
              
              #evaluated
              tjson$project$stages[[x]][[8]][[j]][[11]] <- FALSE
              
              #hiddenCode 
              tjson$project$stages[[x]][[8]][[j]][[12]] <- FALSE
              
              
              
              tjson$project$forkedFrom <- "null"
              tjson$project$rating <- 0
              tjson$project$languages <- as.list(tjson$project$languages)
              tjson$project$keywords<- as.list(tjson$project$keywords)
              
              
            }
            
          }
          
          
        }else{
          j <-1
          z<- 0
          for(i in indexNums[[x]]:(length(jsonList))){
            
            for(t in 1:length(jsonList[[i]])){
              
              if(names(jsonList[[i]][[t]]) == "HTML"){
                print(paste("BEGINING AT HTML PART","j:" , j, "i:" , i, "and t is:" , t))
                
                #code:
                tjson$project$stages[[x]][[8]][[j]][[3]] <- jsonList[[i]][[t]]
                
                #language:
                tjson$project$stages[[x]][[8]][[j]][[4]] <- names(jsonList[[i]][[t]])
                
                #index:
                tjson$project$stages[[x]][[8]][[j]][[5]] <- z
                
                print(paste("z is :", z))
                
                #output:
                tjson$project$stages[[x]][[8]][[j]][[10]][[1]][[1]][[1]] <-jsonList[[i]][[t]]
                
                #evaluated
                tjson$project$stages[[x]][[8]][[j]][[11]] <- TRUE
                
                #hiddenCode 
                tjson$project$stages[[x]][[8]][[j]][[12]] <- TRUE
                
                print(paste("ENDING HTML PART","j:" , j, "i:" , i, "and t is:" , t))
                z <- z +1
                j <- j + 1
              }else if (names(jsonList[[i]][[t]]) == "R"){
                
                print(paste("BEGINNING OF  R PART","j:" , j, "i:" , i, "and t is:" , t))
                
                #code:
                tjson$project$stages[[x]][[8]][[j]][[3]] <- jsonList[[i]][[t]]
                
                #language:
                tjson$project$stages[[x]][[8]][[j]][[4]] <- names(jsonList[[i]][[t]])
                
                #index:
                tjson$project$stages[[x]][[8]][[j]][[5]] <- z
                
                print(paste("z is :", z))
                
                #evaluated
                tjson$project$stages[[x]][[8]][[j]][[11]] <- FALSE
                
                #hiddenCode 
                tjson$project$stages[[x]][[8]][[j]][[12]] <- FALSE
                
                #output:
                tjson$project$stages[[x]][[8]][[j]][[10]] <- list() 
                
                paste("ENDING OF  R PART","j:" , j, "i:" , i, "and t is:" , t)
                z <- z +1
                j <- j + 1
                
              }
              
              #project name
              tjson$name <-tolower(projectTitle)
              #project title
              tjson$project$title <- tjson$name
              #project uri
              tjson$project$uri <- tolower(paste("suleyman-taspinar/",tjson$name,sep = ""))
              
              #order
              tjson$project$stages[[x]][[7]][[1]] <- x - 1
              
              #stage uri
              tjson$project$stages[[x]][[1]] <-paste(tjson$project$uri,"/",gsub(" ","-",chapterURLS[indexNums[[x]],2]),sep = "" ) 
              
              #stage name
              tjson$project$stages[[x]][[3]] <-chapterURLS[indexNums[[x]],2]
              
              #stage title
              tjson$project$stages[[x]][[1]] <- tolower(gsub(" ","-",chapterURLS[indexNums[[x]] , 2] ))
              
              #evaluated
              tjson$project$stages[[x]][[8]][[j]][[11]] <- FALSE
              
              #hiddenCode 
              tjson$project$stages[[x]][[8]][[j]][[12]] <- FALSE
              
              
              
              tjson$project$forkedFrom <- "null"
              tjson$project$rating <- 0
              tjson$project$languages <- as.list(tjson$project$languages)
              tjson$project$keywords<- as.list(tjson$project$keywords)
              
              
            }        
            
            }
        
        }
      }
      

   
      
    #deleting null elements
    for( x in 1:chapterNum ){
      lastElement <- length( tjson$project$stages[[x]][[8]] )
      if( tjson$project$stages[[x]][[8]][[lastElement]][[3]] == "<h2> FIRST HTML CELL</h2>" ){
        print("NULL ELEMENT DELETED")
        tjson$project$stages[[x]][[8]][lastElement] <- NULL
        
        
        
        
      }
      
      
      
      
      
      
    }
      
      
      
      
      
      
      
      
      
      
      
      #saving as melda.io json format
      output <- toJSON(tjson,auto_unbox = TRUE,pretty = TRUE)
      write(output,paste("RPackages/","chapter",x,".json",sep = ""))
      
      
      
      
      
        
      
      
      
      

      