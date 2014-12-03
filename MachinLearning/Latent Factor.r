# Latent Factor.r
# Simulates and Fits K=3 factor model, with M=6 manifest variables
# y_i = beta%*%F_i+e_i
# y_i is M x 1 response vector for subject i
# beta is M x K loading matrix
# F_i = K x 1 vector ~ N(0,I_k) 
# e_i = M x 1 vector ~ N[0,diag(sigma_k^2)]
# See Lopes and West (2004) Statistica Sinica for further details 
# May 24, 2011
###############################
library(mvtnorm)
library(msm)  		# For truncted normal
library(tmvtnorm)		# Multivariate trunctaed normal

########
# Data #
########
set.seed(052411)
n<-1000	# Number of subjects
K<-3		# Number of latent factors
M<-6		# Number of manifest variables

beta<-matrix(0,M,K)	# Factor loadings matrix
beta[1,1]<-.5
beta[2,1:2]<-c(-.5,.5)
beta[3,]<-c(1.5,-.5,1)
beta[4,]<-c(-1.5,0,.5)
beta[5,]<-c(-.5,-1,1)
beta[6,]<-c(0,1,-1)
true.beta<-beta

F<-matrix(0,n,K) 	# Latent factors 
Y<-E<-matrix(0,n,M) 	# Response and error matrices
tau<-rgamma(M,10,2)	# Error precision
sigma<-1/sqrt(tau)     # Error SD
for (i in 1:n) {
  F[i,]<-rnorm(K)
  E[i,]<-rnorm(M,sd=sigma)
  Y[i,]<-beta%*%F[i,]+E[i,]
}
true.F<-F

##########
# Priors #
##########
mu0<-0	# Prior mean of beta_ij 
C0<-20	# Prior variance of beta_ij (note: beta_ii (i=1,..,k) trunc. >0)
T0<-1/C0 # Prior precision
a<-b<-.01	# Hyperparameters for Sigma

#########
# Inits #
#########
tau<-rep(1,M)	   # Error precision   	
beta<-matrix(0,M,K)
diag(beta)<-1	   # Ensure first K diagonal elements > 0

#########
# Store #
#########
nsim<-1000
Beta<-matrix(0,nsim,M*K)	# Loadings
Beta[1,]<-c(t(beta))		# Starting Values
Sigma<-matrix(0,nsim,M)	# Error Variances
Sigma[1,]<-1/tau			# Starting Values
F1<-matrix(0,nsim,K)		# Latent Factors for Subject 1

########
# MCMC #
########
for (i in 2:nsim){
  # Update F
  varf<-solve(diag(K)+t(beta)%*%diag(tau)%*%beta)
  mf<-varf%*%t(beta)%*%diag(tau)%*%t(Y)
  v<-t(chol(varf))
  z<-matrix(rnorm(n*K),K,n)  
  F<-t(v%*%z+mf)
  
  # Update tau_j
  for (j in 1:M){
    d<-crossprod(Y[,j]-F%*%beta[j,])
    tau[j]<-rgamma(1,a+n/2,(b+d)/2)
  }
  
  # Update beta[1,1]
  v<-1/(T0+tau[1]*crossprod(F[,1]))
  m<-v*(T0*mu0+tau[1]*crossprod(F[,1],Y[,1]))
  beta[1,1]<-rtnorm(1,m,sqrt(v))
  
  # Update rows 2:K of beta
  for (j in 2:K) {
    v<-solve(T0+tau[j]*crossprod(F[,1:j]))
    m<-v%*%(T0*rep(mu0,j)+tau[j]*crossprod(F[,1:j],Y[,j]))
    beta[j,1:j]<-rtmvnorm(1,c(m),sigma=v,lower=c(rep(-Inf,j-1),0))
  }
  
  # Update remaining rows of beta 
  for (j in (K+1):M) {
    v<-solve(T0+tau[j]*crossprod(F))
    m<-v%*%(T0*rep(mu0,K)+tau[j]*crossprod(F,Y[,j]))
    beta[j,]<-rmvnorm(1,m,v)
  } 
  
  # Store 
  Beta[i,]<-c(t(beta))
  Sigma[i,]<-1/tau
  F1[i,]<-F[1,]
  
  if (i%%25==0) print(i)
  
}

########### 
# Results #
###########
mbeta<-apply(Beta[501:nsim,],2,mean)
Mbeta<-matrix(mbeta,M,K,byrow=T) 		# Compare to true.beta
msig<-apply(Sigma[501:nsim,],2,mean)	# Compare to sigma^2
mf1<-apply(F1,2,mean)				# Compare to true.F[1,]

###############
# Trace Plots #
###############
par(mfrow=c(2,1))
plot(1:nsim,Beta[,16],type="l",col="lightgreen")
abline(h=mbeta[16],col="blue4")

plot(1:nsim,Sigma[,5],type="l",col="lightgreen")
abline(h=msig[5],col="blue4")
