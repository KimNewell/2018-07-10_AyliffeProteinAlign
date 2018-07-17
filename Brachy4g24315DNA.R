library(msa)
library(tools)
library(tidyverse)
library(dplyr)
Bradi4g24315DNASeq <- readDNAStringSet("C:/Users/new163/Desktop/2018-07-10_AyliffeProteinAlign/data/Bradi4g24315DNA.txt")
Bradi4g24315DNASeq
Bradi4g24315DNASeqAlign <- msa(Bradi4g24315DNASeq)


# To make a PDF file first have to make a 'tex' file then convert to 'pdf'
msaPrettyPrint(Bradi4g24315DNASeqAlign, output="tex", showNames="left", showLegend =FALSE,
               showLogo="none", askForOverwrite=FALSE, verbose=FALSE, file='results/Brachy4g24315DNASeqAlign.tex')
texi2pdf('results/Brachy4g24315DNASeqAlign.tex', clean=TRUE)



#msaPrettyPrint(DNASeqAlign, output="tex", showNames="left",
#              showLogo="none", askForOverwrite=FALSE, verbose=FALSE, file='results/DNASeqAlign.tex')
#texi2pdf('results/DNASeqAlign.tex', clean=TRUE)


# Change to matrix, transform, make a tibble
Bradi4g24315DNASeqAlign <- as.matrix(Bradi4g24315DNASeqAlign)
Bradi4g24315DNASeqAlign


Bradi4g24315DNASeqAlign_t <- t(Bradi4g24315DNASeqAlign)
Bradi4g24315DNASeqAlign_t

Bradi4g24315DNASeqAlign_t_t <- as_tibble(Bradi4g24315DNASeqAlign_t)
Bradi4g24315DNASeqAlign_t_t

#change row number to be a column and name it "position" using
# rownames_to_column() 
Bradi4g24315DNASeqAlign_t_t <- rownames_to_column(Bradi4g24315DNASeqAlign_t_t, var="position")

head(Bradi4g24315DNASeqAlign_t_t, 20)

dfBradi4g24315DNA = apply(Bradi4g24315DNASeqAlign_t_t,1, function(x) length(unique(na.omit(x))))
dfBradi4g24315DNA


dfBradi4g24315DNACount <- cbind(Bradi4g24315DNASeqAlign_t_t, count = apply(Bradi4g24315DNASeqAlign_t_t, 1, function(x)length(unique(x))))
dfBradi4g24315DNACount
tail(dfBradi4g24315DNACount)
newdfBradi4g24315DNACount<- subset(dfBradi4g24315DNACount, count > 2)
newdfBradi4g24315DNACount
nrow(newdfBradi4g24315DNACount)


######
library(grid)    
library(gridExtra)  
df4 <- newdfBradi4g24315DNACount
df4
dim(df4) 

maxrow = 102 
npages = ceiling(nrow(df4)/maxrow)      
pdf("results/Brachy4g24315DNAtabletemp.pdf", height = 50, width = 8.5)  
idx = seq(1, maxrow)  
grid.table(df4[idx,],rows = rownames(df4))  
for(i in 2:npages){
  grid.newpage();
  if(i*maxrow <= nrow(df4)){
    idx = seq(1+((i-1)*maxrow), i * maxrow)
  }
  else{
    idx = seq(1+((i-1)*maxrow), nrow(df4))
  }
  grid.table(df4[idx, ],rows = NULL)
  dev.off()
}
#dev.off()

