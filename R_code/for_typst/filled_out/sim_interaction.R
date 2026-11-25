n <- 1000
CKD <- sample(c(1, 2), size = n, replace = TRUE, prob = c(0.8, 0.2))
a_BP <- c(110, 120)
b_AP_BP <- c(1.3, 2.2)
sigma_BP <- 5

AP <- rgamma(n, 8, 2)

BP <- round(
  rnorm(
    n,
    mean = a_BP[CKD] + b_AP_BP[CKD] * AP,
    sd = sigma_BP
  ),
  1
)
