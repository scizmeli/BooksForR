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








