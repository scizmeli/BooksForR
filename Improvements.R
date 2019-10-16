hrefcheck <- function(x,y){
  if( length( html_nodes(read_html(jsonList[[x]][[y]]), 'a')) != 0 ){
    html_nodes( read_html( jsonList[[x]][[y]] ), 'a')
  }else{
    print("This chapter has not anchor attribute")
  }
  
}

namesBackup <- jsonList
#namecheck
namecheck <- function(jsonList){
  if( class(jsonList) == "list" ){
    for( i in 1 : length(jsonList) ){
      for( t in 1 : length(jsonList[[i]]) ){
        if( is.null(names(jsonList[[i]][[t]])) ){
          print( paste( "i:",i,"  t:",t,"  is no names"))
          names( jsonList[[i]][[t]]) <<- names(namesBackup[[i]][[t]])
        }
      }
    }
  }else{
    print("This is not list")
  }
  
}

for( i in 1 : length(jsonList) ){
  for( t in 1 : length(jsonList[[i]]) ){
    if( is.null(names(jsonList[[i]][[t]])) ){
      names( jsonList[[i]][[t]]) <- "HTML"
      print(paste("i:",i,"\\n t is:", t))
      
            }
    
  }
}

names(jsonList[[418]][[1]]) <- "HTML"

#closing div brackets in Chapter poarts!
for( a in 3:length( jsonList ) ){
  for( b in 1:length( jsonList[[a]]) ){
    if( chapterURLS[a,3]  == "Chapter" && !grepl( "</div>", substr(jsonList[[a]][[b]], nchar(jsonList[[a]][[b]]) - 10, nchar(jsonList[[a]][[b]]))) ){
      print("Heyy")
      jsonList[[a]][[b]] <- paste(jsonList[[a]][[b]], "</div>",sep="")
      
    }else{
      print("this chapter has no unclosed div chapters ")
    }
  }
}


namecheck(jsonList)
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
for(a in 1: (length(jsonList) -1)){
  for(b in 1:length(jsonList[[a]])){
    if(names(jsonList[[a]][[b]])  == "R" && grepl(paste("install.packages"), jsonList[[a]][[b]]) && grepl("#",jsonList[[a]][[b]]) != TRUE){
      print(paste("There is a R code cell includes install.package:   ",a," :a ", b, " :b "))
      jsonList[[a]][[b]] <- gsub("install.packages","#install.packages",jsonList[[a]][[b]])
    }else{
        print(paste("There is no R code cell includes install.package",a," : ",b))
      }
  }
}




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
namecheck(jsonList)
#redirecting urls changing href="chaptername#subchaptername" to href = "#subchaptername"
for( a in 3: (length(jsonList) - 1 )){
  for( b in 1:length(jsonList[[a]]) ){
    if( names ( jsonList[[a]][[b]] ) == "HTML" && grepl( "href=", jsonList[[a]][[b]] )){
      
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
            names(jsonList[[a]][[b]] == "HTML")
            
          }else{
            temp[[i]] <- "lolo"
            print(paste("NNNNOOTTdone","A is:",a,"B is:", b, "I is:" ,i))
            
          }
          
          
          
        }
      
        
              }
      
      
      
    }
    
    }
  
}

namecheck(jsonList)


namecheck(jsonList)






#some fixed
jsonList[[68]][[1]] <- "<div id=\"code-style\"><h2>\n<span class=\"header-section-number\">6.3</span> Code style</h2>\n<p><em>removed in deference to material in <a href=\"https://style.tidyverse.org\" class=\"uri\">https://style.tidyverse.org</a>; see <a href=\"#122</a></em></p>\n<p>TL;DR = “Use the <a href=\"http://styler.r-lib.org\">styler package</a>”.</p>\n </div>" 
#jsonList[["7.1.2 Other dependencies"]]
namecheck(jsonList)





for( a in 3: ( length(jsonList) -1 ) ){
  for( b in 1:length(jsonList[[a]]) ){
    if( names ( jsonList[[a]][[b]] ) == "HTML" && grepl( "href=", jsonList[[a]][[b]] )){
      
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
            names(jsonList[[a]][[b]] == "HTML")
            
          }else{
            temp[[i]] <- "lolo"
            print(paste("NNNNOOTTdone","A is:",a,"B is:", b, "I is:" ,i))
            
          }
          
          
          
        }
        
        
      }
      
      
      
    }
    
  }
  
}
