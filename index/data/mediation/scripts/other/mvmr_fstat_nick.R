# mvmrdata is a dataframe containing a list of snps and the beta and standard error for each exposure and the outcome 

# here the variables are labeled as:

# x1.beta, x1.se <- beta and se for exposure 1
# x2.beta, x2.se <- beta and se for exposure 2
# out.beta, out.se <- beta and se for the outcome

# estbeta1 estimated beta for x1 from the multivariable MR estimation
# estbeta2 estimated beta for x2 from the multivariable MR estimation

# L is the total number of snps in the analysis

# estimating covariance from phenotypic correlation
# rho is correlation between x1 and x2. If this is unknown set cov.x1x2 to zero which will impose the assumption of no covariance in the analysis.
# if x1 and x2 are from different datasets then this can be set to zero.

# cov.x1x2 <- rho*mvmrdata$x1.se*mvmrdata$x2.se
cov.x1x2 <- 0

# estimating the MVMR - using simple weights
mvmr <- lm(mvmrdata$out.beta ~ -1 + mvmrdata$x1.beta + mvmrdata$x2.beta, weights = (mvmrdata$out.se^(-2)))

estbeta1 <- summary(mvmr)$coefficients[1,1]
sebeta1 <- summary(mvmr)$coefficients[1,2]
estbeta2 <- summary(mvmr)$coefficients[2,1]
sebeta2 <- summary(mvmr)$coefficients[2,2]


# calculating the weak instrument test
delta1 <- summary(lm(mvmrdata$x1.beta ~ -1 + mvmrdata$x2.beta))$coefficients[1,1]
v1 <- mvmrdata$x1.se^2 + delta1^2*(mvmrdata$x2.se^2)
F.x1 <- sum((1/v1)*(mvmrdata$x1.beta - (delta1*mvmrdata$x2.beta))^2)/(L-1)

delta2 <- summary(lm(mvmrdata$x2.beta ~ -1 + mvmrdata$x1.beta))$coefficients[1,1]
v2 <- mvmrdata$x2.se^2 + delta2^2*(mvmrdata$x1.se^2)
F.x2 <- sum((1/v2)*(mvmrdata$x2.beta - (delta2*mvmrdata$x1.beta))^2)/(L-1)

# calculating heterogeneity Q statistic for MVMR
seQ <- (mvmrdata$out.se)^2 + (estbeta1^2)*(mvmrdata$x1.se^2) + (estbeta2^2)*(mvmrdata$x2.se^2) + 2*estbeta1*estbeta2*cov.x1x2
Q <- sum(((1/seQ)*((mvmrdata$out.beta-(estbeta1*mvmrdata$x1.beta+estbeta2*mvmrdata$x2.beta))^2)))
critical_value <- qchisq(0.05,L-2,lower.tail = FALSE)
p_value <- pchisq(Q,L-2,lower.tail = FALSE)