#This script decides given comment is comment output or not comment
# example of comment output:: #> blah blah is an output
# example of comment::  # this code blah   is a comment 
library(httr) 
library(rvest) 
library(dplyr)
library(XML)
cleanList <- chaptersList

for(a in 1:length(cleanList)){
  for(b in 1:length(cleanList[[a]])){
    if(names(cleanList[[a]][[b]]) == "R" && grepl("sourceCode r",cleanList[[a]][[b]])){
      
      print(paste("a is:" , a , "  b is ", b))
      page <- read_html(cleanList[[a]][[b]])
      
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
      
      cleanList[[a]][[b]] <- ""
      #remove html tags
      for(i in 1:length(code)){
        code[[i]] <- paste(html_text(read_html(code[[i]])),"\n",sep="")
        cleanList[[a]][[b]]<- paste(cleanList[[a]][[b]],code[[i]])
        names(cleanList[[a]][[b]]) <- "R"
      }
      
      
      
      
    }else{
      print("this is not a chapter")
    }
  }
}

