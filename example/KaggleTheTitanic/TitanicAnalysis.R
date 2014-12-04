setwd("C:/Users/Joshua/Desktop/Accenture1/Matlab To R/KaggleTheTitanic")
#数据准备
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
test.col.types<-train.col.types[-2]
train.raw<-read.csv("./train.csv",colClasses=train.col.types,na.strings=c("NA",""))
test.raw<-read.csv("./test.csv",colClasses=test.col.types,na.strings=c("NA",""))
dim(train.raw)
dim(test.raw)

#数据探索
summary(train.raw)
summary(test.raw)
#查看缺失数据
require(Amelia)
missmap(train.raw, main="Titanic缺失数据图",
        col=c("yellow", "black"), legend=FALSE)
#Cabin，Age有较多缺失数据，而Embark只有两个缺失数据
#生还与死亡对比
barplot(table(train.raw$Survived),names.arg=c("死亡","生还"),
        main="生还 vs 死亡")
#不同舱位等级的影响
survive.rate.class=table(train.raw$Survived,train.raw$Pclass)
barplot(survive.rate.class,names.arg=c("一等","二等","三等"),
        main="不同舱位生还 vs 死亡",
        legend.text=c("死亡","生还"),
        args.legend=list(x="topleft"))
round((survive.rate.class[2,]/colSums(survive.rate.class))*100,2)
#不同性别的生还率对比
survive.rate.sex=table(train.raw$Survived,train.raw$Sex)
barplot(survive.rate.sex,names.arg=c("女","男"),
        main="不同性别生还 vs 死亡",
        legend.text=c("死亡","生还"),
        args.legend=list(x="topleft"))
round((survive.rate.sex[2,]/colSums(survive.rate.sex))*100,2)
#不同年龄的生还率
age.breaker=c(0,18,50,100)
age.cut= cut(train.raw$Age,breaks=age.breaker,,labels=c("小孩","成年人","老人"))
train.raw$age.cut=age.cut
survive.rate.age=table(train.raw$Survived,train.raw$age.cut)
barplot(survive.rate.age,
        main="不同年龄生还 vs 死亡",
        legend.text=c("死亡","生还"),
        args.legend=list(x="topleft"))
round((survive.rate.age[2,]/colSums(survive.rate.age))*100,2)
age.breaker=c(0,15,55,100)
age.cut= cut(train.raw$Age,breaks=age.breaker,,labels=c("小孩","成年人","老人"))
train.raw$age.cut=age.cut
survive.rate.age=table(train.raw$Survived,train.raw$age.cut)
barplot(survive.rate.age,
        main="不同年龄生还 vs 死亡",
        legend.text=c("死亡","生还"),
        args.legend=list(x="topleft"))
round((survive.rate.age[2,]/colSums(survive.rate.age))*100,2)
#马赛克图
mosaicplot(train.raw$Pclass ~ train.raw$Survived,
           main="不同舱位等级生还 vs 死亡 ", shade=FALSE,
           color=TRUE, xlab="舱位", ylab="生还")
mosaicplot(train.raw$Sex ~ train.raw$Survived,
           main="不同性别生还 vs 死亡 ", shade=FALSE,
           color=TRUE, xlab="性别", ylab="生还")
#相关性分析
train.corrgram = train.raw
# 相关性分析要求全部为数字
train.corrgram$Survived <- as.numeric(train.corrgram$Survived)
train.corrgram$Pclass <- as.numeric(train.corrgram$Pclass)
train.corrgram$Embarked <- as.numeric(train.corrgram$Embarked)
train.corrgram$Sex <- as.numeric(train.corrgram$Sex)
train.corrgram[which(is.na(train.corrgram$Embarked)),]$Embarked=3
cor(train.corrgram[,corrgram.vars])
#图形分析
require(corrgram)
corrgram.vars = c("Survived", "Pclass", "Sex", "Age",
                  "SibSp", "Parch", "Fare", "Embarked")
corrgram(train.corrgram[,corrgram.vars], lower.panel=panel.ellipse, 
         upper.panel=panel.pie,text.panel=panel.txt, main="泰坦尼克生还率相关性分析")
