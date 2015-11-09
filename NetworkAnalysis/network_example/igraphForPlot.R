## Data importing

network <- matrix(
c(1,1,0,1,rep(0,14),
1,1,1,rep(0,15),
rep(1,6),rep(0,12),
1,0,1,1,1,rep(0,13),
rep(1,7),0,1,rep(0,9),
rep(1,4),0,1,1,1,rep(0,4),1,rep(0,5),
0,1,1,1,1,0,1,0,1,1,0,0,1,1,1,0,0,0,
1,1,1,1,0,rep(1,8),0,1,1,0,0,
1,0,1,rep(0,4),rep(1,7),0,1,1,1,
rep(0,10),rep(1,5),0,0,0,
rep(0,13),1,1,0,1,1,
rep(0,9),rep(1,6),0,0,0,
rep(0,11),1,1,0,1,0,0,0,
rep(0,11),1,1,0,1,0,0,0),
ncol=14,
dimnames=list(paste("w",1:18,sep=""),
paste("e",1:14,sep="")))

wnames = paste("w",substr(as.character(1:18+100),2,3),sep="")
enames = paste("e",1:14,sep="")

## 2 mode data to 1 mode data

monopartite <- function(bipartite, by=c("row","col")) {
if(all(by=="col")) bi = t(bipartite)
else bi = bipartite
n = nrow(bi)
names = rownames(bi)

res=matrix(0, n, n, dimnames=list(names, names))
for(i in 1:n) {
        for(j in i:n) {
                res[i,j] = bi[i,]%*%bi[j,]
                res[j,i] = res[i,j]
        }
}
return(res)
}

women = monopartite(network)
events = monopartite(network, by="col")

## Generating network graph files in Pajek format

topajek <- function(monopartite, filename="mypajek.net") {
n = nrow(monopartite)
f=file(filename,"w")
s = paste(c("*vertices ", as.character(n), "\r\n*edges\r"), collapse="")
write(s, file=f, sep="")
for(i in 1:n) {
        for(j in i:n) {
                s = paste(c(as.character(i), as.character(j),
                as.character(monopartite[i,j]), "\r"), collapse=" ")
                write(s, file=f, append=TRUE, sep="")
        }
}
close(f)
cat(paste(c("Successfully output to ", getwd(), "/", filename, "\n"), collapse=""))
}

topajek(women, filename="women.net")
topajek(events, filename="events.net")

## Handle the graphs with igraph package

require(igraph)

w=read.graph("women.net", format="pajek")
e=read.graph("events.net", format="pajek")

V(w)$name = wnames
V(e)$name = enames

# Censoring out the edges with low weights, along with the self-connections

censor.edgeweight <- function(graph, floor=min(E(graph)$weight), 
                ceiling=max(E(graph)$weight)) {

if(is.null(E(graph)$weight)) stop("No weights for censoring the edges!")
es = E(graph)[E(graph)$weight<floor | E(graph)$weight>ceiling]

newgraph = graph - es

# An alternative realization for the line above:
#pairs = get.edges(graph, es)
#newgraph = delete.edges(graph, E(graph, P=as.vector(t(pairs))))

newgraph = delete.edges(newgraph, E(newgraph, P=rep(1:vcount(graph), each=2)))

# Delete self-conn.s
# The operator " - " doesn't work well when subtracting the graph with an edge seq.

return(newgraph)

}

newe = censor.edgeweight(e, floor=3); newe

## Plotting the events graph according to a certain censoring

# Assign edge widths

E(newe)$width = 0.4 * E(newe)$weight

plot(newe, vertex.size=10, vertex.shape="square", vertex.color="green", vertex.frame.color=NA, vertex.label.dist=1, vertex.label.degree=pi/2, layout=layout.kamada.kawai)

########################################

## Other notes:

# See help(edges)
#g <- graph.empty() + vertices(letters[1:10])
#g <- g + edges(sample(V(g), 10, replace=TRUE), color="red")
#get.edges(g, E(g)[1:3])
#get.edges(g, 1:3)

# Returns a 2-col. matrix representing the vertices of chosen edges

## Another approach to plot a network graph with Rgraphviz package:

#library(Rgraphviz)
#womengraph<-new("graphAM", adjMat=women, edgemode="undirected")
#eventsgraph<-new("graphAM", adjMat=events, edgemode="undirected")

#dev.new()
#plot(womengraph, attrs = list(node = list(fillcolor = "lightblue"),edge = list(arrowsize=0.5)))
#dev.new()
#plot(eventsgraph, attrs = list(node = list(fillcolor = "lightblue"),edge = list(arrowsize=0.5)))