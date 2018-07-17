library(msa)
library(tools)
library(tidyverse)
library(dplyr)
myProtSeq <- readAAStringSet("C:/Users/new163/Desktop/2018-07-10_AyliffeProteinAlign/data/KIM_prot.txt")
myProtSeq
ProtSeqAlign2 <- msa(myProtSeq)
# Change to matrix, transform, make a tibble
ProtSeqAlign2 <- as.matrix(ProtSeqAlign2)
ProtSeqAlign2
ProtSeqAlign2_t <- t(ProtSeqAlign2)
ProtSeqAlign2_t

ProtSeqAlign2_t_t <- as_tibble(ProtSeqAlign2_t)
ProtSeqAlign2_t_t
# rownames_to_column()
rownames_to_column(ProtSeqAlign2_t_t, var="rowname")
head (ProtSeqAlign2_t_t, 20)

df1 = apply(ProtSeqAlign2_t_t,1, function(x) length(unique(na.omit(x))))
df1
dfCount <- cbind(ProtSeqAlign2_t_t, count = apply(ProtSeqAlign2_t_t, 1, function(x)length(unique(x))))
dfCount
newdfCount <- subset(dfCount, count > 1)
newdfCount
nrow(newdfCount)

######
library(grid)    
library(gridExtra)  
df2 <- newdfCount
df2
dim(df2)  
maxrow = 31  
npages = ceiling(nrow(df2)/maxrow)      
pdf("results/test2.pdf", height = 11, width = 8.5)  
idx = seq(1, maxrow)  
grid.table(df2[idx,],rows = rownames(df2))  
for(i in 2:npages){
  grid.newpage();
  if(i*maxrow <= nrow(df2)){
    idx = seq(1+((i-1)*maxrow), i * maxrow)
  }
  else{
    idx = seq(1+((i-1)*maxrow), nrow(df2))
  }
  grid.table(df2[idx, ],rows = NULL)
  dev.off()
}
#dev.off()
#below write to a csv file but doent have position number
write_csv(df2, path = "results/protTest.csv")
