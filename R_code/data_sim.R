# Simulate data: Air pollution, systolic blood pressure (BP), a comorbidity, and age

library(rethinking)

n <- 1000

# simulate air pollution exposure, e.g. PM2.5
AP <- rgamma(n, 8, 2)

age <- round(runif(n, 55, 95))

# relationships between variables
a_BP <- c(110, 120) # intercept BP
b_age_CKD <- 0.3 # effect of age on comorbidity
b_age_BP <- 0.27 # effect of age on BP
b_AP_BP <- c(1.3, 2.2) # effect of AP on BP by comorbidity
sigma_BP <- 5 # noise in BP

prob_CKD <- inv_logit(-2.5 + ((age - mean(age)) * b_age_CKD)) # probability to have a comorbidity, the baseline risk is very low

CKD <- rbern(n, prob_CKD) + 1
table(CKD)

BP <- round(
  rnorm(
    n,
    mean = a_BP[CKD] +
      b_age_BP * age +
      b_AP_BP[CKD] * AP,
    sd = sigma_BP
  ),
  1
)

id <- c(1:n)

data <- data.frame(
  id,
  age,
  BP,
  CKD,
  AP
)

write.csv(data, "data/data.csv", row.names = FALSE)
