#####
#General-purpose optimization
#####
library(optimx)
fn <- function(x) (x[1] + 3*x[2] + x[3])^2 + 4 * (x[1] - x[2])^2
gr <- function(x) {
  g <- rep(NA, 3)
  g[1] <- 2*(x[1] + 3*x[2] + x[3]) + 8*(x[1] - x[2])
  g[2] <- 6*(x[1] + 3*x[2] + x[3]) - 8*(x[1] - x[2])
  g[3] <- 2*(x[1] + 3*x[2] + x[3])
  g
}
startx<-4*seq(1:3)/3
fn(x)
result<-optimx(startx,fn=fn,gr = gr,
               control=list(all.methods=TRUE, save.failures=TRUE, trace=0))
summary(result)
#####
#Constrained nonlinear optimization
#####
library(alabama)
heq <- function(x) {
  h <- rep(NA, 1)
  h[1] <- x[1] + x[2] + x[3] - 1
  h
}
hin <- function(x) {
  h <- rep(NA, 1)
  h[1] <- 6*x[2] + 4*x[3] - x[1]^3 - 3
  h[2] <- x[1]
  h[3] <- x[2]
  h[4] <- x[3]
  h
}
x <- runif(3)
fn(x)
gr(x)
heq(x)
hin(x)
auglag(par=x, fn=fn, gr=gr, heq=heq, hin=hin)
constrOptim.nl(par=x, fn=fn, heq=heq, hin=hin)
#####
#General Non-linear Optimization
#####
#non-smooth or has many local minima
library(Rsolnp)
gofn <- function(dat, n){
  x = dat[1:n]
  y = dat[(n+1):(2*n)]
  z = dat[(2*n+1):(3*n)]
  ii = matrix(1:n, ncol = n, nrow = n, byrow = TRUE)
  jj = matrix(1:n, ncol = n, nrow = n)
  ij = which(ii<jj, arr.ind = TRUE)
  i = ij[,1]
  j = ij[,2]
  # Coulomb potential
  potential = sum(1.0/sqrt((x[i]-x[j])^2 + (y[i]-y[j])^2 + (z[i]-z[j])^2))
  potential
}
goeqfn <- function(dat, n){
  x = dat[1:n]
  y = dat[(n+1):(2*n)]
  z = dat[(2*n+1):(3*n)]
  apply(cbind(x^2, y^2, z^2), 1, "sum")
}
n <- 25
gofn(dat,n)
goeqfn(dat,n)
LB <- rep(-1, 3*n)
UB <- rep(1, 3*n)
eqB <- rep(1, n)
x<-gosolnp(pars = NULL, fixed = NULL, fun = gofn, eqfun = goeqfn, eqB = eqB,
              LB = LB, UB = UB, control = list(outer.iter = 100, trace = 1),
              distr = rep(1, length(LB)), distr.opt = list(), n.restarts = 2, n.sim = 20000,
              rseed = 443, n = n)
#smooth functions - using augmented Lagrange method
#min f(x) 
# s.t.
# g(x) = 0
# l[h] <= h(x) <= u[h]
# l[x] <= x <= u[x]
#solnp(pars, fun, eqfun = NULL, eqB = NULL, ineqfun = NULL, ineqLB = NULL, 
#ineqUB = NULL, LB = NULL, UB = NULL, control = list(), ...)
fn <- function(x){
  exp(x[1]*x[2]*x[3]*x[4]*x[5])
}
eqn <- function(x){
  z1=x[1]*x[1]+x[2]*x[2]+x[3]*x[3]+x[4]*x[4]+x[5]*x[5]
  z2=x[2]*x[3]-5*x[4]*x[5]
  z3=x[1]*x[1]*x[1]+x[2]*x[2]*x[2]
  return(c(z1,z2,z3))
}
ineqn <- function(x){
  z1=2*x[1]+2*x[2]+3*x[3]+3*x[4]+5*x[5]
  z2=3*x[3]-5*x[4]
  z3=x[1]*x[1]*x[1]*x[2]*x[2]*x[2]
  return(c(z1,z2,z3))
}
fn(c(-2, 2, 2, -1, -1))
eqn(c(-2, 2, 2, -1, -1))
ineqn(c(-2, 2, 2, -1, -1))
solnp(pars = c(-2, 2, 2, -1, -1),fun = fn,
      eqfun = eqn, eqB = c(10, 0, -1),
      ineqfun = ineqn,ineqLB = c(-10,5,-80),ineqUB = c(5,30,0),
      LB = rep(-3,5), UB = rep(5,5))