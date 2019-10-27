## run if Clean Comment is TRUE 
cleanComment = TRUE
#if sourceCode r attributes does not contains "sourceLine"

#check for type of code attribute
for(a in 1:length(jsonList)){
  for(b in 1:length(jsonList[[a]])){
    if( length(jsonList[[a]]) != 0 && names(jsonList[[a]][[b]]) == "R")
      if(grepl("sourceLine",jsonList[[a]][[b]])) {
        codeType <- "sourceLine"
        break()
      }else{
        codeType <- "spanLine"
        break()
      }
      }
}


if(codeType == "spanLine" && cleanComment == TRUE){
  
  for(a in 1:length(jsonList)){
    for(b in 1:length(jsonList[[a]])){
      if( length(jsonList[[a]]) != 0 && names(jsonList[[a]][[b]]) == "R" && grepl("sourceCode r",jsonList[[a]][[b]])){
        
        print(paste("a is:" , a , "  b is ", b))
        page <- read_html(jsonList[[a]][[b]])
        
        node <- html_nodes(page,'code.sourceCode.r') 
        node <- xml_contents(node)
        node <- html_text(node)
        node<- as( node ,"character")
        
        
        #create an empty character list for converted nodes
        code <-vector(mode = "list" , length= length(node))
        j <- 1
        #Convert nodes as character
        for (i in 1: length(node)  ){
          if( grepl( "#",node[[i]] ) && grepl("#>",node[[i]])){
            print(i)
            j <- j + 1
          }else{
            print(paste(i,"and: ", j))
            code[[j]] <- paste( code[[j]], node[[i]] , sep = "")
          }
          
        }
        #remove NA's
        code <- code[!unlist(lapply(code, is.null))]
        
        jsonList[[a]][[b]] <- code[[1]]
        names(jsonList[[a]][[b]] ) <- "R"      
        
        
        
      }else{
        print(paste("this is not a chapter","and i is:",i,"a and b is:   ", a, "and", b))
      }
      
      
    }
  }
}



#if sourceCode r attributes does  "sourceLine"
if(codeType == "sourceLine" && cleanComment == TRUE){
  for(a in 1:length(jsonList)){
    for(b in 1:length(jsonList[[a]])){
      if(length(jsonList[[a]]) != 0 && names(jsonList[[a]][[b]]) == "R" && grepl("sourceCode r",jsonList[[a]][[b]])){
        
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
        if( length(code) != 0 ){
          for(i in 1:length(code)){
            code[[i]] <- paste(html_text(read_html(code[[i]])),"\n",sep="")
            jsonList[[a]][[b]]<- paste(jsonList[[a]][[b]],code[[i]])
            names(jsonList[[a]][[b]]) <- "R"
          }
          
        }else{
          jsonList[[a]][[b]] <- "NULL"
          names(jsonList[[a]][[b]]) <- "HTML"
        }
        
        
        
      }else{
        print("this is not a chapter")
      }
    }
  }
  
}


#if a r block contains all comments , remove it.
for(a in 1:length(jsonList)){
  for(b in 1:length(jsonList[[a]])){
  if(jsonList[[a]][[b]] == "NULL"){
    paste(a," and ",b)
    jsonList[[a]][[b]] <- NULL
  }
      }
}




