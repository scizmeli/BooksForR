#This script decides given comment is comment output or not comment
# example of comment output:: #> blah blah is an output
# example of comment::  # this code blah   is a comment 
library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)


for(a in 1:length(jsonList)){
  for(b in 1:length(jsonList[[a]])){
    if(names(jsonList[[a]][[b]]) == "R" && grepl("sourceCode r",jsonList[[a]][[b]])){
      
      print(paste("a is:" , a , "  b is ", b))
      page <- read_html(jsonList[[a]][[b]])
      
      node <- html_nodes(page,".sourceCode") 
      node<- as(node,"character")
      #create an empty character list for converted nodes
      code <-list()
      
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
      code <- code[!unlist(lapply(code, is.null))]
      
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








