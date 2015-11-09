# *------------------------------------------------------------------
# | PROGRAM NAME: R_BASIC_SNA
# | DATE: 4/9/12
# | CREATED BY: MATT BOGARD 
# | PROJECT FILE: P:\R  Code References\SNA            
# *----------------------------------------------------------------
# | PURPOSE: DEMONSTRATION OF BASIC CONCEPTS OF NETWORK ANALYSIS              
# | REFERENCES: Conway, Drew. Social Network Analysis in R. 
# | New York City R User Group Meetup Presentation August 6, 2009
# | http://www.drewconway.com/zia/wp-content/uploads/2009/08/sna_in_R.pdf
# *------------------------------------------------------------------

#---------------------------------------
#
# analytics
#
#---------------------------------------

library(igraph)
library(rpart)

#--------------------------------------
# get data 
#--------------------------------------

# specify the adjacency matrix
M <- matrix(c(0, 0, 0, 1, 0, 0, 0, 0, 0, 0,0, 0, 0, 1, 0, 0, 0, 0, 0, 0,0, 0, 0, 1, 0, 0, 0, 0, 0, 0,1, 1, 1, 0, 1, 0, 0, 0, 1, 0,0,0, 0, 1, 0, 1, 1, 1, 0, 0,0, 0, 0, 0, 1, 0, 0, 0, 0, 0,0 ,0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,0,0, 0, 1, 0, 0, 0, 0, 0, 1,0, 0, 0, 0, 0, 0, 0, 0, 1, 0 ),10,10, byrow= TRUE)
G<-graph.adjacency(M, mode=c("undirected"))               # convert key player network matrix to an igraph object    
cent<-data.frame(bet=betweenness(G),eig=evcent(G)$vector) # calculate betweeness & eigenvector centrality 
res<-as.vector(lm(eig~bet,data=cent)$residuals)           # calculate residuals
cent<-transform(cent,res=res)                             # add to centrality data set
write.csv(cent,"r_keyactorcentrality.csv")                  # save in project folder

#--------------------------------------
# visualize the network
#--------------------------------------

# plot that reflects correct vertex names and scaled by centrality

plot(G, layout = layout.fruchterman.reingold, vertex.size = 20*evcent(G)$vector, vertex.label = rownames(cent))

#-------------------------------------------
# create analysis data set
#------------------------------------------

id <- c(1,2,3,4,5,6,7,8,9,10)  # create individual id's for reference
income <- c(35000, 37000, 43000, 63000, 72000, 27000, 30000, 34000, 45000, 55000) # income
default <- c(1,1,1,0,0,1,1,1,1,1) # loan default indicator

#-------------------------------------------
# basic regression
#------------------------------------------

creditrisk <- cbind(id,income, cent, default) # combine with eigenvector centrality derived above

# model default risk as a function of income and network relationship 

# OLS
model1 <- lm(creditrisk$default~  creditrisk$eig + creditrisk$income) 
summary(model1)

#logistic regression
model2 <- glm(creditrisk$default~  creditrisk$eig + creditrisk$income, family=binomial(link="logit"), na.action=na.pass)
summary(model2)

# decision tree
model3 <- rpart(creditrisk$default~  creditrisk$eig + creditrisk$income)
summary(model3)

