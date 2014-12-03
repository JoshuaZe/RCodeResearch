#####
#Particle Swarm Optimization
#####
library(pso)
psoptim(rep(NA,2),function(x) 20+sum(x^2-10*cos(2*pi*x)),
        lower=-5,upper=5,control=list(abstol=1e-8))
## Rastrigin function - local refinement with L-BFGS-B on improvements
psoptim(rep(NA,2),function(x) 20+sum(x^2-10*cos(2*pi*x)),
        lower=-5,upper=5,control=list(abstol=1e-8,hybrid="improved"))
## Rastrigin function with reporting
o <- psoptim(rep(NA,2),function(x) 20+sum(x^2-10*cos(2*pi*x)),
             lower=-5,upper=5,control=list(abstol=1e-8,trace=1,REPORT=1,
                                           trace.stats=TRUE))
plot(o$stats$it,o$stats$error,log="y",xlab="It",ylab="Error")
points(o$stats$it,sapply(o$stats$f,min),col="blue",pch=2)
## Parabola
p <- test.problem("parabola",10) # one local=global minimum
set.seed(1)
o1 <- psoptim(p,control=list(trace=1,REPORT=50))
show(o1)
o2 <- psoptim(p,control=list(trace=1,REPORT=50,w=c(.7,.1))) 
show(o2)
o3 <- psoptim(p,control=list(trace=1,REPORT=1,hybrid=TRUE)) 
show(o3) ## hybrid much faster