
#This creates the data

#Input of elevation data in meters
m <- c(1500,2020,2720,3400)
#Input of precip data (mm) at each elevation
ppt <- c(938.3,797.6,593.2,475.6)
#Input of mean temperature data (degrees celsius) at each elevation
temp <- c(17.9,14.9,10.8,7.1)
#Input of soil C:N ratio at each elevation
cn <- c(21.04,21.56,19.33,19.27)
#Input of O-horizon soil pH at each elevation
pH <- c(4.25,4.1,4.2,4.12)

#######
#This explores correlations
cor(m,ppt)
plot(m, ppt)
cor(m,temp)
cor(temp,ppt)
cor(m,cn)
cor(m,pH)
cor(temp,pH)

#######
#This creates a data.frame
abiotic <- data.frame(elevation.m= m, precip.mm=ppt,temp.C = temp, cn = cn, pH= pH)
#Plot all possible combinations of these variables with blue symbols
plot(abiotic, col= "blue")
plot(abiotic, col = "red", pch=5)

#######
#This fits the model
m1 <- lm(pH~temp.C, data= abiotic) # one line :-)

summary(m1)

plot(pH~temp.C, data= abiotic)
abline(m1, col = "blue")

# Exercise: try making other models with this data
# maybe....
#This fits the model
m2 <- lm(precip.m~elevation.m, data= abiotic) # one line :-)


#######
#The mtcars data
mtcars

# plot some data
library(ggplot2)
ggplot(mtcars, 
       aes(wt,
           mpg)) +
  geom_point()  +
  stat_smooth(method = "lm") +
  theme_bw()

#This fits the model
model1 <- lm(mpg~wt,data=mtcars)
summary(model1)

########
#Diagnostics
plot(fitted(model1),resid(model1))
abline(h=0)

plot(fitted(model1),abs(resid(model1)))

summary(lm(abs(resid(model1))~ fitted(model1)))

plot(resid(model1)~fitted(model1),pch=unclass(mtcars$am))

library(car)
leveneTest(mtcars$mpg,mtcars$am)

qqnorm(resid(model1),ylab="Residuals")
qqline(resid(model1))

plot(density(resid(model1)))
rug(resid(model1), col="red")

gi <- influence(model1)
qqnorm(gi$coef[,2])
par(mfrow=c(2,2))
plot(model1)

