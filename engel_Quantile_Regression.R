library(quantreg)
example(rq)
#####
#engel,tau = 0.5
data(engel)
head(engel)
#foodexp(Y) ~ income(X)
#tau of Y
fit1 <- rq(foodexp ~ income, tau = 0.5, data = engel)
fit1
#get upper bound and lower bound of coefficients
#se=rank
summary(fit1)
#residuals:extracts model residuals from objects returned by modeling functions
r1 <- resid(fit1)
#coefficients of model
c1 <- coef(fit1)
#kernal
summary(fit1,se = "ker")
#bootstrap
summary(fit1,se = "boot")

#####
#engel coefficients for different tau
xx <- income - mean(income)
fit1 <- summary(rq(foodexp~xx,tau=2:98/100))
fit2 <- summary(rq(foodexp~xx,tau=c(.05, .25, .5, .75, .95)))
#new window
#windows(5,5)
plot(fit1)
plot(fit2)
# pdf("engelcoef.pdf",width=6.5,height=3.5)
# plot(fit1,mfrow = c(1,2))
# dev.off()
# latex(fit2, caption="Engel's Law", transpose=TRUE)

#####
#engel, regression with different tau
attach(engel)
plot(income,foodexp,cex=.25,type="n",xlab="Household Income", ylab="Food Expenditure")
#draw points
points(income,foodexp,cex=0.5,col="blue")
#draw line with tau = 0.5
abline(rq(foodexp~income,tau=0.5),col="blue")
#the dreaded ols line
#lm fit linear models
abline(lm(foodexp~income),lty=2,col="red")
#draw regression line with taus
taus <- c(.05,.1,.25,.75,.90,.95)
for(i in 1:length(taus)){
  abline(rq(foodexp~income,tau=taus[i]),col="gray")
}

#####
#fit model comparation of different taus
#anova of Quantile Regression
fit1 <- rq(foodexp~income,tau=.25)
fit2 <- rq(foodexp~income,tau=.50)
fit3 <- rq(foodexp~income,tau=.75)
anova(fit1, fit2, fit3)

#####
#Poor VS Rich of Expenditure
#tau outside this range,all values of tau in (0,1) are desired
z <- rq(foodexp~income,tau=-1)
z$sol
#Poor is defined as at the .1 quantile of the sample distn
x.poor <- quantile(income,.1)
#Rich is defined as at the .9 quantile of the sample distn
x.rich <- quantile(income,.9)
#each tau
ps <- z$sol[1,]
#Food Expenditure of poor and rich in each tau of Food Expenditure
qs.poor <- c(c(1,x.poor)%*%z$sol[4:5,])
qs.rich <- c(c(1,x.rich)%*%z$sol[4:5,])
## now plot the two quantile functions to compare
par(mfrow = c(1,2))
plot(c(ps,ps),c(qs.poor,qs.rich), type="n", xlab = expression(tau), ylab = "quantile")
# Food Expenditure step function for poor in each tau of Food Expenditure
plot(stepfun(ps,c(qs.poor[1],qs.poor)), do.points=FALSE, add=TRUE)
# Food Expenditure step function for rich in each tau of Food Expenditure
plot(stepfun(ps,c(qs.poor[1],qs.rich)), do.points=FALSE, add=TRUE,col.hor = "gray", col.vert = "gray")
## now plot associated conditional density estimates
## weights from ps (process)
ps.wts <- (c(0,diff(ps)) + c(diff(ps),0))/2
## Univariate adaptive kernel density estimation
ap <- akj(qs.poor, z=qs.poor, p = ps.wts)
ar <- akj(qs.rich, z=qs.rich, p = ps.wts)
plot(c(qs.poor,qs.rich),c(ap$dens,ar$dens),type="n",xlab= "Food Expenditure", ylab= "Density")
lines(qs.rich, ar$dens, col="gray")
lines(qs.poor, ap$dens, col="black")
legend("topright", c("poor","rich"), lty = c(1,1), col=c("black","gray"))

#####
#log qr
plot(income,foodexp,log="xy",xlab="Household Income", ylab="Food Expenditure")
taus <- c(.05,.1,.25,.75,.90,.95)
abline(rq(log10(foodexp)~log10(income),tau=.5),col="blue")
abline(lm(log10(foodexp)~log10(income)),lty = 3,col="red")
for( i in 1:length(taus)){
  abline(rq(log10(foodexp)~log10(income),tau=taus[i]),col="gray")
}