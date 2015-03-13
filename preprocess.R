load("sub.RData")
require(tm)
require(openNLP)
require(RWeka)

##doc.raw <- c(blog.sub, news.sub, twitter.sub)
##blog.raw <- MC_tokenizer(blog.sub)
TriGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
BiGramTokenizer  <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
blog.vec <- VectorSource(blog.sub)
blog.corpus <- VCorpus(blog.vec, readerControl = list(language="en_US"))


#blog.corpus <- tm_map(blog.corpus, content_transformer(tolower), lazy = T)
#blog.corpus <- tm_map(blog.corpus, content_transformer(removePunctuation), lazy = T)
#blog.corpus <- tm_map(blog.corpus, content_transformer(removeNumbers), lazy = T)

## why this not work? aftr lazy=T, no warning messages!!!
## check this thread http://stackoverflow.com/questions/25069798/r-tm-in-mclapplycontentx-fun-all-scheduled-cores-encountered-errors
## removeWords doesnt work
## Stop words should not be remove
## blog.corpus<- tm_map(blog.corpus, content_transformer(removeWords), stopwords("en"), lazy = T)
##blog.corpus<- tm_map(blog.corpus, content_transformer(stemDocument), lazy = T)
##blog.corpus<- tm_map(blog.corpus, content_transformer(stripWhitespace), lazy = T)
blog.corpus <- tm_map(blog.corpus, stripWhitespace, lazy = T)
control <- list(tokenize = BiGramTokenizer, 
                removePunctuation = T,
                removeNumbers = T
                )
TDM <- TermDocumentMatrix(blog.corpus, control)
inspect(TDM[1:10,1:10])

