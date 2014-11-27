######
# convertDimensionToAttribute
##function
convertDimensionToAttribute<-function(data,dimensions,values,DIMENSION_NAME="ATTRIBUTE",VALUE_NAME="VALUE"){
  head(data$UNIQUE<-c(1:nrow(data)),1)
  head(rownames(data)<-c(1:nrow(data)),1)
  head(AttributeWithValue<-as.data.frame(
              as.table(
                as.matrix(
                  data[,values]
                ))),5)
  head(colnames(AttributeWithValue)<-c("UNIQUE",DIMENSION_NAME,VALUE_NAME),1)
  library(plyr)
  system.time(result <- join(data[,append(dimensions,ncol(data))], AttributeWithValue, by = c("UNIQUE")))
  result$UNIQUE<-NULL
  head(result)
  return(result)
}
######
# from-to
#colnames(z)<-c("from","to","freq")
#new_z<-mdply(z,function(from,to,freq){data.frame(from=rep(from,freq),to=rep(to,freq))},.expand = F)
#final_z<-as.matrix(table(new_z$from,new_z$to))
#####
# Transformation
#####
#Dim_PROVENCE
head(ProjectOrder$Amount[,c(1:2,3:21)],1)
sum(as.matrix(ProjectOrder$Amount[,c(3:21)]))
result<-convertDimensionToAttribute(data = ProjectOrder$Amount,
                                    dimensions = c(1:2),
                                    values = c(3:21),
                                    DIMENSION_NAME="PROVIENCE_CODE")
length(unique(paste(result$UNIQUE_PROJECT_CODE,result$PROJ_NAME,"-")))
head(ProjectOrder$ProvenceResult<-result[-which(result$VALUE==0),],1)
length(unique(paste(ProjectOrder$ProvenceResult$UNIQUE_PROJECT_CODE,ProjectOrder$ProvenceResult$PROJ_NAME,"-")))
system.time(ProjectOrder$ProvenceResult <- join(ProjectOrder$ProvenceResult, Source_Provence, by = c("PROVIENCE_CODE")))
ProjectOrder$ProvenceResult$VALUE<-NULL
head(ProjectOrder$ProvenceResult,1)
#Dim_PROJECTTYPE
head(ProjectOrder$Amount[,c(1:2,22:86)],1)
result<-convertDimensionToAttribute(data = ProjectOrder$Amount,
                                    dimensions = c(1:2),
                                    values = c(22:86),
                                    DIMENSION_NAME="PROJ_GRP_CODE_ALIAS")
head(ProjectOrder$ProjectTypeResult<-result[-which(result$VALUE==0),])
system.time(ProjectOrder$ProjectTypeResult <- join(ProjectOrder$ProjectTypeResult, Source_ProjectType, by = c("PROJ_GRP_CODE_ALIAS")))
ProjectOrder$ProjectTypeResult$VALUE<-NULL
head(ProjectOrder$ProjectTypeResult,1)
#####
#ResultATable
length(unique(paste(ProjectOrder$ProjectTypeResult$UNIQUE_PROJECT_CODE,ProjectOrder$ProjectTypeResult$PROJ_NAME,"-")))
length(unique(paste(ProjectOrder$ProvenceResult$UNIQUE_PROJECT_CODE,ProjectOrder$ProvenceResult$PROJ_NAME,"-")))
system.time(ResultATable <- join(ProjectOrder$ProjectTypeResult, 
                                 ProjectOrder$ProvenceResult, 
                                 by = c("UNIQUE_PROJECT_CODE","PROJ_NAME")))
head(ResultATable)
which(ResultATable$UNIQUE_PROJECT_CODE=="")
nrow(ResultATable)
nrow(ResultATable<-unique(ResultATable))
length(unique(paste(ResultATable$UNIQUE_PROJECT_CODE,ResultATable$PROJ_NAME,"-")))
write.csv(x = ResultATable,file = "Result_Table_A.csv",row.names = F)