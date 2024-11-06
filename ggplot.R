library(tidyverse)
ggplot() +
  geom_histogram(data = mpg,mapping = aes(x = displ))
ggplot() +
  geom_density(data = mpg,mapping = aes(x = displ))

ggplot() +
  geom_point(data = mpg,mapping = aes(x = displ, y = cty)) +
  geom_smooth(data = mpg,mapping = aes(x = displ, y = cty),method = "lm")

mpg1999 <- filter(mpg,year == 1999)
mpg2008 <- filter(mpg,year == 2008)

ggplot(mapping = aes(x = displ,y = cty)) +
  geom_point(data = mpg1999,col = "red")+
  geom_point(data = mpg2008)


# グラフの肉付け
add_x <- c(2.5,3,3.5)
add_y <- c(25,27.5,30)

ggplot(
  data = mpg,mapping = aes(x = displ,y = cty))+
  geom_point()+
  annotate(geom = "point",x = add_x,y = add_y,colour = "red")+
  annotate(geom = "text",x = c(5,5),y =　c(30,25),label = c("要チェック！"
                                                         ,"赤色のデータを追加"))
# 水準ごとにエステティックを区別する
# ~の右に区別するデータを入れる
# facet_wrap()は均等に
ggplot(data = mpg , mapping = aes(x = displ , y = cty))+
  geom_point()+
  facet_wrap( ~ cyl)

# facet_grid( ~ データ)は横並び
ggplot(data = mpg , mapping = aes(x = displ , y = cty))+
  geom_point()+
  facet_grid( ~ cyl)
  
# facet_null(　データ　~ .)は縦並び
ggplot(data = mpg , mapping = aes(x = displ , y = cty))+
  geom_point()+
  facet_grid( cyl ~ . )

# 識別する変数が二つ以上でも行ける
ggplot(data = mpg , mapping = aes(x = displ , y = cty))+
  geom_point()+
  facet_grid( year ~ cyl)

ggplot(data = mpg , mapping = aes(x = displ , y = cty))+
  geom_point()+
  facet_wrap( year ~ cyl)

# 車種classごとに燃費ctyの平均点を算出
mean_cty <- mpg %>% 
  group_by(class) %>% 
  summarise(cty_m = mean(cty))

# 可視化
ggplot(data = mean_cty, mapping = aes(x = class , y = cty_m))+
  geom_bar(stat = "identity")

# stat = "summary"でｙ軸をサマライズする, fun = "サマライズした情報で使いたいやつ（meanとかmaxとか）"
ggplot(data = mpg , mapping = aes(x = class, y= cty))+
  geom_bar(stat = "summary", fun = "mean")
# 同じ結果をstat_summaryを使って描写する
ggplot(data = mpg , mapping = aes(x = class, y= cty))+
  stat_summary(geom = "bar", fun = "mean")

ggplot(data = mpg, mapping = aes(x=class, y = cty))+
  stat_summary(geom = "pointrange", fun = "mean", fun.max = "max", fun.min = "min")
