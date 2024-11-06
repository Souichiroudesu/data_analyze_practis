x <- 1+1
fibonacci <- function(n){
  if(n == 1){return(1)}
  else if(n ==2){
    return(1)
  }else
  {
    fib <- numeric(n)
    fib[1] <- 1
    fib[2] <- 1
    for(i in 3:n){
      fib[i] <- fib[i-1] + fib[i-2]
    }
    return(fib[n])
  }
}
fib_value <- fibonacci(100)
print(fib_value)
