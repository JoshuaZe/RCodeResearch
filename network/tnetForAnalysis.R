library(tnet)

#~~~~~~~~~~Generate a random weighted graph~~~~~~~~~~~~~~~~~~~#
rg <- rg_w(nodes=100,arcs=300,directed=TRUE)
#~~~~~~~~~~Calculate clustering coefficient~~~~~~~~~~~~~~~~~~~#
clustering_w(rg)
#~~~~~~~~~~~longitudinal network~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
t <- c('2007-09-12 13:45:00',
'2007-09-12 13:46:31',
'2007-09-12 13:47:54',
'2007-09-12 13:48:21',
'2007-09-12 13:49:27',
'2007-09-12 13:58:14',
'2007-09-12 13:52:17',
'2007-09-12 13:56:59');
i <- c(1,1,1,1,1,1,1,1);
j <- c(2,2,2,2,2,2,3,3);
w <- c(1,1,1,1,1,1,1,1);
sample <- data.frame(t, i, j, w);

add_window_l(sample, window=21)
as.static.tnet(sample)


#~~~~~~~~~~~~~Weighted network~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
sample <- rbind(
c(1,2,4),
c(1,3,2),
c(2,1,4),
c(2,3,4),
c(2,4,1),
c(2,5,2),
c(3,1,2),
c(3,2,4),
c(4,2,1),
c(5,2,2),
c(5,6,1),
c(6,5,1))

as.tnet(sample)
betweenness_w(sample)
degree_tm(sample)
degree_w(sample)
dichotomise_tm(sample, GT=2)
distance_tm(sample)

#~~~~~~~~~~~~~Weighted two-mode network~~~~~~~~~~~~~~~~~~#
net <- cbind(
i=c(1,1,2,2,2,3,3,4,5,5,6),
p=c(1,2,1,3,4,2,3,4,3,5,5),
w=c(3,5,6,1,2,6,2,1,3,1,2))
## Run binary clustering function
clustering_local_tm(net[,1:2])
## Run weighted clustering function
clustering_local_tm(net)

## Generate a random graph
#density: 300/(100*99)=0.03030303;
#this should be average from random samples
rg <- rg_w(nodes=100,arcs=300,weights=1:10,directed=FALSE)

clustering_local_w(rg)

#~~~~~~~~~compress_ids for longitudinal network~~~~~~~~~~~~~~~~#
t <- c("2007-09-12 13:45:00",
"2007-09-12 13:45:00",
"2007-09-12 13:45:01",
"2007-09-12 13:46:31",
"2007-09-12 13:46:31",
"2007-09-12 13:47:54",
"2007-09-12 13:48:21",
"2007-09-12 13:49:27",
"2007-09-12 13:49:27",
"2007-09-12 13:52:17",
"2007-09-12 13:56:59",
"2007-09-12 13:58:14")
i <- c(1,2,1,3,1,2,3,5,1,3,1,1);
j <- c(1,2,2,3,3,1,2,5,5,2,3,5);
w <- c(1,1,1,1,1,1,1,1,1,1,1,1);
samplenet <- data.frame(t, i, j, w);
## Run the function
compress_ids(samplenet)

#~~~~~~~~~~~~~~~~~~~~~~~network growth study~~~~~~~~~~~~~~~~~~#
t <- c('2007-09-12 13:45:00',
'2007-09-12 13:46:31',
'2007-09-12 13:47:54',
'2007-09-12 13:48:21',
'2007-09-12 13:49:27',
'2007-09-12 13:58:14',
'2007-09-12 13:52:17',
'2007-09-12 13:56:59');
i <- c(1,1,2,3,1,3,1,1);
j <- c(2,3,1,2,4,2,3,4);
w <- c(1,1,1,1,1,1,1,1);
sample <- data.frame(t, i, j, w);
## Run the function
growth_l(sample, effects="indegree", nstrata=2)

#~~~~~~~~~~~~two mode network~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
two.mode.net <- cbind(
i=c(1,1,2,2,2,2,2,3,4,5,5,5,6),
p=c(1,2,1,2,3,4,5,2,3,4,5,6,6))
## Run the function
projecting_tm(two.mode.net, method="Newman")

#~~~~~~~~~~~~~~~~reshuffling the network~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
## longitudinal network
t <- c('2007-09-12 13:45:00',
'2007-09-12 13:46:31',
'2007-09-12 13:47:54',
'2007-09-12 13:48:21',
'2007-09-12 13:49:27',
'2007-09-12 13:58:14',
'2007-09-12 13:52:17',
'2007-09-12 13:56:59');
i <- c(1,1,1,1,1,1,1,1);
j <- c(2,2,2,2,2,2,3,3);
w <- c(1,1,1,1,1,1,1,1);
sample <- data.frame(t, i, j, w);
net<-as.tnet(sample, type = "longitudinal tnet")
rg_reshuffling_l(net)

## two mode nework
data(Newman.Condmat.95.99)
rg_reshuffling_tm(Newman.Condmat.95.99.net.2mode[1:100,], seed=1)

## weighted network
sampledata<-rbind(
c(1,2,4),
c(1,3,2),
c(2,1,4),
c(2,3,4),
c(2,4,1),
c(2,5,2),
c(3,1,2),
c(3,2,4),
c(4,2,1),
c(5,2,2),
c(5,6,1),
c(6,5,1));

rg_reshuffling_w(sampledata, option="weights", directed=FALSE)


#~~~~~~~~~~~~~generate random network~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
rg_tm(ni=10,np=10,ties=20)
rg_w(nodes=10,arcs=30,directed=FALSE,seed=1)

#~~~~~~~shrink multiple ties to weighted tnet format~~~~~~~~~~~~~~~~#
sample <- rbind(
c(1,2),
c(1,2),
c(1,2),
c(1,2),
c(1,3),
c(1,3),
c(2,1),
c(2,1),
c(2,1),
c(2,1),
c(2,3),
c(2,3),
c(2,3),
c(2,3),
c(2,4),
c(2,5),
c(2,5),
c(3,1),
c(3,1),
c(3,2),
c(3,2),
c(3,2),
c(3,2),
c(4,2),
c(5,2),
c(5,2),
c(5,6),
c(6,5))
## Run the programme
shrink_to_weighted_network(sample)

#~~~~~~~~~~~change matrix to weighted tnet format~~~~~~~~~~~~~~~~~~~~~#
sample <- rbind(
c(1,2,2),
c(1,3,2),
c(2,1,4),
c(2,3,4),
c(2,4,1),
c(2,5,2),
c(3,1,2),
c(3,2,4),
c(5,2,2),
c(5,6,1))
symmetrise_w(sample, method="MAX")

#~~~~~~~~Exports a tnet network to igraph or ucinet format~~~~~~~~~~~~~#
g<-tnet_igraph(sample, type="weighted one-mode tnet")
u<-tnet_ucinet(sample, type="weighted one-mode tnet")

#~~~~~~~~~~rich club ratio~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
sample <- cbind(
i=c(1,1,2,2,2,2,3,3,4,5,5,6),
j=c(2,3,1,3,4,5,1,2,2,2,6,5),
w=c(4,2,4,4,1,2,2,4,1,2,1,1))
prominence <- c(1,1,1,0,0,0)

weighted_richclub_local_w(sample, prominence)
weighted_richclub_w(sample, rich="k", reshuffle="weights")

## two mode nework
data(Newman.Condmat.95.99)
weighted_richclub_tm(Newman.Condmat.95.99.net.2mode[1:100,], NR=10)
# it's very time consuming to run the codes above