install.packages("rmarkdown")
library(msa)
library(tools)
library(tidyverse)
library(dplyr)

myDNASeq <- readDNAStringSet("C:/Users/new163/Desktop/2018-07-10_AyliffeProteinAlign/data/KIMDNA.txt")
myDNASeq
DNASeqAlign <- msa(myDNASeq)
# Change to matrix, transform, make a tibble
DNASeqAlign <- as.matrix(DNASeqAlign)
DNASeqAlign
DNASeqAlign_t <- t(DNASeqAlign)
DNASeqAlign_t

DNASeqAlign_t_t <- as_tibble(DNASeqAlign_t)
DNASeqAlign_t_t
# rownames_to_column()
rownames_to_column(DNASeqAlign_t_t, var="rowname")
head (DNASeqAlign_t_t, 20)

DNAdftest = apply(DNASeqAlign_t_t,1, function(x) length(unique(na.omit(x))))
DNAdftest
DNAdfCount <- cbind(DNASeqAlign_t_t, count = apply(DNASeqAlign_t_t, 1, function(x)length(unique(x))))
DNAdfCount
newDNAdfCount <- subset(DNAdfCount, count > 1)
newDNAdfCount
nrow(newDNAdfCount)

library(knitr)
library(DT)
library(xtable)
library(lemon)
kable(head(newDNAdfCount))
knit_print.data.frame <- lemon_print

