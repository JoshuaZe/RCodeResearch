#####
#Genetic Algorithms
#####
library(GA)
#using GA
f <- function(x) abs(x)+cos(x)
curve(f, -20, 20)
fitness <- function(x) -f(x)
curve(fitness, -20, 20)
GA <- ga(type = "real-valued", fitness = fitness, min = -20, max = 20)
summary(GA)
plot(GA)
curve(f, -20, 20)
abline(v = GA@solution, lty = 3)
#creat own monitor
monitor <- function(obj){
  curve(f, -10, 10, main = paste("iteration =", obj@iter))
  points(obj@population, obj@fitness, pch = 20, col = 2)
  rug(obj@population, col = 2)
  Sys.sleep(0.2)
}
GA <- ga(type = "real-valued", fitness = f, min = -10, max = 10, monitor = monitor)
#two-dimensional Rastrigin function
Rastrigin <- function(x1, x2){
  20 + x1^2 + x2^2 - 10*(cos(2*pi*x1) + cos(2*pi*x2))
}
x1 <- x2 <- seq(-5.12, 5.12, by = 0.1)
f <- outer(x1, x2, Rastrigin)
persp3D(x1, x2, f, theta = 50, phi = 20)
filled.contour(x1, x2, f, color.palette = jet.colors)
GA <- ga(type = "real-valued", fitness = function(x) -Rastrigin(x[1], x[2]),
         min = c(-5.12, -5.12), max = c(5.12, 5.12),
         popSize = 50, maxiter = 100)
summary(GA)
plot(GA)
#Parallel GA
Rastrigin <- function(x1, x2){
  20 + x1^2 + x2^2 - 10*(cos(2*pi*x1) + cos(2*pi*x2))
}
system.time(GA1 <- ga(type = "real-valued",
                      fitness = function(x) -Rastrigin(x[1], x[2]),
                      min = c(-5.12, -5.12), max = c(5.12, 5.12),
                      popSize = 50, maxiter = 100, monitor = FALSE,
                      seed = 12345))
system.time(GA2 <- ga(type = "real-valued",
                      fitness = function(x) -Rastrigin(x[1], x[2]),
                      min = c(-5.12, -5.12), max = c(5.12, 5.12),
                      popSize = 50, maxiter = 100, monitor = FALSE,
                      seed = 12345, parallel = TRUE))