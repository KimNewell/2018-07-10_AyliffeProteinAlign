library(msa)
library(tools)
myProtSeq <- readAAStringSet("C:/Users/new163/Desktop/2018-07-10_AyliffeProteinAlign/data/KIM_prot.txt")
myProtSeq
myDNASeq <- readDNAStringSet("C:/Users/new163/Desktop/2018-07-10_AyliffeProteinAlign/data/KIMDNA.txt")
myDNASeq
ProtSeqAlign <- msa(myProtSeq)
ProtSeqAlign
DNASeqAlign <- msa(myDNASeq)
DNASeqAlign
# To make a PDF file first have to make a 'tex' file then convert to 'pdf'
msaPrettyPrint(ProtSeqAlign, output="tex", showNames="left", showLegend =FALSE,
               showLogo="none", askForOverwrite=FALSE, verbose=FALSE, file='results/ProtSeqAlign.tex')
texi2pdf('results/ProtSeqAlign.tex', clean=TRUE)
msaPrettyPrint(DNASeqAlign, output="tex", showNames="left",
               showLogo="none", askForOverwrite=FALSE, verbose=FALSE, file='results/DNASeqAlign.tex')
texi2pdf('results/DNASeqAlign.tex', clean=TRUE)

# myFirstAlignment <- msa(mySequences)
# myFirstAlignment <- as.matrix(myFirstAlignment)
# myFirstAlignment <- t(myFirstAlignment)
# myFirstAlignment <- as_tibble(myFirstAlignment)


ProtSeqAlign2 <- msa(myProtSeq)
ProtSeqAlign2 <- msa(myProtSeq)
ProtSeqAlign2 <- as.matrix(protSeqAlign2)
myFirstAlignment <- t(myFirstAlignment)
myFirstAlignment <- as_tibble(myFirstAlignment)