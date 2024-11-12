# install.packages("RMeCab", repos = "https://rmecab.jp/R")
# install.packages("wordcloud2")
library(wordcloud2)
library(RMeCab)
library(tidyr)
library(dplyr)
source("http://rmecab.jp/R/Aozora.R")
kenji <- Aozora("https://www.aozora.gr.jp/cards/000081/files/43754_ruby_17594.zip")

chumon <- readLines(kenji)
chumon %>% head()

# 冒頭の２行にタイトルと著者名があるので消す
chumon <- chumon[-(1:2)]

# ファイルの上書き
chumon %>%  writeLines(kenji)

# gcを利用すると
# 未使用のオブジェクトがメモリから解放され、データ処理が軽くなる。
# type = 1だと単語ごとに分割、type = 0 だと文字ごとに分割
gc();gc()
chumon_df <- docDF(kenji , type = 1 , pos = c("名詞","形容詞","動詞") , )

chumon_df %>% arrange(chumonno_oi_ryoriten2.txt) %>% 
  tail()

print(kenji) 

# filterにより「二」と「人」をくっつける
chumon_df %>% filter(TERM == "二人")

# make wordcloud with two ways
chumon_df %>% arrange(chumonno_oi_ryoriten2.txt) %>% 
  select(TERM , chumonno_oi_ryoriten2.txt) %>% 
  tail(100) %>% 
  wordcloud2()

chumon_words100 <- chumon_df %>% 
  arrange(chumonno_oi_ryoriten2.txt) %>% 
  tail(100) %>% select(TERM , FREQ = chumonno_oi_ryoriten2.txt)
chumon_words100 %>% wordcloud2()



