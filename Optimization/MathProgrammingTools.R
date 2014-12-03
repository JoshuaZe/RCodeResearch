#####
#Linear Programming / Optimization
#####
library(linprog)
bvec <- c( Protein = -10.0,
           Fat     =  -1.5,
           Fibre   =  12.0 )
cvec <- c( Feed1 = 2.5,
           Feed2 = 2.0 )
Amat <- matrix( 0, length(bvec), length(cvec) )
rownames(Amat) <- names(bvec)
colnames(Amat) <- names(cvec)
Amat[ "Protein", "Feed1" ] <-  -1.6
Amat[ "Fat",     "Feed1" ] <-  -0.5
Amat[ "Fibre",   "Feed1" ] <-   2.0
Amat[ "Protein", "Feed2" ] <-  -2.4
Amat[ "Fat",     "Feed2" ] <-  -0.2
Amat[ "Fibre",   "Feed2" ] <-   2.0
solveLP( cvec, bvec, Amat )
summary(solveLP( cvec, bvec, Amat ))
#####
#quadratic programming problems with linear equality and inequality constraints
#####
library(quadprog)
##
## Assume we want to minimize: -(0 5 0) %*% b + 1/2 b^T b
## under the constraints:      A^T b >= b0
## with b0 = (-8,2,0)^T
## and      (-4  2  0) 
##      A = (-3  1 -2)
##          ( 0  0  1)
## we can use solve.QP as follows:
##
Dmat       <- matrix(0,3,3)
diag(Dmat) <- 1
dvec       <- c(0,5,0)
#Amat       <- matrix(c(-4,-3,0,2,1,0,0,-2,1),3,3)
Amat       <- rbind(c(-4,2,-2,0),c(-3,1,1,0),c(0,0,1,1))
bvec       <- c(-8,-1,0,0)
x<-solve.QP(Dmat,dvec,Amat,bvec=bvec,meq = 3)
##
b<-x$solution
min <- -dvec %*%  b + 1/2*t(b)%*%b
t(Amat)%*%b
##
## Assume we want to minimize: -(0 5 0) %*% b + 1/2 b^T b
## under the constraints:      A^T b >= b0
## with b0 = (-8,2,0)^T
## and      (-4  2  0) 
##      A = (-3  1 -2)
##          ( 0  0  1)
## we can use solve.QP.compact as follows:
##
Dmat       <- matrix(0,3,3)
diag(Dmat) <- 1
# b<-c(3,1,3)
dvec       <- c(0,5,0)

Aind       <- rbind(c(2,2,2),c(1,1,2),c(2,2,3))
Amat       <- rbind(c(-4,2,-2),c(-3,1,1))
# Amat%*%b
bvec       <- c(-8,2,0)
solve.QP.compact(Dmat,dvec,Amat,Aind,bvec=bvec)
