TEXTFILE = "data/pg100.txt"
if (!file.exists(TEXTFILE)) {     
  download.file("http://www.gutenberg.org/cache/epub/100/pg100.txt", destfile = TEXTFILE)
  }
shakespeare = readLines(TEXTFILE)
length(shakespeare)

head(shakespeare)
tail(shakespeare)

shakespeare = shakespeare[-(1:173)]
shakespeare = shakespeare[-(124195:length(shakespeare))]
shakespeare = paste(shakespeare, collapse = " ")
nchar(shakespeare)

shakespeare = strsplit(shakespeare, "<<[^>]*>>")[[1]]
length(shakespeare)
dramatics.personae <- grep("Dramatis Personae", shakespeare, ignore.case = T)
length(shakespeare)
shakespeare = shakespeare[-dramatics.personae]
length(shakespeare)
library(tm)
doc.vec <- VectorSource(shakespeare)
doc.corpus <- Corpus(doc.vec)
summary(doc.corpus)
## http://stackoverflow.com/questions/25551514/termdocumentmatrix-errors-in-r
## suggest add content_transformer, but without any explanation
doc.corpus <- tm_map(doc.corpus, content_transformer(tolower), lazy = T)
doc.corpus <- tm_map(doc.corpus, content_transformer(removePunctuation), lazy = T)
doc.corpus <- tm_map(doc.corpus, content_transformer(removeNumbers), lazy = T)

## why this not work? aftr lazy=T, no warning messages!!!
## check this thread http://stackoverflow.com/questions/25069798/r-tm-in-mclapplycontentx-fun-all-scheduled-cores-encountered-errors
## removeWords doesnt work
doc.corpus <- tm_map(doc.corpus, content_transformer(removeWords), stopwords("en"), lazy = T)

library(SnowballC)
doc.corpus <- tm_map(doc.corpus, content_transformer(stemDocument), lazy = T)
doc.corpus <- tm_map(doc.corpus, content_transformer(stripWhitespace), lazy = T)
inspect(doc.corpus[8])

TDM <- TermDocumentMatrix(doc.corpus)
inspect(TDM[1:10,1:10])
findFreqTerms(TDM, 2000)
findAssocs(TDM, "love", .8)
TDM.commom = removeSparseTerms(TDM, sparse = .1)
dim(TDM)
dim(TDM.commom)
inspect(TDM.commom[1:10,1:10])
library(slam)
TDM.dense <- as.matrix(TDM.commom)
library(reshape2)
TDM.dense = melt(TDM.dense, value.name = "count")
head(TDM.dense)
library(ggplot2)
ggplot(TDM.dense, aes(x = Docs, y = Terms, fill = log10(count))) +
       geom_tile(colour = "white") +
       scale_fill_gradient(high="#FF0000" , low="#FFFFFF")+
       ylab("") +
       theme(panel.background = element_blank()) +
       theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

