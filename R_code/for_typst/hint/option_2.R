data(foxes)

fit <- ulam(
  alist(
    # Likelihood
    Y ~ dnorm(__, __),
    # The linear model
    mu <- __ * __ + __ * __,
    # Priors
    __ ~ dnorm(__, __),
    # ...
  ),
  data = data,
  chains = 4,
  iter = 1000,
)

precis(fit)

post_samples <- extract.samples(fit)
