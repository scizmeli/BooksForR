ullcheck <- function(x){
  for(i in indexNums[[x]]:indexNums[[x+1]]){
    for(t in 1:length(jsonList[[i]])){
      print(paste(i," ", t ,is.null(jsonList[[i]][[t]])))  
      print(paste(i," ", t ,is.null(names(jsonList[[i]][[t]]))))
      
      }
      
    }

}
nullcheck(1)
j <- 1
JsonNullCheck <- function(x){
  for(i in indexNums[[x]]:indexNums[[x+1]]){
    for(t in 1:length(jsonList[[i]])){
      
      if(names(jsonList[[i]][[t]]) == "HTML"){
        is.null(tjson$project$stages[[1]][[8]][[j]][[3]]) 
        
        is.null(tjson$project$stages[[1]][[8]][[j]][[4]]) 
        
        is.null(tjson$project$stages[[1]][[8]][[j]][[5]]) 
        
        #output:
        is.null(tjson$project$stages[[1]][[8]][[j]][[10]][[1]][[1]][[1]]) 
        
        print(paste("IN HTML PART","j:" , j, "i:" , i, "and t is:" , t))
        z <- z +1
        j <- j + 1
        
      }else{
        
        print(paste("i is:", i," t is:",t, " j is:",j ))
        #code:
        is.null(tjson$project$stages[[1]][[8]][[j]][[3]]) 
        
        #language:
        is.null(tjson$project$stages[[1]][[8]][[j]][[4]]) 
        
        #index:
        is.null(typeof(tjson$project$stages[[1]][[8]][[j]][[5]])) 
        
        
        #output:
        #tjson$project$stages[[1]][[8]][[j]][[10]][[1]][[1]][[1]] <- ""
        print(paste("IN R PART","j:" , j, "i:" , i, "and t is:" , t))
        z <- z +1
        j <- j + 1
      }
    }
  }
  
  
}



x <- 1
j <- 1
for(i in ( indexNums[[x]]:indexNums[[x+1]])){  
  for(t in 1:length(jsonList[[i]])){
    print(paste("j:" , j, "i:" , i, "and t is:" , t))
    j <- j + 1
  }
}

