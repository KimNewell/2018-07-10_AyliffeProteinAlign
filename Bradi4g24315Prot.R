library(msa)
library(tools)
library(tidyverse)
library(dplyr)
Bradi4g24315ProtSeq <- readAAStringSet("C:/Users/new163/Desktop/2018-07-10_AyliffeProteinAlign/data/Bradi4g24315Prot.txt")
Bradi4g24315ProtSeq
Bradi4g24315ProtSeqAlign <- msa(Bradi4g24315ProtSeq)
Bradi4g24315ProtSeqAlign


# To make a PDF file first have to make a 'tex' file then convert to 'pdf'
msaPrettyPrint(Bradi4g24315ProtSeqAlign, output="tex", showNames="left", showLegend =FALSE,
               showLogo="none", askForOverwrite=FALSE, verbose=FALSE, file='results/Bradi4g24315ProtSeqAlign.tex')
texi2pdf('results/Bradi4g24315ProtSeqAlign.tex', clean=TRUE)


# Change to matrix, transform, make a tibble
Bradi4g24315ProtSeqAlign <- as.matrix(Bradi4g24315ProtSeqAlign)
Bradi4g24315ProtSeqAlign


Bradi4g24315ProtSeqAlign_t <- t(Bradi4g24315ProtSeqAlign)
Bradi4g24315ProtSeqAlign_t

Bradi4g24315ProtSeqAlign_t_tib <- as_tibble(Bradi4g24315ProtSeqAlign_t)
Bradi4g24315ProtSeqAlign_t_tib

# rownames_to_column()
Bradi4g24315ProtSeqAlign_t_tib <- rownames_to_column(Bradi4g24315ProtSeqAlign_t_tib, var="pos")
Bradi4g24315ProtSeqAlign_t_tib

#Count unique characters in each row
Bradi4g24315Prot = apply(Bradi4g24315ProtSeqAlign_t_tib,1, function(x) length(unique(na.omit(x))))
Bradi4g24315Prot
#Add unique count column to tibble
Bradi4g24315ProtCount <- cbind(Bradi4g24315ProtSeqAlign_t_tib, count = apply(Bradi4g24315ProtSeqAlign_t_tib, 1, function(x)length(unique(x))))
Bradi4g24315ProtCount
#make a subset with only unique characters >2
newBradi4g24315ProtUniqueCount <- subset(Bradi4g24315ProtCount, count > 2)
newBradi4g24315ProtUniqueCount
nrow(newBradi4g24315ProtUniqueCount)


######
library(grid)    
library(gridExtra)  
df3 <- newBradi4g24315ProtUniqueCount
df3
dim(df3)  
maxrow = 32  
npages = ceiling(nrow(df3)/maxrow)      
pdf("results/Bradi4g24315Prot_table.pdf", height = 11, width = 8.5)  
idx = seq(1, maxrow)  
grid.table(df3[idx,],rows = rownames(df3))  
for(i in 2:npages){
  grid.newpage();
  if(i*maxrow <= nrow(df3)){
    idx = seq(1+((i-1)*maxrow), i * maxrow)
  }
  else{
    idx = seq(1+((i-1)*maxrow), nrow(df3))
  }
  grid.table(df3[idx, ],rows = NULL)
  dev.off()
}
#dev.off()
#write_csv(surveys_complete, path = "data_output/surveys_complete.csv")

write_csv(df3, path = "results/Bradi4g24315Prottable.csv")
