#! /usr/bin/env RScript

df <- file.info(dir())
booknames <- rownames(df[df$isdir == TRUE,])

print(booknames)
cat("Enter the name of  book:");
bookname <- readLines("stdin",n=1);
cat("\nYou entered\n")
cat(bookname)

if( file_test( "-f", file.path( bookname, "Images","all_book.RData" ) )){
  cat("\nYES\n")
  load(paste( bookname, "/Images/all_book.RData",sep="") )
  cat("\n")
  cat(bookname)
  cat("\n")
  for(a in 1:length(subChapterList)){
    if(length(subChapterList[[a]] ) == 0){
      cat(paste("\n", chapterURLS[a,2] , " is missing ", sep = ""))
      quit(save = "no")
      # stop("There are null variables in Book List.")
    }
  }
  
}


#convert all character vectors in the Book to named list
cat("\n\n convert all character vectors in the Book to named list")
source("nested_book.R")

#remove code outputs from named "R" list
cat("\n\nRemoving Comments")
source("remove_comments.R")

#changin href,img  attributes (relative to absolute)
#adding "target = _ blank"  attribute to anchor elements.
cat("\n\n\nChanging Href,Img elements")
source("html_link.R")


save.image(file = paste(bookname ,"/Images/all_book_json.RData",sep = ""))
