data <- as.list(read.csv("data/data.csv"))

m_AP_BP <- ulam(
  alist(
    BP ~ dnorm(mu, sigma),
    mu <- a[CKD] + b_AP_BP[CKD] * AP + b_age_BP * age,
    a[CKD] ~ dnorm(120, 10),
    b_AP_BP[CKD] ~ dnorm(0, 2),
    b_age_BP ~ dnorm(0, 2),
    sigma ~ dexp(1)
  ),
  data = data,
  chains = 4,
  iter = 1000
)

precis(m_AP_BP, depth = 2)
