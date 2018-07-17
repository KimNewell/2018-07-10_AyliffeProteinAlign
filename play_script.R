library(msa)
library(tools)
library(tidyverse)
library(dplyr)
test <- readAAStringSet("C:/Users/new163/Desktop/2018-07-10_AyliffeProteinAlign/data/Bradi4g24315Prot.txt")
test
testAlign <- msa(test)
testAlign



# To make a PDF file first have to make a 'tex' file then convert to 'pdf'
msaPrettyPrint(testAlign, output="tex", showNames="left", showLegend =FALSE,
               showLogo="none", askForOverwrite=FALSE, verbose=FALSE, file='results/testAlign.tex')
texi2pdf('results/testAlign.tex', clean=TRUE)
#msaPrettyPrint(DNASeqAlign, output="tex", showNames="left",
#              showLogo="none", askForOverwrite=FALSE, verbose=FALSE, file='results/DNASeqAlign.tex')
#texi2pdf('results/DNASeqAlign.tex', clean=TRUE)


# Change to matrix, transform, make a tibble
testAlignMatrix <- as.matrix(testAlign)
testAlignMatrix


testAlignMatrix_t <- t(testAlignMatrix)
testAlignMatrix_t

testAlignMatrix_t_tib <- as_tibble(testAlignMatrix_t)
testAlignMatrix_t_tib
# rownames_to_column()

#Bradi4g24315ProtSeqAlign_t_t <- rownames_to_column(Bradi4g24315ProtSeqAlign_t_t, var="position")
#rownames_to_column(Bradi4g24315ProtSeqAlign_t_t, var="pos")
rownames_to_column(testAlignMatrix_t_tib)
rowToColtestAlignMatrix_t_tib <- rownames_to_column(testAlignMatrix_t_tib, var = "pos")
rowToColtestAlignMatrix_t_tib
testAlignMatrix_t_tib


#dfBradi4g24315Prot_test = apply(Bradi4g24315ProtSeqAlign_t_t,1, function(x) length(unique(na.omit(x))))

unique_countrowToColtestAlignMatrix_t_tib <- apply(rowToColtestAlignMatrix_t_tib,1, function(x) length(unique(na.omit(x))))
unique_counttestAlignMatrix_t_tib <- apply(testAlignMatrix_t_tib,1, function(x) length(unique(na.omit(x))))

unique_countrowToColtestAlignMatrix_t_tib
unique_counttestAlignMatrix_t_tib


count1 <- unique_countrowToColtestAlignMatrix_t_tib
count2 <- unique_counttestAlignMatrix_t_tib 

count1
count2

#dfBradi4g24315Count_test <- cbind(Bradi4g24315ProtSeqAlign_t_t, unique_count = apply(Bradi4g24315ProtSeqAlign_t_t, 1, function(x)length(unique(x))))
df_combine_test1 <- cbind(rowToColtestAlignMatrix_t_tib, count1)
df_combine_test2 <- cbind(testAlignMatrix_t_tib, count2)



df_combine_test1
df_combine_test2


df_combine_test1_subset <-subset(df_combine_test1, count1 > 2)
df_combine_test2_subset <- subset(df_combine_test2, count2 > 1)

df_combine_test1_subset
df_combine_test2_subset
nrow(df_combine_test1_subset)
nrow(df_combine_test2_subset)

smallSubset <- subset(df_combine_test1, count==3)
smallSubset
df_combine_test1




######
library(grid)    
library(gridExtra)
#call df with shorter name and look at the dimensions to find out the maxrow
#df3 <- df_combine_test2_subset 
#df3
#dim(df3) 
##########################################################
##Mucking around with the pdf function to get more pages
##########################################################

#########################################################
df4 <- df_combine_test1

df_combine_test1
df4
nrow(df4) #199
ncol(df4)

maxrow = 199
npages = ceiling(nrow(df4)/maxrow)      
pdf("results/Play4.pdf", height = 11, width = 8.5)  
idx = seq(1, nrow(df4))  
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
#########################################################
df4 <- df_combine_test1

df_combine_test1
df4
nrow(df4) #199
ncol(df4)
maxrow = 30 #specifies the max number of rows on a page

npages = ceiling(nrow(df4)/maxrow) #ceiling rounds up

pdf("results/playpdf3.pdf", height = 11, width = 8.5)  #open pdf document



idx = seq(1, nrow(df4))  #creates sequence of 1 to maxrow)

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

#make a grid.table
maxrow = 32
npages = ceiling(nrow(df3)/maxrow) 
#make an open pdf file in results folder
#pdf("results/newfile.pdf", height = 11, width = 8.5) 
pdf("results/playpdf.pdf",onefile = FALSE,  height = 11, width = 8.5) 
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
#dev.off() - this closes the pdf file

#create a csv file as well - write_csv(surveys_complete, path = "data_output/surveys_complete.csv")

write_csv(df3, path = "results/playcsv.csv")

