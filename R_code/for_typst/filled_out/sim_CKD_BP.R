n <- 1000
CKD <- sample(c(1, 2), size = n, replace = TRUE, prob = c(0.8, 0.2))
a_BP <- c(110, 120)
sigma_BP <- 5

BP <- round(
  rnorm(
    n,
    mean = a_BP[CKD],
    sd = sigma_BP
  ),
  1
)
