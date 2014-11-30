#####
#Single-hidden-layer neural network
#####
library(nnet)
# use half the iris data
ir <- rbind(iris3[,,1],iris3[,,2],iris3[,,3])
targets <- class.ind( c(rep("s", 50), rep("c", 50), rep("v", 50)) )
samp <- c(sample(1:50,25), sample(51:100,25), sample(101:150,25))
ir1 <- nnet(ir[samp,], targets[samp,], size = 2, rang = 0.1,
            decay = 5e-4, maxit = 200)
test.cl <- function(true, pred) {
  true <- max.col(true)
  cres <- max.col(pred)
  table(true, cres)
}
test.cl(targets[-samp,], predict(ir1, ir[-samp,]))
# or
ird <- data.frame(rbind(iris3[,,1], iris3[,,2], iris3[,,3]),
                  species = factor(c(rep("s",50), rep("c", 50), rep("v", 50))))
samp <- c(sample(1:50,25), sample(51:100,25), sample(101:150,25))
ir.nn2 <- nnet(species ~ ., data = ird, subset = samp, size = 2, rang = 0.1,
               decay = 5e-4, maxit = 200)
table(ird$species[-samp], predict(ir.nn2, ird[-samp,], type = "class"))
# or
# use half the iris data
# Evaluates the Hessian (matrix of second derivatives) of the specified neural network
ir <- rbind(iris3[,,1], iris3[,,2], iris3[,,3])
targets <- matrix(c(rep(c(1,0,0),50), rep(c(0,1,0),50), rep(c(0,0,1),50)),
                  150, 3, byrow=TRUE)
samp <- c(sample(1:50,25), sample(51:100,25), sample(101:150,25))
ir1 <- nnet(ir[samp,], targets[samp,], size=2, rang=0.1, decay=5e-4, maxit=200)
#Spectral Decomposition of a Matrix
eigen(nnetHess(ir1, ir[samp,], targets[samp,]), TRUE)$values
# predict
predict(ir.nn2, ird[-samp,], type = "class")
#####
#Neural Networks in R using the Stuttgart Neural Network Simulator
#####
library(RSNNS)
#Create and train an artmap network
data(snnsData)
trainData <- snnsData$artmap_train.pat
testData <- snnsData$artmap_test.pat
model <- artmap(trainData, nInputsTrain=70, nInputsTargets=5,
                nUnitsRecLayerTrain=50, nUnitsRecLayerTargets=26)
model$fitted.values
predict(model, testData)
#Dynamic learning vector quantization (DLVQ) networks
data(snnsData)
dataset <- snnsData$dlvq_ziff_100.pat
inputs <- dataset[,inputColumns(dataset)]
outputs <- dataset[,outputColumns(dataset)]
model <- dlvq(inputs, outputs)
fitted(model) == outputs
mean(fitted(model) - outputs)
#####
#Create and train a multi-layer perceptron (MLP)
#####
data(iris)
#shuffle the vector
iris <- iris[sample(1:nrow(iris),length(1:nrow(iris))),1:ncol(iris)]
irisValues <- iris[,1:4]
irisTargets <- decodeClassLabels(iris[,5])
#irisTargets <- decodeClassLabels(iris[,5], valTrue=0.9, valFalse=0.1)
iris <- splitForTrainingAndTest(irisValues, irisTargets, ratio=0.15)
iris <- normTrainingAndTestSet(iris)
model <- mlp(iris$inputsTrain, iris$targetsTrain, size=5, learnFuncParams=c(0.1),
             maxit=50, inputsTest=iris$inputsTest, targetsTest=iris$targetsTest)
summary(model)
model
weightMatrix(model)
extractNetInfo(model)
par(mfrow=c(2,2))
plotIterativeError(model)
predictions <- predict(model,iris$inputsTest)
plotRegressionError(predictions[,2], iris$targetsTest[,2])
confusionMatrix(iris$targetsTrain,fitted.values(model))
confusionMatrix(iris$targetsTest,predictions)
plotROC(fitted.values(model)[,2], iris$targetsTrain[,2])
plotROC(predictions[,2], iris$targetsTest[,2])
#confusion matrix with 402040-method
confusionMatrix(iris$targetsTrain, encodeClassLabels(fitted.values(model),
                                                     method="402040", l=0.4, h=0.6))
