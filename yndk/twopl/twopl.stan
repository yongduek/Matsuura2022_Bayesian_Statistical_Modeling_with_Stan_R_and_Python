//
//
//

data {
    int<lower=1> I; // # questions
    int<lower=1> J; // # persons
    int<lower=1> N; // # observations
    array[N] int<lower=1, upper=I> ii; // question for n
    array[N] int<lower=1, upper=J> jj; // person for n
    array[N] int<lower=0, upper=1> y; // correctness for n
}
parameters {
    vector<lower=0>[I] alpha; // discrimination for item i
    vector[I] beta; // difficulty for item i
    vector[J] theta; // ability for person j
}
model {
    vector[N] eta;
    alpha ~ lognormal(0., .4); // mean at 1, approx in range [.25, 4.3]
    beta ~ normal(0, 1);
    theta ~ normal(0, 1);
    for (n in 1 : N) 
      eta[n] = alpha[ii[n]] * (theta[jj[n]] - beta[ii[n]]);
    y ~ bernoulli_logit( eta);
}
