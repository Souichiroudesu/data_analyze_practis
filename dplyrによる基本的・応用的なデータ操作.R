library(dbplyr)
library(tidyverse)
mpg
d <- data.frame(x = 1:3)
d[,"x"]

d.tibble <- as_tibble(d)
d.tibble[,"x"]

mpg %>% 
  select(manufacturer,model,displ,year,cyl) %>% 
  filter(manufacturer == "audi") %>% 
  mutate(century = ceiling(year/100))

mpg %>% 
  filter(manufacturer == "audi",cyl >= 6)

mpg %>% 
  arrange(cty,hwy)

mpg %>% 
  arrange(-cty)

#指定した文字列から始める
mpg %>% 
  select(starts_with("c"))

# 列の型や値の特性で列を選択する（is.characterは文字列ベクトルかどうかを判定する）
mpg %>% 
  select(where(is.character))

#where()では~を使ってその場で関数を作ることができる
# 例えば~.x*2はfunction(x)x*2を表す
mpg %>% 
  select(where(~is.character(.x) && n_distinct(.x) <= 6))

#文字列のうちm以外から始まる列名を持つもののみに絞り込む
mpg %>% 
  select(where(is.character) & !starts_with(("m")))

# 列を並べ替える
mpg         

mpg %>% 
  relocate(class,cyl)

mpg %>% 
  # class列とcyl列をmodel列の前に移動 
  relocate(class,cyl,.before = model)

# 文字列の追加
mpg %>% 
  mutate(cyl_6 = if_else(cyl >= 6,"6以上","6未満"),.after = cyl)

#既存の列の上書き
mpg %>% 
  mutate(cyl = if_else(cyl >= 6,"6以上","6未満"),.after = cyl)

# 列の追加と列の抽出を同時にやる
mpg %>% 
  transmute(cyl = if_else(cyl >= 6,"6以上","6未満"),year)

# データの収集計算
mpg %>% 
  summarise(displ_max = max(displ))

# グループ化
mpg_grouped <- mpg %>% 
  group_by(manufacturer,year)

mpg_grouped %>% 
transmute(displ_rank = rank(displ,ties.method = "max"))

mpg_grouped %>% 
  filter(n() >= 20)

mpg_grouped %>% 
  summarise(displ_max = max(displ),.groups = "drop")

# lag関数：各要素のｎ個前の要素の値を返す関数
# 直前のデータからの変化を計算するときに便利
uriage <- tibble(
   day = c(1,1,2,2,3,3,4,4),　#日付
   store = c("a","b","a","b","a","b","a","b"), #店舗ＩＤ
   sales = c(100,500,200,500,400,500,800,500) #売上額
)

uriage %>% 
  #店舗ＩＤでグループ化
  group_by(store) %>% 
  #各日について前日の売り上げとの差を計算
  mutate(sales_diff = sales - lag(sales)) %>% 
  #見やすさのため、店舗ごとに日付順になるように並べ替え
  arrange(store,day)

# セマンティクスにおいて列を文字列で指定するには.data関数を使う 
mpg %>% 
  mutate(cyl2 = sqrt(.data[["cyl"]]), .after = cyl)

# inner_join(データ１、データ２、by = 共通のキー)
uriage

tenkou <- tibble(
  day = c(1,2,3,4),
  rained = c(FALSE,FALSE,TRUE,FALSE)
)

uriage %>% 
  inner_join(tenkou,by = "day")

#列名が異なる場合
tenkou2 <-tibble(
  DAY = c(1,2,3,4),
  rained = c(FALSE,FALSE,TRUE,FALSE)
)

uriage %>% 
  inner_join(tenkou2,by = c("day" = "DAY"))

#a店とb店それぞれの場所の記録データがある場合
tenko3 <- tibble(
  DAY = c(1,1,2,2,3),
  store = c("a","b","a","b","b"),
  rained = c(FALSE,FALSE,TRUE,FALSE,TRUE)
)

uriage %>% 
  inner_join(tenko3,by = c("day" = "DAY","store"))

# left_join()にすると、左側（データ１）の列はすべて残る、
# 右側に対応するデータがなければNAを返す

uriage %>% 
  left_join(tenko3,by = c("day" = "DAY","store"))

# NAを特定の値に置き換えたい
res <- uriage %>% 
  left_join(tenko3,by = c("day" = "DAY","store"))

res %>% 
  mutate(rained = coalesce(rained,FALSE))

# 雨が降っていた店舗と日付の組み合わせに絞りたい 
tenkou4 <- tibble(
  day = c(2,3,3),
  store = c("a","a","b"),
  rained = c(TRUE,TRUE,TRUE)
)

# filterで絞り込むと
uriage %>% 
  # rouwiseえで１行ずつ処理
  rowwise() %>% 
  # daysとstoreが一致する行を調べる
  filter(any(day == tenkou4$day & store == tenkou4$store)) %>% 
  ungroup()

# semi_joinを使うと
uriage %>% 
  semi_join(tenkou4,by = c("day","store"))
uriage %>% 
  inner_join(tenkou4,by = c("day","store"))

orders <- tibble(
  id = c(1,2,3),
  value = c("ラーメン_大","半チャーハン_並","ラーメン_並")
)
orders %>% 
  mutate(
    item = str_split(value,"_",simplify = TRUE)[,1],
    amount = str_split(value,"_",simplify = TRUE)[,2]
  )

orders %>% 
  separate(value, into = c("item","amount"),sep = "_")

tibble(x = c("beer(3)","sushi(8)"))
tibble(x = c("beer(3)","sushi(8)")) %>% 
  extract(x,into = c("item","num"),regex = "(.*)\\((\\d+)\\)")
# \\((\\ここに数字が入るってこと)\\)

tibble(id = 1:3,x = c("1,2","3,2","1")) %>% 
  separate_rows(x, sep = ",")

# 暗黙の欠損値
orders2 <- tibble(
  day = c(1,1,1,2),
  item = c("ラーメン","ラーメン","半チャーハン","ラーメン"),
  size = c("大","並","並","並"),
  order = c(3,10,3,30)
)

orders2
# これだと二日目のラーメン大と半チャーハン並の値が含まれていないが
# プログラムはこれを認知できない

# complete(完全な列を並べる)
orders2 %>% 
  complete(day,item,size)

# 半チャーハン大が邪魔
# nesting()で存在する列のみに絞られる
orders2 %>% 
  complete(day,nesting(item,size))

# full_seq()関数は、指定した感覚（period引数）で並んでいると仮定して、
# 存在するはずの値を列挙する
# 例
full_seq(c(1,2,4,5,10),period = 1)

tibble(
  day = c(1,4,5,7),
  event = c(1,1,2,1),
) %>% 
  complete(
    day = full_seq(day,period = 1),
    fill = list(event = 0)
  )

# dplyrでの暗黙の欠損値
d_fct <- tibble(x = c(1,1,2,1),y = c("A","A","A","B"))
d_fct
d_fct %>% group_by(x,y) %>% 
  summarise(n = n(),.groups = "drop")
# この時ｘ＝２、ｙ＝Ｂというペアは存在していないが、暗黙の欠損値になっている
# グループ化に使う列をfactorで因子型に変換する
# group_by()の因数の後に.drop = FALSEを入れる
d_fct %>% 
  group_by(x = factor(x), y = factor(y),.drop = FALSE) %>% 
  summarise(n = n(),.groups = "drop")
