library(rvest)
library(xml)
absoluteImgLink  <-  FALSE
# Checking for not closed div brackets.closing div brackets in Chapter poarts!
for( a in 1:length( jsonList ) ){
  for( b in 1:length( jsonList[[a]]) ){
    if( chapterURLS[a,3]  == "Chapter" && !grepl( "</div>", substr(jsonList[[a]][[b]], nchar(jsonList[[a]][[b]]) - 10, nchar(jsonList[[a]][[b]]))) ){
      tmp <- names(jsonList[[a]][[b]]) 
      print("Heyy")
      jsonList[[a]][[b]] <- paste(jsonList[[a]][[b]], "</div>",sep="")
      names(jsonList[[a]][[b]]) <- tmp 
    }else{
      print("this chapter has no unclosed div chapters ")
    }
  }
}



#adding div elements with their id's to subchapter and subsubchapter
for( a in 1:length(jsonList) ){
  for( b in 1:length(jsonList[[a]]) ){
    if( chapterURLS[a,3] == "SubChapter" || chapterURLS[a,3] == "SubSubChapter" ){
      if( !grepl( "<div id=" , substring( jsonList[[a]][[1]],1,10) ) ){
        tmp <- names(jsonList[[a]][[1]])
        
        jsonList[[a]][[1]] <- paste( paste( "<div id=", '\"', parseSubChapterElements(a),'\"',">",sep = "" )  , jsonList[[a]][[1]], sep ="")
        
        jsonList[[a]][[1]] <- paste( jsonList[[a]][[1]], paste( "</div>", sep ="" ) )
        
        print(paste("this is a " ,a, b,"AND",         parseSubChapterElements(a)))
        
        names(jsonList[[a]][[1]]) <- tmp
        
      }
      
    }    
    
    
    
  }
  
  
}


#redirecting urls changing  href = "chaptername#subchaptername" to href = "#subchaptername"
for( a in 1:length(jsonList) ){
  for( b in 1:length(jsonList[[a]]) ){
    if(length(jsonList[[a]]) != 0 && grepl( "href=", jsonList[[a]][[b]] )){
      
      page <- read_html( jsonList[[a]][[b]] )
      
      print( paste( "reading page",a," ",b) )
      
      nodes <- html_nodes( page , "a" )
      
      nodes <- as( nodes,"character")
      
      
      for( i in 1:length(nodes) ) {
        temp <- vector( mode="list", length =  length(nodes) )
        if(grepl("href" ,substr(nodes[[i]] , 1 , 17) )){
          
          #if hrefs in chapters not contains http
          if( !grepl("http",substr(nodes[[i]] , 1 , 17))){
            #<a href=\"whole-game.html#whole-game\">2</a> to <a href=\"#whole-game\">2</a> 
            temp[[i]] <- gsub( '(?<=\").*(?=#)',"", nodes[[i]], perl = TRUE)
            
            #applying the regexp to jsonList
            tempList <-gsub( nodes[[i]], temp[[i]] , jsonList[[a]][[b]] )
            jsonList[[a]][[b]] <- tempList
            
            print( paste( "done","A is:", a ,"B is:" , b , "I is:"  , i))
            
          }else{
            temp[[i]] <- "lolo"
            print(paste("NNNNOOTTdone","A is:",a,"B is:", b, "I is:" ,i))
            
          }
        }
      }
    }
  }
}



##Adding target_blank to the html attribute
for( a in 1:length(jsonList) ){
  for( b in 1:length(jsonList[[a]]) ){
    if(length(jsonList[[a]]) != 0 && grepl( "href=", jsonList[[a]][[b]] )){
      
      page <- read_html( jsonList[[a]][[b]] )
      
      print( paste( "reading page",a," ",b) )
      
      nodes <- html_nodes( page , "a" )
      
      nodes <- as( nodes,"character")
      
      
      for( i in 1:length(nodes) ) {
        temp <- vector( mode="list", length =  length(nodes) )
        
        
        if(grepl("href" ,substr(nodes[[i]] , 1 , 17) )){
          
          #if hrefs in chapters not contains http
          if( grepl("http",substr(nodes[[i]] , 1 , 17))){
            #<a href=\"whole-game.html#whole-game\">2</a> to <a href=\"#whole-game\">2</a> 
            y <- regexpr( '.*(?<=")' , nodes[[i]] , perl = TRUE)
            z <-regmatches(nodes[[i]] , y)
            
            sentence <-paste(z,' target="_blank"', sep = "")
            temp[[i]] <- gsub(z,sentence,nodes[[i]])
            
            #escaping speacial characters
            nodes[[i]] <- gsub("([+.])","\\\\\\1", nodes[[i]])
            
            #applying the regexp to jsonList
            tempList <-gsub( nodes[[i]], temp[[i]] , jsonList[[a]][[b]] )
            
            jsonList[[a]][[b]] <- tempList
            
            print( paste( "done","A is:", a ,"B is:" , b , "I is:"  , i))
            
          }else{
            temp[[i]] <- "lolo"
            print(paste("NNNNOOTTdone","A is:",a,"B is:", b, "I is:" ,i))
            
          }
          
          
          
        }
        
        
      }
      
      
      
    }
    
  }
  
}


absoluteImgLink <- TRUE
##Adding book links to the img link
if(absoluteImgLink  == TRUE){
  for( a in 3: ( length(jsonList) -1 ) ) {
    for( b in 1:length(jsonList[[a]]) ){
      if(length(jsonList[[a]]) != 0 && grepl( "img src", jsonList[[a]][[b]] )){
        
        page <- read_html( jsonList[[a]][[b]] )
        
        print( paste( "reading page",a," ",b) )
        
        nodes <- html_nodes( page , "img" )
        
        nodes <- as( nodes,"character")
        
        
        for( i in 1:length(nodes) ) {
          temp <- vector( mode="list", length =  length(nodes) )
          z <- paste("<img src=",'\"',sep="")
          sentence<-paste(z,url,"/", sep = "")
          
          temp[[i]] <- gsub(z,sentence,nodes[[i]])
          jsonList[[a]][[b]] <- gsub( nodes[[i]], temp[[i]] , jsonList[[a]][[b]] ,fixed = TRUE)
          print("Relative image converted to absolute")
          }
          
        }
        
      }
      
    }
    
  }
  
  

