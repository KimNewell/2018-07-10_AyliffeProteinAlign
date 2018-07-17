library(msa)
library(tools)
library(tidyverse)
library(dplyr)
#read in DNA file
Bradi4g24315DNASeq <- readDNAStringSet("C:/Users/new163/Desktop/2018-07-10_AyliffeProteinAlign/data/Bradi4g24315DNA.txt")
#Look at file 
Bradi4g24315DNASeq
#run alignment
Bradi4g24315DNASeqAlign <- msa(Bradi4g24315DNASeq)
#Look at alignment
Bradi4g24315DNASeqAlign

#Make a PDF file to print alignment to.
#first have to make a 'tex' file then convert to 'pdf'
msaPrettyPrint(Bradi4g24315DNASeqAlign, output="tex", showNames="left", showLegend =FALSE,
               showLogo="none", askForOverwrite=FALSE, verbose=FALSE, file='Results/Bradi4g24315DNASeqAlign.tex')

#both of the paths below save the file but they both save the file up one level
texi2pdf('Results/Bradi4g24315DNASeqAlign.tex', clean=TRUE)
texi2pdf('C:/Users/new163/Desktop/2018-07-10_AyliffeProteinAlign/Results/Bradi4g24315DNASeqAligntesting.tex', clean=TRUE)


# Change to matrix, transform, make a tibble
Bradi4g24315DNASeqAlign <- as.matrix(Bradi4g24315DNASeqAlign)
Bradi4g24315DNASeqAlign


Bradi4g24315DNASeqAlign_t <- t(Bradi4g24315DNASeqAlign)
Bradi4g24315DNASeqAlign_t

Bradi4g24315DNASeqAlign_t_tib <- as_tibble(Bradi4g24315DNASeqAlign_t)
Bradi4g24315DNASeqAlign_t_tib

#change row number to be a column and name it "pos" using
# rownames_to_column() 
Bradi4g24315DNASeqAlign_t_tib <- rownames_to_column(Bradi4g24315DNASeqAlign_t_tib, var="pos")

Bradi4g24315DNASeqAlign_t_tib

#count the number of unique characters in each row
UniqueCount = apply(Bradi4g24315DNASeqAlign_t_tib,1, function(x) length(unique(na.omit(x))))
UniqueCount

#Add UniqueCount column to Bradi4g24315DNASeqAlign_t_tib
Bradi4g24315DNAUniqueCount <- cbind(Bradi4g24315DNASeqAlign_t_tib, UniqueCount)

#Look at Bradi4g24315DNAUniqueCount
Bradi4g24315DNAUniqueCount

#make a subset of Bradi4g24315DNAUniqueCount containing only rows with a 
#unique count greater than 2
newBradi4g24315DNAUniqueCount <- subset(Bradi4g24315DNAUniqueCount, UniqueCount > 2)
newBradi4g24315DNAUniqueCount
nrow(newBradi4g24315DNAUniqueCount)


######
library(grid)    
library(gridExtra)  
#give tibble a simple name
df4 <- newBradi4g24315DNAUniqueCount
df4
dim(df4) 

#set max number of rows to fit on one page
maxrow = 38
#determine how many pages needed
npages = ceiling(nrow(df4)/maxrow)
#open pdf file
pdf('results/Bradi4g24315DNAtable.pdf', height = 50, width = 8.5) 

#this creates an index, a seq from 1 to max number of rows
idx = seq(1, maxrow)

#create table from df4
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
  #dev.off()
}
dev.off() #- the code I copied had this here - but it was suggested elsewher
#to put it inside the {}. I've tried both. Inside gives me one page. Outside I get 
#2pages but still the startof the table is missing

#write table to a csv file (this gets written to Results folder)
#but its only the last part of the table
write_csv(df4, path = "results/Bradi4g24315DNAtable.csv")

