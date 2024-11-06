for (i in  1:10){
  print(i +1)
}
d <- iris
x <- list(m = matrix(1:10,nrow = 2),v =1:100,df =iris)
tashizan <- function(a,b){
  if((class(a) == "numeric") == FALSE |
     (class(b) == "numeric") == FALSE){
    stop("数値を入力してください")
  }
  a + b
}
for (i in 1:10) {
  print(i)
}
