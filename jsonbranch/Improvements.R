#convert the r cell which doesn't have r code to html
for(a in 1:length(jsonList)){
  for(b in 1:length(jsonList[[a]])){
    if(names(jsonList[[a]][[b]])  == "R" && grepl(paste("<div class=",'\"',sep=""), jsonList[[a]][[b]])){
      print(paste("this html cell acting like as a R code",a," :a ", b, " :b "))
      
      names(jsonList[[a]][[b]])  <- "HTML"
    }else{
      print("There is no html cell acting like as a R code")
      
    }
    
    
      
  }
}



namecheck(jsonList)

##Comment the install.packages code
for(a in 1:length(jsonList)){
  for(b in 1:length(jsonList[[a]])){
    if(names(jsonList[[a]][[b]])  == "R" && grepl(paste("install.packages"), jsonList[[a]][[b]])){
      print(paste("this html cell acting like as a R code",a," :a ", b, " :b "))
      jsonList[[a]][[b]] <- gsub("install.packages","#install.packages",jsonList[[a]][[b]])
      }
  }
}


a <- "example"
paste(a,"xy",sep="")
#adding div elements with their id's to sbchapter and subsubchapter
for( a in 1:length(jsonList) ){
  for( b in 1:length(jsonList[[a]]) ){
    if( chapterURLS[a,3] == "SubChapter" || chapterURLS[a,3] == "SubSubChapter" ){
      grep
      if( !grepl( "<div id=" , substring( jsonList[[a]][[1]],1,10) ) ){
        jsonList[[a]][[1]] <- paste( paste( "<div id=", '\"', parseSubChapterElements(a),'\"',">",sep = "" )  , jsonList[[a]][[1]], sep ="")
         jsonList[[a]][[1]] <- paste( jsonList[[a]][[1]], paste( "</div>", sep ="" ) )
        print(paste("this is a " ,a, b,"AND",         parseSubChapterElements(a)))
      }
      
    }    
    
    
    
    
    
    }

    
}




library(rvest)
for( a in 3:length(jsonList) ){
  for( b in 1:length(jsonList[[a]]) ){
    if(names(jsonList[[a]][[b]]) == "HTML" && grepl("href=",jsonList[[a]][[b]])){
      
      page <- read_html(jsonList[[a]][[b]])
      print(paste("reading page",a," ",b))
      nodes <-html_nodes(page,"a")
      nodes <- as(nodes,"character")
      
      
      for( i in 1:length(nodes) ) {
        temp <- vector(mode="list", length = length(nodes))
        tempList <- list()
        
        if( grepl( "#", nodes[[i]] ) && ( nchar(str_match(nodes[[i]],'(?<=").*(?=")'))  < 60)  ){
          #<a href=\"whole-game.html#whole-game\">2</a> to <a href=\"#whole-game\">2</a> 
          temp[[i]] <- gsub('(?<=\").*(?=#)',"",nodes[[i]],perl = TRUE)
          
          #applying the regexp to jsonList
          tempList <-gsub(nodes[[i]],temp[[i]],jsonList[[a]][[b]])
          jsonList[[a]][[b]] <- tempList

          print(paste("done","A is:",a,"B is:", b, "I is:" ,i))
          names(jsonList[[a]][[b]] == "HTML")
          
        }else{
          temp[[i]] <- "lolo"
          print(paste("NNNNOOTTdone","A is:",a,"B is:", b, "I is:" ,i))
          
        }
        
      }
      
      
      
    }
    
    }
  
}

hrefKeywords<-vector (mode ="list",length = length(jsonList))
for( a in 3:length(jsonList) ){
  for( b in 1:length(jsonList[[a]]) ){
    print("Lol")
    hrefKeywords[[a]] <- gsub("https://r-pkgs.org/","",chapterURLS[a,1])
    
      
  }
}



nodes[[5]]
regmatches(nodes[[i]],grep('(?<=").*(?=")',nodes[[i]],perl = TRUE))

namecheck(jsonList)



nameBackup <- jsonList




