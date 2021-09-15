getwd()
install.packages("tm") # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator
install.packages("RColorBrewer") # color palettes
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
# Load the data
text <- readLines(file.choose())
text
# Load the data as a Corpus
?Corpus()
?VectorSource()

docs <- Corpus(VectorSource(text))
docs

# Inspect the content of the document
?inspect()
inspect(docs)

# Text Transformation
# tm_map()
?tm_map()
# Replace special characters from the text "/", "@", and "|"
?content_transformer()
?gsub()
tospace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
tospace

docs <- tm_map(docs, tospace, "/")
docs <- tm_map(docs, tospace, "@")
docs <- tm_map(docs, tospace, "\\|")

# stop-words

# Convert the text
docs <- tm_map(docs, content_transformer(tolower))
# Remove number
docs <- tm_map(docs, removeNumbers)
# REMOVE COMMON STOP WORDS
docs <- tm_map(docs, removeWords, stopwords("english"))
# Specify stopwords
docs <- tm_map(docs, removeWords, c("all", "not"))
# Remove punctuation
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
docs
dtm <- TermDocumentMatrix(docs)
dtm
m <- as.matrix(dtm)
m
v <- sort(rowSums(m), decreasing = TRUE)
v
d <- data.frame(word = names(v), freq = v)
head(d, 10)

wordcloud(d$word, d$freq, min.freq = 1, max.words = 300, random.order = FALSE, rot.per = 0.35, colors = brewer.pal(8, "Dark2"))
