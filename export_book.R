#! /usr/bin/env RScript

df <- file.info(dir())
booknames <- rownames(df[df$isdir == TRUE,])

print(booknames)
cat("Enter the name of  book:");
bookname <- readLines("stdin",n=1);
cat("\nYou entered\n")
cat(bookname)


if( file_test( "-f", file.path( bookname, "Images","all_book_json.RData" ) )){
  cat("\n all_book_json file exist\n")
  load(paste( bookname, "/Images/all_book_json.RData",sep="") )
  cat("\n")
  cat(bookname)
  cat("\n")
  
}


source("cell_number.R")

cat(paste("Type number of chapters you want to export between 1 and", length(indexNums),":  "))
chapterNum <- readLines("stdin",n = 1)
if(chapterNum >= 1 && chapterNum <= length(indexNums) ){
  cat("\n done")
  
}else{
  cat(paste("Type number of chapters you want to export between 1 and", length(indexNums),":  "))
}


cat(paste("Type your user name on melda:\n"))
uri_user_name <- readLines("stdin",n = 1)


source("export_as_melda_json.R")



