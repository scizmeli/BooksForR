#! /usr/bin/env RScript
	

#available url link
source("ExecutableBooksForMelda/booksName.R")

cat("Enter the number of  book url ");

urlnumber <- readLines("stdin",n=1);w
url <- df[urlnumber,3]
cat("You entered")
 
str(url);
cat( "\n" )



#scraping all urls in the book
source("ExecutableBooksForMelda/get_all_urls.R")

 
#scraping all data in the book
source("ExecutableBooksForMelda/get_all_book.R")


