install.packages('tidyverse')
library(tidyverse)

#mutates the data
table1 %>% mutate(rate = cases/population * 10000)
#counts the data
table1 %>% count(year, wt=cases)
#gathers two columns and merges them into one which we dubbed year and the column cases which holds the value
table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
table4b %>%
  gather(`1999`, `2000`, key="year", value="population")
table2 %>%
  spread(key= type, value=count)

#exercise
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>%
  spread(year, return) %>%
  gather('year',"return", `2015`:`2016`) %>%
  select(year, half, return)

#exercise
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
#tided it up by gathering gender together under one column
preg %>%
  gather(male, female, key="gender", value="population")

table3 %>%
  separate(rate, into=c("cases", "population"), sep="/")

#separate for practice on unite
table3 %>%
  separate(year, into=c("century", "year"), sep=2) %>%
  unite(new, century, year, sep="")

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>%
  separate(x, c("one", "two", "three"), fill="right")

tidyr::who
who_dt <- tidyr::who

tibble::glimpse(who_dt)
#get rid of the iso2 and iso3 columns
who_dt$iso2 <- NULL
who_dt$iso3 <- NULL
tibble::glimpse(who_dt)
#gather all of these
who1 <- who_dt %>%
  gather(new_sp_m014:newrel_f65, key="key", value="cases")
who1 %>% count(key)
#we have a weird anomaly, so we fix it
who2 <- who1 %>%
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
#create three new columns -- new, type, and genderage
who3 <- who2 %>%
  separate(key, c("new", "type", "genderage"), sep="_")
#get rid of the new column
who4 <- who3 %>%
  select(-new)
#seperate the genderage column into a gender and age column
who5 <- who4 %>%
  separate(genderage, c("gender", "age"), sep=1)
#changed all na's to 0 since that's what they REALLY represent.
who5[is.na(who5)] <- 0
#print the tidied result
who5
#summarize function
who5 %>%
  group_by(country) %>%
  summarize( total_cases =sum(cases),
             min_cases = min(cases),
             max_cases = max(cases))
#count the number of genders from each country
who5 %>%
  group_by(country) %>%
  count(gender)
