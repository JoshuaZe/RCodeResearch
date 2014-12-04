#初次建模
#构建训练集与测试集
require(caret)
set.seed(201409)
inTrain = createDataPartition(train.raw$Survived,
                              p = 0.8, list = FALSE)
training = train.raw[inTrain, ]
test = train.raw[-inTrain, ]
#逻辑回归
first.class.age=median(training[training$Pclass=="1",]$Age,na.rm=T)
second.class.age=median(training[training$Pclass=="2",]$Age,na.rm=T)
third.class.age=median(training[training$Pclass=="1",]$Age,na.rm=T)
training[is.na(training$Age)&training$Pclass=="1",]$Age=first.class.age
training[is.na(training$Age)&training$Pclass=="2",]$Age=second.class.age
training[is.na(training$Age)&training$Pclass=="3",]$Age=third.class.age
third.class.fare=median(training[training$Pclass=="3",]$Fare,na.rm=T)
model.logit.1 <- train(Survived ~ Sex + Pclass + Age + Embarked + Fare,
                       data = training, method="glm")
model.logit.1
#bootstrap 采样方式
first.class.age=median(test[test$Pclass=="1",]$Age,na.rm=T)
second.class.age=median(test[test$Pclass=="2",]$Age,na.rm=T)
third.class.age=median(test[test$Pclass=="1",]$Age,na.rm=T)
test[is.na(test$Age)&test$Pclass=="1",]$Age=first.class.age
test[is.na(test$Age)&test$Pclass=="2",]$Age=second.class.age
test[is.na(test$Age)&test$Pclass=="3",]$Age=third.class.age
predict.model.1=predict(model.logit.1,test)
table(test$Survived,predict.model.1)

sensitivity(test$Survived,predict.model.1)
specificity(test$Survived,predict.model.1)

#ROC
require(ROCR)
predictions.model.1=prediction(c(predict.model.1),labels=test$Survived)
perf = performance(predictions.model.1, measure = "tpr", x.measure = "fpr")
plot(perf, main = "ROC curve",col = "blue", lwd = 2)
abline(a = 0, b = 1, lwd = 2, lty = 2)

#预测
first.class.age=median(test.raw[test.raw$Pclass=="1",]$Age,na.rm=T)
second.class.age=median(test.raw[test.raw$Pclass=="2",]$Age,na.rm=T)
third.class.age=median(test.raw[test.raw$Pclass=="1",]$Age,na.rm=T)
test.raw[is.na(test.raw$Age)&test.raw$Pclass=="1",]$Age=first.class.age
test.raw[is.na(test.raw$Age)&test.raw$Pclass=="2",]$Age=second.class.age
test.raw[is.na(test.raw$Age)&test.raw$Pclass=="3",]$Age=third.class.age
test.raw[153,]$Fare=third.class.fare
predict.final.model.1=predict(model.logit.1,newdata=test.raw)
predictions=data.frame(PassengerId=test.raw$PassengerId, Survived=predict.final.model.1)
write.csv(predictions,file="Titanic_predictions_1.csv", row.names=FALSE, quote=FALSE)