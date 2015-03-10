#####
# clusterCrit Using
# internal indices
#####
library(clusterCrit)
# Create some data
x <- rbind(matrix(rnorm(100, mean = 0, sd = 0.5), ncol = 2),
           matrix(rnorm(100, mean = 1, sd = 0.5), ncol = 2),
           matrix(rnorm(100, mean = 2, sd = 0.5), ncol = 2))
plot(x)
# Perform the kmeans algorithm
cl <- kmeans(x, 3)
plot(x,col=factor(cl$cluster))
# Compute all the internal indices
getCriteriaNames(TRUE)
intCriteria(x,cl$cluster,"all")
#####
# clusterCrit Using
# external indices
#####
# Generate two artificial partitions
# e.g. part1 is large classification, part2 is the detail of part1.
part1<-sample(1:3,150,replace=TRUE)
part2<-sample(1:5,150,replace=TRUE)
# Compute all the external indices
getCriteriaNames(FALSE)
extCriteria(part1,part2,"all")