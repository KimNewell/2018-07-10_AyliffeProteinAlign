library(msa)
library(tools)
library(tidyverse)
library(dplyr)
myProtSeq <- readAAStringSet("C:/Users/new163/Desktop/2018-07-10_AyliffeProteinAlign/data/KIM_prot.txt")
myProtSeq
ProtSeqAlign2 <- msa(myProtSeq)
# myFirstAlignment <- msa(mySequences)
# myFirstAlignment <- as.matrix(myFirstAlignment)
# myFirstAlignment <- t(myFirstAlignment)
# *myFirstAlignment <- as_tibble(myFirstAlignment) *NB used as.table instead

ProtSeqAlign2 <- as.matrix(ProtSeqAlign2)
ProtSeqAlign2
ProtSeqAlign2_t <- t(ProtSeqAlign2)
ProtSeqAlign2_t

ProtSeqAlign2_t_t <- as.tibble(ProtSeqAlign2_t)
ProtSeqAlign2_t_t
# rownames_to_column()
rownames_to_column(ProtSeqAlign2_t_t, var="rowname")
head (ProtSeqAlign2_t_t, 20)
#distinct(ProtSeqAlign2_t_t)
#ProtSeqAlign2_t_t_dist <- ProtSeqAlign2_t_t %>% filter(!all_the_same)
#ProtSeqAlign2_t_t_dist
##Work out the rows to keep
##dd is your data frame
#rows = apply(ProtSeqAlign2_t_t[,], 1, function(i) length(unique(i)))
#ProtSeqAlign2_t_t[rows,]
#ProtSeqAlign2_t_t
#keep <- apply(ProtSeqAlign2_t_t[2:7], 1, function(x) length(unique(x[!is.na(x)])) != 1)
#keep
#ProtSeqAlign2_t_t[which(ProtSeqAlign2_t_t$REAL_ABR6==hg19$v8),]
small <- ProtSeqAlign2_t_t
small
#small_2 <- small[which(small$REAL_ABR6==small$`13K`==small$`10H`==small$luc1==small$Tek4==small$Tek2==small$Bd21)]
small_2 <- small(length(unique(ROW) ) > 1
small[ apply( small, 1, function(x)length(unique(x))>1) ]           
rowSel <- sapply(small, function(x) length(unique(x))==1 )
small[ , !rowSel ]
df3 = apply(ProtSeqAlign2_t_t,1, function(x) length(unique(na.omit(x))))
df3
small[,sapply(small,function(x) length(unique(x)) > 1)]
small
