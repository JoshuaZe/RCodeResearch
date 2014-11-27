library(plm)

data("Gasoline", package = "plm")
head(Gasoline)
nrow(Gasoline)
Gasoline <- plm.data(Gasoline, c("country","year"))
head(Gasoline)

y<-by(Gasoline,Gasoline[,c("country","year")],function(x) x)
length(y)
#混合估计模型
gas_pool <- plm(lcarpcap ~ lrpmg, data = Gasoline, 
               model = "pooling")
summary(gas_pool)
#固定效应模型
gas_fe <- plm(lcarpcap ~ lag(lcarpcap,1), data = Gasoline, 
                model = "within")
gas_fe
plot(gas_fe$model)
pFtest(gas_fe, gas_pool)
#随机效应模型
gas_re <- plm(lcarpcap ~ lag(lcarpcap,1), data = Gasoline, 
              effect = "individual", model = "random", random.method = "swar",
              inst.method = "bvk") 
gas_re
gas_re$model
summary(gas_re)
phtest(gas_re, gas_fe)

#动态随机效应模型
data("EmplUK", package = "plm")
head(EmplUK)
EmplUK <- plm.data(EmplUK, c("firm","year"))
fit <- pgmm(log(emp) ~ lag(log(emp), 1:2) + lag(log(wage), 0:1)
           + log(capital) + lag(log(output), 0:1) | lag(log(emp), 2:99),
           data = EmplUK, effect = "twoways", model = "twosteps")
fit <- pgmm(log(emp) ~ log(wage) + log(capital) + log(output),
           lag.form = list(2,1,0,1), data = EmplUK, 
           effect = "twoways", model = "twosteps",
           gmm.inst = ~log(emp), lag.gmm = list(c(2,99)))
fit <- pgmm(dynformula(log(emp) ~ log(wage) + log(capital), list(1,1,1)), 
           data = EmplUK, effect = "twoways", model = "onestep", 
           gmm.inst = ~log(emp) + log(wage) + log(capital), 
           lag.gmm = c(2,99), transformation = "ld")
summary(fit)
fit <- pgmm(log(emp) ~ lag(log(emp), 1) + lag(log(wage), 1) | lag(log(emp), 2:99),
            data = EmplUK, effect = "individual", model = "onestep")
head(fit$fitted.values,1)
plot(fit$fitted.values[,1],type = "l")
fit$W[[1]]
fit$A1
fit$A2
