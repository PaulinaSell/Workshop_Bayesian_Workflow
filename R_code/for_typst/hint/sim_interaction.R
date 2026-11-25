n <- 1000
CKD <- sample(c(__, __), size = __, replace = __, prob = c(__, __))
a_BP <- c(__, __)
b_AP_BP <- c(__, __)
sigma_BP <- 5

AP <- rgamma(n, __, __)

BP <- rnorm(
  n,
  mean = a_BP[__] + __[__] * __,
  sd = __
)
