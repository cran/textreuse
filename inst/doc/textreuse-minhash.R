## ---- echo=FALSE, message=FALSE------------------------------------------
library(dplyr)

## ------------------------------------------------------------------------
library(textreuse)
minhash <- minhash_generator(n = 240, seed = 3552)
head(minhash(c("turn tokens into", "tokens into hashes", "into hashes fast")))

## ------------------------------------------------------------------------
dir <- system.file("extdata/ats", package = "textreuse")
corpus <- TextReuseCorpus(dir = dir, tokenizer = tokenize_ngrams, n = 5,
                          hash_func = minhash, keep_tokens = TRUE)

## ------------------------------------------------------------------------
lsh_threshold(h = 200, b = 50)
lsh_threshold(h = 240, b = 80)

## ------------------------------------------------------------------------
lsh_probability(h = 240, b = 80, s = 0.25)
lsh_probability(h = 240, b =  80, s = 0.75)

## ------------------------------------------------------------------------
buckets <- lsh(corpus, bands = 80)
buckets

## ------------------------------------------------------------------------
candidates <- lsh_candidates(buckets)
candidates

## ------------------------------------------------------------------------
subset <- lsh_subset(candidates)
corpus_subset <- corpus[subset]
corpus_subset <- rehash(corpus_subset, hash_string)

## ------------------------------------------------------------------------
lsh_compare(candidates, corpus_subset, jaccard_similarity)

