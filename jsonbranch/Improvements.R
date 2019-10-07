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





##Comment the install.packages code
for(a in 1:length(jsonList)){
  for(b in 1:length(jsonList[[a]])){
    if(names(jsonList[[a]][[b]])  == "R" && grepl(paste("install.packages"), jsonList[[a]][[b]])){
      print(paste("this html cell acting like as a R code",a," :a ", b, " :b "))
      jsonList[[a]][[b]] <- gsub("install.packages","#install.packages",jsonList[[a]][[b]])
      }
  }
}





