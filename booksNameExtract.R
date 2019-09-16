#scraping the links for available books
library(httr)
library(rvest)
library(tidyverse)
library(dplyr)
library(XML)
library(bookdown)

render_book("r-pkgs/index.Rmd",output_format = )


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




df <- data.frame("Book"= booksName(),
                 "Author"= booksAuthors(),
                 "Link" = booksLinks())

