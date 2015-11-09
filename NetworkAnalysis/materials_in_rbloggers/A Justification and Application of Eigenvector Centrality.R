# *------------------------------------------------------------------
# | PROGRAM NAME: R_BASIC_SNA
# | DATE: 4/9/12
# | CREATED BY: MATT BOGARD
# | DATE: 11/5/12 
# | PROJECT FILE: P:\R  Code References\SNA            
# *----------------------------------------------------------------
# | PURPOSE: COMPANION CODE TO Justification and Application of
# |  Eigenvector Centrality by Leo Spizzirri        
# |  https://www.math.washington.edu/~morrow/336_11/papers/leo.pdf
# *------------------------------------------------------------------


# specify the adjacency matrix
A <- matrix(c(0,1,0,0,0,0,
              1,0,1,0,0,0,
              0,1,0,1,1,1,
              0,0,1,0,1,0,
              0,0,1,1,0,1,
              0,0,1,0,1,0 ),6,6, byrow= TRUE)
EV <- eigen(A) # compute eigenvalues and eigenvectors
max(EV$values)  # find the maximum eigenvalue

# get the eigenvector associated with the largest eigenvalue
centrality <- data.frame(EV$vectors[,1]) 
names(centrality) <- "Centrality"

B <- A + diag(6)
EVB <- eigen(B) # compute eigenvalues and eigenvectors 
# they are the same as EV(A)

# define matrix M
M <- matrix(c(1,1,0,0,
              1,1,1,0,
              0,1,1,1,
              0,0,1,1),4,4, byrow= TRUE)

# define function for B^k for matrix M      
MM <- function(k){
  n <- (k-1)
  B_K <- M
  for (i in 1:n){
    B_K <- B_K%*%M
  }
  return(B_K)
}

BB <- function(k){
  n <- (k-1)
  B_K <- B
  for (i in 1:n){
    B_K <- B_K%*%B
  }
  return(B_K)
}

MM(2) # M^2
MM(3) # M^3

# define c
c <- matrix(c(2,3,5,3,4,3))

# define c_k for matrix B
ck <- function(k){
  n <- (k-2)
  B_K <- B
  for (i in 1:n){
    B_K <- B_K%*%B
  }
  c_k <- B_K%*%c  
  return(c_k)
}

# derive EV centrality as k -> infinity
library(matrixcalc)
# k  = 5
ck(5)/frobenius.norm(ck(5))
# k  = 10
ck(10)/frobenius.norm(ck(10))
# k = 100
ck(100)/frobenius.norm(ck(100))
