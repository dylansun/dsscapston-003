blog <- readLines("data/final/en_US/en_US.blogs.txt", encoding = "UTF-8")
blog.sub = sample(blog, 10000)
require(tm)
require(openNLP)
require(RWeka)
TriGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
BiGramTokenizer  <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
blog.vec <- VectorSource(blog.sub)
blog.corpus <- VCorpus(blog.vec, readerControl = list(language="en_US"))
blog.corpus <- tm_map(blog.corpus, stripWhitespace, lazy = T)
control <- list(tokenize = BiGramTokenizer, 
                removePunctuation = T,
                removeNumbers = T
)
TDM <- TermDocumentMatrix(blog.corpus, control)
