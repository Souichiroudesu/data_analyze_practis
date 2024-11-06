
url_title <- html_element(url_res, css = "head > title")
url_title
title <- html_text(url_title)
title

title2 <- read_html(kabu_url) %>% 
html_element(css = "title") %>% 
html_text()  
title2

kabuka <- read_html(kabu_url) %>% 
html_element(xpath = "//*[@id='stock_kabuka_table']/table[2]") %>% 
html_table()
head(kabuka)

urls <- NULL
kabukas <-list()

base_url <- "https://kabutan.jp/stock/kabuka?code=0000&ashi=day&page="

for(i in 1:5){
  #ページ番号付きのURLを作成
  pgnum <- as.character(i)
  urls[i] <- paste0(base_url,pgnum)
  
  #それぞれのURLにスクレイピングを実行
  kabukas[[i]] <- read_html(urls[i])%>%
    html_element(xpath = "//*[@id='stock_kabuka_table']/table[2]") %>% 
    html_table() %>% 
    #前日比の列はいったん文字列に変換
    dplyr::mutate(前日比 = as.character(前日比))
  #1ページ取得したら1秒停止
  Sys.sleep(1)
}

dat <- dplyr::bind_rows(kabukas)
dat

install.packages("rtweet")
library(rtweet)

create_token(  
  app = "YOUR_APP_NAME",  
  consumer_key = "YOUR_CONSUMER_KEY",  
  consumer_secret = "YOUR_CONSUMER_SECRET",  
  access_token = "YOUR_ACCESS_TOKEN",  
  access_secret = "YOUR_ACCESS_SECRET"  
)  


rt <- search_tweets(
  q ="技術評論社", n=100, include_rts = FALSE
)
print(rt)