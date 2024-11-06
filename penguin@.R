library(tidyverse)
install.packages("palmerpenguins")
install.packages("ggthemes")
library(palmerpenguins)
library(ggthemes)
library(ggplot2)

penguins

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
)+
  geom_point()
# ggplot(
#   data = penguins,
#   mapping = aes(x = flipper_length_mm, y = body_mass_g)
# )ここが範囲を指定している
# ggplotはキャンパスの役割

# 色での識別
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, colour =species)
)+
  geom_point()

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, colour =species)
)+
  geom_point()+
  geom_smooth(method = "lm")

# 一本の直線であらわしたい場合
# geom_smooth()は色で識別するため、共通項を入力するggplotの中にcolour関数を入れず
# geom_pointにcolour関数を入れることでできる
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species)) +
  geom_smooth(method = "lm")

# labsでラベルの選択

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length", 
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins", 
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()

?penguins
# bill_length_mm
# a number denoting bill length (millimeters)
# bill_depth_mm
# # a number denoting bill depth (millimeters)

ggplot(
  data = penguins,
  mapping = aes(y = species, x  = bill_depth_mm)
)+
  geom_point()

ggplot(
  data = penguins,
  mapping = aes(y = species, x  = bill_depth_mm)
)+
  geom_boxplot()
?labs

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
)+
  geom_point(mapping = aes(colour = bill_depth_mm))+
  geom_smooth()

# 練習２
ggplot(
  data = penguins,
  aes(y = species)
)+
  geom_bar()

ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")

ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(bins = 20)
