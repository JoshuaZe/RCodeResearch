# Students in a class are asked their top three favorite students to work with (rank order).  
# After a social intervention this same question is posed again to students.  
# The intended outcome of the intervention is that the distribution of students receiving many or 
# very few choices will diminish.  
# In other words the dorks will become less dorky and the popular students will become less popular.  
# The idea is to visual this relationship.
library(igraph)
set.seed(101)
#create a data set
X <-lapply(1:10, function(i) sample(LETTERS, 3))
Y <- data.frame(person = LETTERS[1:10], sex = rbinom(10, 1, .5), do.call(rbind, X))
names(Y)[3:5] <- paste0("choice.", 1:3)

#reshape the data to long format
Z <- reshape(Y, direction="long", varying=3:5)
colnames(Z)[3:4] <- c("choice.no",  "choice")
rownames(Z) <- NULL
Z <- Z[, c(1, 4, 3, 2)]

#turn the data into a graph structure
edges <- as.matrix(Z[, 1:2])
g <- graph.data.frame(edges, directed=TRUE)
V(g)$label <- V(g)$name

#change label size based on number of votes
SUMS <- data.frame(table(Z$choice))
SUMS$Var1 <- as.character(SUMS$Var1)
SUMS <- SUMS[order(as.character(SUMS$Var1)), ]
SUMS$Freq <- as.integer(SUMS$Freq)
label.size <- 2
V(g)$label.cex <- log(scale(SUMS$Freq) + max(abs(scale(SUMS$Freq)))+ label.size)

#Color edges that are reciprocal red
x <- t(apply(edges, 1, sort))
x <- paste0(x[, 1], x[, 2])
y <- x[duplicated(x)]
COLS <- ifelse(x %in% y, "red", "gray40")
E(g)$color <- COLS

#reverse score the choices.no and weight
E(g)$width <- (4 - Z$choice.no)*2

#color vertex based on sex
V(g)$gender <- Y$sex
V(g)$color <- ifelse(V(g)$gender==0, "pink", "lightblue")

#plot it
opar <- par()$mar; par(mar=rep(0, 4)) #Give the graph lots of room
plot.igraph(g, layout=layout.auto(g))
par(mar=opar)
