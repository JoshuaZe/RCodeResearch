# ICIS_2014.r
# Experiment of the Research Topic Detection
# Conversational Recommender System for Selecting Research Title Based on Discovered Topic
# May 3, 2014
###############################
# odbcConnect
###############################
library(RODBC);
#odbcConnect database
conn <- odbcConnect("paper_dataset", uid="sa", pwd="");
#list all tables
sqlTables(conn);
#tables
attr_resource<-sqlFetch(conn,"attr_resource")
attr_author<-sqlFetch(conn,"attr_author")
attr_tag<-sqlFetch(conn,"attr_tag")
relation_resource_tag<-sqlFetch(conn,"relation_resource_tag")
relation_resource_author<-sqlFetch(conn,"relation_resource_author")
relation_coterm<-sqlFetch(conn,"relation_coterm")
relation_citation<-sqlFetch(conn,"relation_citation")
###############################
# network generation and simplify
###############################
library(igraph)
coterm<-relation_coterm[which(relation_coterm[,3]>=5),]
g_coterm <- graph.edgelist(el = as.matrix(coterm[,1:2]),directed = FALSE)
E(g_coterm)$weight <- coterm[,3]
rm(coterm)
is.simple(g_coterm)
g_coterm <- simplify(g_coterm)
is.simple(g_coterm)
###############################
# maximal connected components
###############################
#get the maximal connected components
g_coterm.comps <- decompose.graph(g_coterm,max.comps=1)
gg_coterm<-g_coterm.comps[[1]]
rm(g_coterm.comps)
#analysis components
is.connected(g_coterm, mode="weak")
g_coterm.components<-clusters(g_coterm, mode="weak")
#Who's in what component?
g_coterm.components$membership
#What are the component sizes?
g_coterm.components$csize
#How many components?
g_coterm.components$no
#components sizes over 10?
g_coterm.components$csize[g_coterm.components$csize>10]
#How many components over 10?
length(which(g_coterm.components$csize>10))
###############################
# draw better network using ggplot
###############################
library(ggplot2)
plt<-function(out,plotcord){
  p <- ggplot(data=plotcord, aes(x=X1, y=X2, label=rownames(plotcord)))+geom_point(colour="steelblue",size=40)+geom_text(size=35,vjust=-1,colour="brown",font=3)+ geom_segment(aes(x=X1, y=X2, xend = Xend1, yend = Xend2), data=out[1,], size =out[1,1]*2 , colour="grey",alpha=0.01)+theme(panel.background = element_blank()) +theme(legend.position="none")+theme(axis.title.x = element_blank(), axis.title.y = element_blank()) + theme( legend.background = element_rect(colour = NA)) + theme(panel.background = element_rect(fill = "white", colour = NA)) +theme(panel.grid.minor = element_blank(), panel.grid.major = element_blank())
  for(i in 2:nrow(out)){
    p<-p+geom_segment(aes(x=X1, y=X2, xend = Xend1, yend = Xend2), data=out[i,], size =out[i,1]*12 , colour="grey",alpha=0.01)}
  return(p)
}
###############################
# draw graph of components
###############################
#delete the membership in selected components
g<-delete.vertices(g_coterm,g_coterm.components$membership!=which(g_coterm.components$csize==10))
#simple drawing
par(mar = c(0, 0, 0, 0))
set.seed(23)
plot(g,layout=layout.graphopt,
     vertex.size = 3,vertex.label.cex=1,
     edge.label.cex=1,edge.arrow.size=0.2)
#ggplot drawing
library(sna)
edgelist<-get.data.frame(g)
tb <- as.matrix(get.adjacency(g))
plotcord <- data.frame(gplot.layout.fruchtermanreingold(tb, NULL))
row.names(plotcord) <- row.names(tb)
out <- NULL
for(i in 1:nrow(tb)){
  seg <- as.matrix(tb[i,tb[i,]>0]) 
  if(length(seg)!=0){
    seg <- cbind(seg,plotcord[i,]) 
    Xend <- plotcord[row.names(seg),] 
    colnames(Xend) <- c("Xend1","Xend2")
    seg <- cbind(seg,Xend) 
    out <- rbind(out,seg)}
}
#png('2014.png', height = 5000, width = 5000)
plt(out,plotcord)
#dev.off()
###############################
# community discovery
###############################
#gg_coterm.com <- walktrap.community(gg_coterm)
#gg_coterm.com <- leading.eigenvector.community(gg_coterm)
gg_coterm.com <- fastgreedy.community(gg_coterm)
gg_coterm.com$modularity
max(gg_coterm.com$modularity)
gg_coterm.com$membership
#sizes of each community
sizes(gg_coterm.com)
head(sizes(gg_coterm.com),10)
#How many community
length(sizes(gg_coterm.com))
#size of largest community
max(sizes(gg_coterm.com))
#cuts the merge tree of a hierarchical community finding method
gg_coterm.com$membership<-cutat(gg_coterm.com,no=10)
length(sizes(gg_coterm.com))
sizes(gg_coterm.com)
wctmp<-as.data.frame(sizes(gg_coterm.com))
names(wctmp)<-c('community','sizes')
wctmp <- wctmp[order(wctmp$sizes,decreasing = TRUE),]
#draw simple
g<-delete.vertices(gg_coterm,gg_coterm.com$membership!=3)
par(mar = c(0, 0, 0, 0))
set.seed(23)
plot(g,layout=layout.graphopt,
     vertex.size = 3,vertex.label.cex=1)
###############################
# community discovery in topic
###############################
sizes(gg_coterm.com)
g<-delete.vertices(gg_coterm,gg_coterm.com$membership!=2)
wc <-  fastgreedy.community(g)
wc$membership<-cutat(wc,n=5)
sizes(wc)
#diameter(g,directed=F,unconnected=F)
gwc<-delete.vertices(g,wc$membership!=3)
par(mar = c(0, 0, 0, 0))
set.seed(23)
plot(gwc,layout=layout.graphopt,
     vertex.size = 3,vertex.label.cex=1)
###############################
# draw graph of topic (community)
###############################
#ggplot drawing
library(sna)
#get one of the community
g<-delete.vertices(gg_coterm,gg_coterm.com$membership!=2)
tb <- as.matrix(get.adjacency(g))
m <- tb
plotcord <- data.frame(gplot.layout.kamadakawai(m,NULL))
row.names(plotcord) <- row.names(tb)
out <- NULL
for(i in 1:nrow(tb)){
  seg <- as.matrix(tb[i,tb[i,]>0])
  if(length(seg)!=0){
    seg <- cbind(seg,plotcord[i,]) 
    Xend <- plotcord[row.names(seg),]
    colnames(Xend) <- c("Xend1","Xend2")
    seg <- cbind(seg,Xend) 
    out <- rbind(out,seg)
  }
}
png('ICIS2014.png', height = 8000, width = 8000)
plt(out,plotcord)
dev.off()
###############################
# Drawing by wordcloud 
###############################
library(wordcloud)
par(mar=c(0,0,0,0))
pal <- brewer.pal(6,"Dark2")
png('ICIS2014Wordcloud.png', height = 300, width = 800)
wordcloud(words=attr_tag$keyword,freq=attr_tag$weight,scale=c(5,1),min.freq=10,max.words=500,
          random.order=F,random.color=F,rot.per=0,colors=pal,ordered.colors=F,
          use.r.layout=F,fixed.asp=F)
dev.off()
###############################
# Representative Degree
###############################
sizes(gg_coterm.com)
g<-delete.vertices(gg_coterm,gg_coterm.com$membership!=10)
tb <- as.matrix(get.adjacency(g))
#node-level centrality scores
row.names(tb)[order(centralization.degree(g)$res,decreasing=T)]
row.names(tb)[order(centralization.betweenness(g)$res,decreasing=T)]
row.names(tb)[order(centralization.closeness(g)$res,decreasing=T)]
row.names(tb)[order(centralization.evcent(g)$vector,decreasing=T)]
#topsis
representativeness<-data.frame(keyword=row.names(tb),
                               DC=centralization.degree(g)$res,
                               BC=centralization.betweenness(g)$res,
                               CC=centralization.closeness(g)$res,
                               EC=centralization.evcent(g)$vector)

representativeness<-merge(representativeness,attr_tag[which(as.character(attr_tag$keyword)%in%row.names(tb)),],
                          by.x="keyword",by.y="keyword")
#topsis
library(topsis)
w<-c(1,1,1,1,1)
i<-c("+","+","+","+","+")
result<-topsis(as.matrix(representativeness[,2:6]), w, i)
row.names(result)<-representativeness$keyword
result<-cbind(result,keyword=row.names(result))
representativeness.withresult<-merge(representativeness,result[,2:4],by.x="keyword",by.y="keyword")
head(representativeness.withresult[order(representativeness.withresult$rank,decreasing=F),],15)
representativeness.withresult<-representativeness.withresult[-326,]
#wordcloud
library(wordcloud)
par(mar=c(0,0,0,0))
pal <- brewer.pal(6,"Dark2")
png('ICIS2014Topic_10.png', height = 300, width = 500)
wordcloud(words=representativeness.withresult$keyword,freq=representativeness.withresult$score,scale=c(5,1),min.freq=10,max.words=500,
          random.order=F,random.color=F,rot.per=0,colors=pal,ordered.colors=F,
          use.r.layout=F,fixed.asp=F)
dev.off()
###############################
# heatmap generation
###############################
gg_coterm.com$membership<-cutat(gg_coterm.com,no=10)
length(sizes(gg_coterm.com))
sizes(gg_coterm.com)

topichot<-data.frame(topic=paste("TOPIC",1:length(sizes(gg_coterm.com)),sep=""),
                     RAD=NA,RCD=NA,SRAD=NA,AAD=NA,ACD=NA,TD=NA)
row.names(topichot)<-topichot$topic
for(t in 1:length(sizes(gg_coterm.com))){
  keywordsOfTopic<-gg_coterm.com$names[gg_coterm.com$membership==t]
  papersoftopic<-unique(relation_resource_tag$wosno[which(relation_resource_tag$keyword%in%keywordsOfTopic)])
  citedofeachpaper<-attr_resource$citednum[attr_resource$wosno%in%papersoftopic]
  authorsoftopic<-unique(relation_resource_author$authorid[which(relation_resource_author$wosno%in%papersoftopic)])
  weightofkeywords<-attr_tag$weight[which(as.character(attr_tag$keyword)%in%keywordsOfTopic)]
  #HOT INDICE CALCULATOR
  topichot$RAD[t]<-length(papersoftopic)/length(keywordsOfTopic)
  topichot$RCD[t]<-sum(citedofeachpaper)/length(papersoftopic)
  topichot$SRAD[t]<-sum(citedofeachpaper)/length(keywordsOfTopic)
  topichot$AAD[t]<-length(authorsoftopic)/length(keywordsOfTopic)
  topichot$ACD[t]<-sum(citedofeachpaper)/length(authorsoftopic)
  topichot$TD[t]<-sum(weightofkeywords)/length(keywordsOfTopic)
}
#regularization
for(col in 2:ncol(topichot)){
  topichot[,col]<-topichot[,col]/sqrt(sum(topichot[,col]*topichot[,col]))
}
#topsis
library(topsis)
w<-c(1,1,1,1,1,1)
i<-c("+","+","+","+","+","+")
result<-topsis(as.matrix(topichot[,2:ncol(topichot)]), w, i)
row.names(result)<-topichot$topic
result<-cbind(result,topic=row.names(result))
topichot<-merge(topichot,result[,2:4],by.x="topic",by.y="topic")
topichot.neworder<-topichot[order(topichot$rank,decreasing=F),]
row.names(topichot.neworder)<-topichot.neworder$topic
#heatmap
x  <- as.matrix(topichot.neworder[,2:7])
x
rc <- rainbow(nrow(x), start = 0, end = .3)
cc <- rainbow(ncol(x), start = 0, end = .3)
heatmap(x, Colv = NA,scale = "column",col=heat.colors(256),revC=TRUE)
heatmap(x, Rowv = NA, Colv = NA, scale = "column",col=heat.colors(256),revC=TRUE)
library(pheatmap)
pheatmap(x,clustering_distance_row="euclidean",clustering_method = "complete",
         #color=colorRampPalette(c("green","black","red"))(100), 
         #color = colorRampPalette(c("navy", "white", "firebrick3"))(100),
         revC=FALSE, scale="column",
         legend=F)
pheatmap(x,cluster_cols=FALSE,clustering_distance_row="correlation",clustering_method = "complete",
         #color=colorRampPalette(c("green","black","red"))(100), 
         revC=FALSE, scale="column",
         legend=F,fontsize_row=8,cellheight=10,cellwidth=30,
         margins=c(0,0))
###############################
# topics hot-spots analysis
###############################
gg_coterm.com$membership<-cutat(gg_coterm.com,no=10)
length(sizes(gg_coterm.com))
sizes(gg_coterm.com)

hotspots<-data.frame(topic=paste("TOPIC",1:length(sizes(gg_coterm.com)),sep=""),
                     numofpapers=NA,numofauthors=NA,numofcites=NA,score=NA)
row.names(hotspots)<-hotspots$topic
for(t in 1:length(sizes(gg_coterm.com))){
  keywordsOfTopic<-gg_coterm.com$names[gg_coterm.com$membership==t]
  papersoftopic<-unique(relation_resource_tag$wosno[which(relation_resource_tag$keyword%in%keywordsOfTopic)])
  citedofeachpaper<-attr_resource$citednum[attr_resource$wosno%in%papersoftopic]
  authorsoftopic<-unique(relation_resource_author$authorid[which(relation_resource_author$wosno%in%papersoftopic)])
  weightofkeywords<-attr_tag$weight[which(as.character(attr_tag$keyword)%in%keywordsOfTopic)]
  #HOT INDICE CALCULATOR
  hotspots$numofpapers[t]<-length(papersoftopic)
  hotspots$numofauthors[t]<-length(authorsoftopic)
  hotspots$numofcites[t]<-sum(citedofeachpaper)
}
#regularization
for(col in 2:ncol(hotspots)){
  hotspots[,col]<-hotspots[,col]/sqrt(sum(hotspots[,col]*hotspots[,col]))
}
#score=0.25*numofpapers+0.25*numofauthors+0.5*numofcites
hotspots$score<-0.25*hotspots$numofpapers+0.25*hotspots$numofauthors+0.5*hotspots$numofcites
###############################
# topics hot-spots evolution
###############################
gg_coterm.com$membership<-cutat(gg_coterm.com,no=10)
length(sizes(gg_coterm.com))
sizes(gg_coterm.com)
#total score
hotevolution<-data.frame(topic=paste("TOPIC",1:length(sizes(gg_coterm.com)),sep=""))
attributes(hotspots)$names[5]<-as.character("totalscore")
hotevolution<-merge(hotevolution,hotspots[,c(1,5)],by.x="topic",by.y="topic")
hotevolution
for(year in 2010:2013){
  hotspots<-data.frame(topic=paste("TOPIC",1:length(sizes(gg_coterm.com)),sep=""),
                       numofpapers=NA,numofauthors=NA,numofcites=NA,score=NA)
  row.names(hotspots)<-hotspots$topic
  for(t in 1:length(sizes(gg_coterm.com))){
    keywordsOfTopic<-gg_coterm.com$names[gg_coterm.com$membership==t]
    paperofyear<-attr_resource$wosno[which(attr_resource$year==year)]
    papersoftopic<-unique(relation_resource_tag$wosno[which(relation_resource_tag$keyword%in%keywordsOfTopic)])
    paperofyeartopic<-unique(paperofyear[which(paperofyear%in%papersoftopic)])
    citedofeachyearpaper<-attr_resource$citednum[attr_resource$wosno%in%paperofyeartopic]
    authorsofyeartopic<-unique(relation_resource_author$authorid[which(relation_resource_author$wosno%in%paperofyeartopic)])
    #HOT INDICE CALCULATOR
    hotspots$numofpapers[t]<-length(paperofyeartopic)
    hotspots$numofauthors[t]<-length(authorsofyeartopic)
    hotspots$numofcites[t]<-sum(citedofeachyearpaper)
  }
  #regularization
  for(col in 2:ncol(hotspots)){
    hotspots[,col]<-hotspots[,col]/sqrt(sum(hotspots[,col]*hotspots[,col]))
  }
  #score=0.25*numofpapers+0.25*numofauthors+0.5*numofcites
  hotspots$score<-0.25*hotspots$numofpapers+0.25*hotspots$numofauthors+0.5*hotspots$numofcites
  #hotspots$score<-0.5*hotspots$numofpapers+0.5*hotspots$numofauthors
  #merging
  attributes(hotspots)$names[5]<-paste(as.character("score"),year,sep="")
  hotevolution<-merge(hotevolution,hotspots[,c(1,5)],by.x="topic",by.y="topic")
}
hotevolution
###############################
# topics trend graph
###############################
library(ggplot2)
hotevolution
hotevolution<-hotevolution[order(hotevolution$totalscore,decreasing=T),]
hottrend<-NULL
for(topic in 1:10){
  for(year in 2010:2013){
    temp<-data.frame(topic=hotevolution$topic[topic],year=year,score=hotevolution[topic,year-2007])
    hottrend<-rbind(hottrend,temp)
  }
}
hottrend
myplot<-ggplot(data=hottrend,mapping=aes(x=year,y=score,group=topic))
myplot<-myplot+labs(x='Year', y='Hot')
myplot + geom_line(aes(colour = topic),size=2)

myplot<-ggplot(data=hottrend[which(hottrend$topic%in%c("TOPIC2","TOPIC5","TOPIC1","TOPIC4","TOPIC3")),],
               mapping=aes(x=year,y=score,group=topic))
myplot<-myplot+labs(x='Year', y='Score')
myplot + geom_line(aes(colour = topic),size=2)

myplot<-ggplot(data=hottrend[which(hottrend$topic%in%c("TOPIC9","TOPIC6","TOPIC8","TOPIC7","TOPIC10")),],
               mapping=aes(x=year,y=score,group=topic))
myplot<-myplot+labs(x='Year', y='Score')
myplot + geom_line(aes(colour = topic),size=2)

myplot<-ggplot()
myplot<-myplot+geom_line(mapping=aes(x=c(2010:2013),y=as.numeric(hotevolution[2,3:6])),colour="red",size=2)
myplot<-myplot+geom_line(mapping=aes(x=c(2010:2013),y=as.numeric(hotevolution[5,3:6])),colour="orange",size=2)
myplot<-myplot+geom_line(mapping=aes(x=c(2010:2013),y=as.numeric(hotevolution[1,3:6])),colour="blue",size=2)
myplot<-myplot+geom_line(mapping=aes(x=c(2010:2013),y=as.numeric(hotevolution[4,3:6])),colour="green",size=2)
myplot<-myplot+geom_line(mapping=aes(x=c(2010:2013),y=as.numeric(hotevolution[3,3:6])),colour="brown",size=2)
myplot<-myplot+labs(x='YEAR', y='Hot')
myplot

myplot<-ggplot()
myplot<-myplot+geom_line(mapping=aes(x=c(2010:2013),y=as.numeric(hotevolution[9,3:6])),colour="red",size=2)
myplot<-myplot+geom_line(mapping=aes(x=c(2010:2013),y=as.numeric(hotevolution[6,3:6])),colour="orange",size=2)
myplot<-myplot+geom_line(mapping=aes(x=c(2010:2013),y=as.numeric(hotevolution[8,3:6])),colour="blue",size=2)
myplot<-myplot+geom_line(mapping=aes(x=c(2010:2013),y=as.numeric(hotevolution[7,3:6])),colour="green",size=2)
myplot<-myplot+geom_line(mapping=aes(x=c(2010:2013),y=as.numeric(hotevolution[10,3:6])),colour="brown",size=2)
myplot<-myplot+labs(x='YEAR', y='Hot')
myplot
###############################
# topicmodels using LDA 
###############################
library(topicmodels)
#library(lda)
matrxRT<-table(relation_resource_tag$wosno,relation_resource_tag$keyword)
results<-LDA(matrxRT, 10, method = "VEM")
###############################
# END
###############################