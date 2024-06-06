# connecting to the tidytuesday API 

library(tidytuesdayR)
tuesdata <- tt_load('2021-04-20')
netflix <- tuesdata$netflix_titles

library(dplyr)
library(stringr)
library(tidytext)

#looking at the data:
View(netflix[1:40,])

unique(netflix$title)
unique(netflix$country)

# renaming unstructed data as text :

colnames(netflix)[12] <- "text"

#tokenizing 

tidy_netflix <- netflix %>%
                  unnest_tokens(word , text)

tidy_netflix %>%
  count(word, sort=TRUE)

data(stop_words)
netflix_no_stop <- tidy_netflix %>%
                    anti_join(stop_words)

netflix_no_stop %>%
  count(word, sort=TRUE)

# visualize the frequency table

library(ggplot2)
 netflix_no_stop %>%
   count(word, sort=TRUE) %>%
   filter(n>200) %>% 
   mutate(word=reorder(word, n)) %>%
   ggplot(aes(word,n))+
   geom_col()+
   xlab(NULL)+
   coord_flip()










