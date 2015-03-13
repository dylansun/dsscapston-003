##blog_dat <- read.table("~/Documents/coursera/Data-Sci/dsscapstone003/data/final/en_US/en_US.blogs.txt", head = F, sep = "\n",stringsAsFactors = F)
blog <- readLines("~/Documents/coursera/Data-Sci/dsscapstone003/data/final/en_US/en_US.blogs.txt", encoding = "UTF-8")
news <- readLines("~/Documents/coursera/Data-Sci/dsscapstone003/data/final/en_US/en_US.news.txt", encoding = "UTF-8")
twitter <- readLines("~/Documents/coursera/Data-Sci/dsscapstone003/data/final/en_US/en_US.twitter.txt", encoding = "UTF-8")

## The blog is written by diff people
blog.max.line <- max(nchar(blog))
## The news articles are usually well editted, cannot be too long
news.max.line <- max(nchar(news))
## As expected, the max length of twitter is limited to 140
twitter.max.line <- max(nchar(twitter))

## love hate rate in twitter about 4
rate.love.hate <- length(grep("love", twitter)) / length(grep("hate",twitter))

biostats <- grep("biostats", twitter)
twitter[biostats]

q1.6<-length(grep("A computer once beat me at chess, but it was no match for me at kickboxing", twitter))
save(blog, file = "blog.RData")
save(twitter, file = "twitter.RData")
save(news, file = "news.RData")

blog.sub = sample(blog, 10000)
news.sub = sample(news, 10000)
twitter.sub = sample(twitter, 10000)
save(blog.sub, news.sub, twitter.sub, file = "sub.RData")

