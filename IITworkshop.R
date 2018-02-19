a <- 2

b <- c(2,3,4)

c <- matrix(c(1,2,3,4,5,6),ncol = 2)

setwd("/home/akkal/swastik")

getwd()

d<-data.frame(name = c('A','B','C'),age=c(20,22,30))

d

x <- mtcars

x

data("mtcars")

df<- mtcars

 df
 
colnames(df)

df$mpg

df['mpg']

mean(df$wt)

median(df$wt)

min(df$wt)

veac <- c(1,2,3,NA)

max(veac, na.rm = TRUE)

class('df')

df

head(df)

plot(rnorm(10))

plot(c(2,3,5,6))

plot(seq(1,100,by=22))

plot(x = seq(1,100,by=2), y = seq(1,100,by=2)^2)

plot(x= df$wt, y=df$mpg,main='Weight vs MPG',xlab='Weight',ylab = 'MPG')

abline(lsfit(df$wt,df$mpg))

cor(df$wt,df$mpg)

cor(df)
df

hist(df$wt)
hist(df$mpg)

barplot(df$mpg)
barplot(df$wt)

new_df <- read.csv('mtcars.csv')
new_df

barplot(df$cyl)

round(df$mpg)


