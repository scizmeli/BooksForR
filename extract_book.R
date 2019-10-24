#! /usr/bin/env RScript


#remove the r code outputs if cleanComment is true 
cleanComments <- TRUE

#Set number of chapters that will be exported as melda.io json format
chapterNum <- 32

#Change this if you want to special melda project title 
#the default title is bookname
#projectTitle <- paste(bookname , "example" , sep="") #title of melda url that


#removing comments from code blocks
source("remove_comments.R")


#exporting as melda.io json format
source("export_as_melda_json.R")
