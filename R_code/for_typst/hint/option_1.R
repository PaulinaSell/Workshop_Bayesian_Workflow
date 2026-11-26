# Simulate
# ...

data <- list(X = X, Y = Y, Z = Z)

fit <- ulam(
  alist(
    # Likelihood
    Y ~ dnorm(__, __),
    # The linear model
    mu <- __ * __ + __ * __,
    # Priors
    b_XY ~ dnorm(__, __),
    # ...
  ),
  data = data,
  chains = 4,
  iter = 1000,
)

precis(fit)

post_samples <- extract.samples(fit)
