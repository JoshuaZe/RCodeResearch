#模型优化
train.col.types <- c('integer', # PassengerId
                     'factor', # Survived
                     'factor', # Pclass
                     'character', # Name
                     'factor', # Sex
                     'numeric', # Age
                     'integer', # SibSp
                     'integer', # Parch
                     'character', # Ticket
                     'numeric', # Fare
                     'character', # Cabin
                     'factor' # Embarked
)
test.col.types=train.col.types[-2]
train.raw=read.csv("./train.csv",colClasses=train.col.types,na.strings=c("NA",""))
test.raw=read.csv("./test.csv",colClasses=test.col.types,na.strings=c("NA",""))
#数据整理与清洗
#这里格式是xx, Title . xx xx
getTitle = function(data) {
  title.start = regexpr("\\,[A-Z ]{1,20}\\.", data$Name, TRUE)
  title.end = title.start+attr(title.start, "match.length")-1
  data$Title = substr(data$Name, title.start+2, title.end-1)
  return (data$Title)
}
train.raw$Title=getTitle(train.raw)
require(dplyr)
head(train.raw %>% group_by(Title) %>% summarise(count=n())%>%arrange(desc(count)))
title.filter=c("Mr","Mrs","Miss","Master","Professional")
recodeTitle = function(data,title.filter) {
  if(!(data %in% title.filter))
    data = "Professional"
  return (data)
}
train.raw$Title=sapply(train.raw$Title,recodeTitle,title.filter)
#简单利用median来对年龄进行插值,Embarked的NA直接使用“S”,fare根据class的median来计算
imputeAge = function(Age,Title,title.filter) {
  for(v in title.filter) {
    Age[is.na(Age)]=median(Age[Title==v],na.rm=T)    
  }
  return(Age)
}
title.filter=c("Mr","Mrs","Miss","Master","Professional")
train.raw$Age=imputeAge(train.raw$Age,train.raw$Title,title.filter)
imputeEmbarked=function(Embarked) {
  Embarked[is.na(Embarked)]="S"
  return(Embarked)
}
train.raw$Embarked=imputeEmbarked(train.raw$Embarked)
imputeFare = function(fare,pclass,pclass.filter) {
  for(v in pclass.filter) {
    fare[is.na(fare)]=median(fare[pclass==v],na.rm=T)    
  }
  return(fare)
}
pclass.filter=c(1,2,3)
train.raw$fare=imputeFare(train.raw$Fare,train.raw$Pclass,pclass.filter)