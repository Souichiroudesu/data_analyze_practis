getwd()
system.time(
  dat <- read.csv("Sales.csv")
)
str(dat)
library(tidyverse)
dat2 <- read.csv("Sales.csv")
str(dat2)
system.time(dat2 <- read.csv("Sales.csv"))
dat2 <- read.csv("Sales.csv",
                 col_types = cols(
                   col_character(),
                   col_character(),
                   col_datetime()
                 ))

dat2 <- read.csv("Sales.csv",
                 col = 'ccT')
product <- read.csv("SampleData-master/csv/Products.csv")
head(product)
