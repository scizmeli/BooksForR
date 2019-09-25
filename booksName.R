#!/usr/bin/env Rscript
#Some changes.


library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)



url <- GET("https://bookdown.org")
Table<-readHTMLList(rawToChar(url$content))
tablex <- read_html(rawToChar(url$content))






booksAuthors <- function(){
  
  page <- read_html(url)  
  
  nodes <- html_nodes(page,'.article-list  h2')
  gsub("by"," ",html_text(nodes))
  
}



booksName <- function(){
  
  page <- read_html(url)  
  
  nodes <- html_nodes(page,'.article-list  h1')
  html_text(nodes)
  
  
}




booksLinks <- function(){
  
  page <- read_html(url)  
  
  nodes <- html_nodes(page,'h1 a')
  
  html_attr(nodes,"href")
}



#scraping the links for available books
df <- data.frame("Book"= booksName(),
                 "Author"= booksAuthors(),
                 "Link" = booksLinks())


#write.csv(df, file = "booksName.csv")
  






