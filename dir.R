#! /usr/bin/env/ Rscript
df <- file.info(dir())
BookNames <-rownames(df[df$isdir == TRUE,])

print(BookNames)
