#This script decides given comment is comment output or not comment
# example of comment output:: #> blah blah is an output
# example of comment::  # this code blah   is a comment 
library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)

for(a in 1:length(jsonLists)){
  for(b in 1:length(jsonLists[[a]])){
    if(grepl( "sourceCode" , jsonLists[[a]][[b]]) ){
      
      page <- read_html(jsonLists[[a]][[b]])

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
      
      jsonLists[[a]][[b]] <- ""
      #remove html tags
      for(i in 1:length(code)){
        code[[i]] <- paste(html_text(read_html(code[[i]])),sep=" ")
        jsonLists[[a]][[b]]<- paste(jsonLists[[a]][[b]],code[[i]])
      }
      
      
      
      
    }else{
      print("this is not a chapter")
    }
  }
}



jsonLists <- jsonList




