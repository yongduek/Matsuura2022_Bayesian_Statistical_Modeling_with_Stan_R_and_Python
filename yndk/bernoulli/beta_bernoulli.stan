
// beta_bernoulli.stan

functions {
  // none needed
}

data {
  int<lower=0> N;                 // number of trials
  array[N] int<lower=0, upper=1> y;     // outcomes
  real<lower=0> alpha0;           // prior alpha
  real<lower=0> beta0;            // prior beta
}

parameters {
  real<lower=0, upper=1> theta;   // success probability
}

model {
  theta ~ beta(alpha0, beta0);    // prior
  y ~ bernoulli(theta);            // likelihood
}

generated quantities {
  array[N] int<lower=0, upper=1> y_rep; // replicated data
  vector[N] log_lik;
  for (n in 1:N) {
    y_rep[n] = bernoulli_rng(theta);
    log_lik[n] = bernoulli_lpmf(y[n] | theta);
  }
}
