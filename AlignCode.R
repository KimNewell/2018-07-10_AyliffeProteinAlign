library(msa)
library(tools)
#read in data
AAseq <- readAAStringSet("full_pathname")
DNAseq <- readDNAStringSet("full_pathname")
RNAseq <- readRNAStringSet("full_pathname")
#look at data
AAseq
DNAseq
RNAseq

#run alignment
AAseqAlign <- msa(AAseq)
DNAseqAlign <- msa(DNAseq)
RNAseqAlign <- mas(RNAseq)

#look at alignments
AAseqAlign
DNAseqAlign 
RNAseqAlign


#make a PDF file of the alignment to print
#To make a PDF file first have to make a 'tex' file then convert to 'pdf'

#Problem: pdf file doenst get saved in Results folder

msaPrettyPrint(AAseqAlign, output="tex", showNames="left", showLegend =FALSE,
               showLogo="none", askForOverwrite=FALSE, verbose=FALSE, file='results/AAseqAlign.tex')
texi2pdf('results/AAseqAlign.tex', clean=TRUE)

msaPrettyPrint(DNAseqAlign, output="tex", showNames="left",
               showLogo="none", askForOverwrite=FALSE, verbose=FALSE, file='results/DNAseqAlign.tex')
texi2pdf('results/DNAseqAlign.tex', clean=TRUE)


# myFirstAlignment <- as.matrix(myFirstAlignment)
# myFirstAlignment <- t(myFirstAlignment)
# myFirstAlignment <- as_tibble(myFirstAlignment)

#convert alignment to matrix
AAseqAlign_mat <- as.matrix(AAseqAlign)

#Tranform matrix to long form
AAseqAlign_mat <- t(AAseqAlign_mat)

#convert to tibble
AAseqAlign_tib <- as_tibble(AAseqAlign_mat)


#change row number to be a column and name it "position" using
# rownames_to_column() 
#Have to decide here whether to name the column or not - for later export
#better not to for table
AAseqAlign_tib2 <- rownames_to_column(AAseqAlign_tib2, var="position")

#check what it looks like

head(AAseqAlign_tib2, 20)

#count how many unique characters are in each line

AAseqAlign_tib2Count = apply(AAseqAlign_tib2,1, function(x) length(unique(na.omit(x))))
AAseqAlign_tib2Count

#Subset to make a tibble containing only >2 unique charachters
#NB one unique character will be the position number.
#
newdfBradi4g24315DNACount<- subset(dfBradi4g24315DNACount, count > 2)
newdfBradi4g24315DNACount
nrow(newdfBradi4g24315DNACount)


######
library(grid)    
library(gridExtra)  
df4 <- newdfBradi4g24315DNACount
df4
dim(df4) 

maxrow = 32 #good number of rows per page

npages = ceiling(nrow(df4)/maxrow)  #ceiling=roundup - to find number of pages    
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
write_csv(df4, path = "results/Brachy4g24315DNAtable.csv")

