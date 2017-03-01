install.packages("tidyverse")
install.packages("ggplot2")
install.packages("htmlwidgets")
library("ggplot2")
library("tidyverse")
library("stringr")
library(htmlwidgets)

#creates a tibble object holding the iris data
tb <- as_tibble(iris)

#ggplot of stuff for example
ggplot(data = tb) + geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width))

#View the tibble
View(tb)
tb[,1]

#filter data based on specific thingies
tb %>% filter(Sepal.Width > 3.0)
tb %>% filter(Species == "versicolor")

str_c("x", "y", sep = ", ")


#playing around with strings
name <- "J"
time_of_day <- "morning"
birthday <- TRUE

str_c(
  "Good ", time_of_day, " ", name,
  if (birthday) " and Happy birthday",
  "."
)

#playing around with regex
x <- c("apple", "banana", "pear")
str_view(x, ".a.")

str_c("begin", c("a", "b"), "end")


sentence <- stringr::sentences

match <- c("the")
has_match <- str_subset(sentences, match)
#prints a bunch of "the"s
matches <- str_extract(has_match, match)
matches

#Finds all the sentences with nouns, removes the sentences without
x <- tibble(sentence = sentences) %>%
  tidyr::extract(
    sentence, c('article', 'noun'), "(a|the) ([^ ]+)",
    remove = FALSE
  ) %>% 
na.omit()
