library(tm)
library(SnowballC)
library(wordcloud)
library(stringr)
library(RColorBrewer)

wordcloudfun = function(x)
{
  #Create Corpus
  ncorpus = Corpus(VectorSource(x))
  #Convert words to lower
  ncorpus = tm_map(ncorpus, tolower)
  #Remove stop words
  ncorpus = tm_map(ncorpus, removeWords, stopwords('english'))
  #Remove punctuation
  ncorpus = tm_map(ncorpus, removePunctuation)
  #Remove numbers
  ncorpus = tm_map(ncorpus, removeNumbers)
  #Remove white space
  ncorpus = tm_map(ncorpus, stripWhitespace)
  #Convert Corpus into Plain Text
  ncorpus = tm_map(ncorpus, PlainTextDocument)
  return(ncorpus)
}