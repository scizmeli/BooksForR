#! /usr/bin/env RScript


#available url link
source("booksName.R")

cat("Enter a book url ");
url <- readLines("stdin",n=1);
cat("You entered")
 str(url);
cat( "\n" )



#scraping all urls in the book
source("get_all_urls.R")

 
#scraping all data in the book
source("get_all_book.R")


#splitting nested part of books
source("nested_book.R")


#merging text / code blocks
source("merge_and_sort.R")


#handling relative  / absolute links in book
source("html_link")
