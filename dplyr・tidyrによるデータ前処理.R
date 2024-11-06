install.packages("tidyverse")
library(rvest)

kabu_url <- "https://kabutan.jp/stock/kabuka?code=0000"

url_res <- read_html(kabu_url)
url_res

scores_messy <- data.frame(
  名前 = c("a","b"),
  算数 = c(100,100),
  国語 = c(80,100),
  理科 = c(60,100),
  社会 = c(40,20)
)
library(tidyverse)
pivot_longer(scores_messy,
             cols = c(算数,国語,理科,社会),
             names_to ="教科",
             values_to = "得点"
)
