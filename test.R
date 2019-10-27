#! /usr/bin/env RScript

#checking for empty variable
for(a in 1:length(jsonList)){
  for(b in 1:length(jsonList[[a]])){
  if(length(jsonList[[a]] == 0)){
    cat(paste(chapterURLS[a,2] ," is empty\n"))
  }
     }
}


page <- read_html( chapterURLS[1,1])  
node <- html_node(page, "#header")
jsonList[[1]][[1]] <- as(node,"character")
names(jsonList[[1]][[1]]) <- "HTML"
