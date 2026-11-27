library(rethinking)

a_X <- 1
a_Y <- 4
b_ZX <- -1
b_ZY <- -1.5
b_XY <- 1.5
sigma <- 1

n <- 1000
Z <- rgamma(n, 2, 1)
X <- rnorm(
  n,
  mean = a_X +
    b_ZX * Z,
  sd = sigma
)
Y <- rnorm(
  n,
  mean = a_Y +
    b_ZY * Z +
    b_XY * X,
  sd = sigma
)

data <- data.frame(Z, X, Y)
data[1:5, ]

plot.new()
dens(data$Z, col = "#7291e7ff", lwd = 2, lty = 3)
dens(data$X, col = "#E77D72", lwd = 2, lty = 4, add = T)
dens(data$Y, col = "#72e7b0ff", lwd = 2, lty = 1, add = T)
legend(
  x = "topright",
  legend = c("Z", "X", "Y"),
  lty = c(3, 4, 1),
  lwd = 2,
  col = c("#7291e7ff", "#E77D72", "#72e7b0ff")
)
dev.off()

fit <- ulam(
  alist(
    Y ~ dnorm(mu, sigma),
    mu <- a_Y +
      b_XY * X +
      b_ZY * Z,

    a_Y ~ dnorm(0, 5),
    b_XY ~ dnorm(0, 5),
    b_ZY ~ dnorm(0, 5),
    sigma ~ dexp(1)
  ),
  chain = 4,
  iter = 1000,
  data = data
)

precis(fit)

samples <- extract.samples(fit)

mean(samples$a_Y)

HPDI(samples$a_Y)

traceplot(fit, window = c(501, 1000))
