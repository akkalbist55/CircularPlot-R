require(ggplot2)
require(grid)
require(gridExtra)

require(yyplot)
cake1 <- ggplot2:::cakeCandleGrob("#FF3399")
cake2 <- ggplot2:::cakeCandleGrob("steelblue")
cake3 <- ggplot2:::cakeCandleGrob("#FF0000")
cake4 <- ggplot2:::cakeCandleGrob("#FF34B3")
grid.arrange(grobs = gList(cake1, cake2,cake3,cake4), ncol = 2)







t <- seq(0,2*pi, by = 0.16)
x <- 16*sin(t)^3
y <- 13*cos(t) - 5*cos(2*t) - 2*cos(3*t) - cos(4*t)
d <- data.frame(x = x, y = y)

p1 <- ggplot(d, aes(x, y)) + geom_cake() + theme_void()
p1 + annotate("text", x = 0, y = 0, label = "Happy birthday,sweetheart",
              colour = "red", size = 9)






d$color.cake = sample(colorspace::rainbow_hcl(20), nrow(d), replace = T)
d$color.candle = sample(rainbow(20), nrow(d), replace = T)
p2 <- ggplot(d, aes(x, y)) +
  geom_cake(aes(color.cake = color.cake,
                color.candle = color.candle),
            size = .1) + theme_void()
p2 + annotate("text", x = 0, y = 0, label = "Happy birthday,sweetheart",
              colour = "red", size = 9)




d$color.cake = sample(colorspace::rainbow_hcl(5), nrow(d), replace = T)
d$color.candle = sample(rainbow(5), nrow(d), replace = T)
d$size = runif(nrow(d), 0.05, 0.1)
d$angle = runif(nrow(d), -360, 360)
p3 <- ggplot(d, aes(x, y)) +
  geom_cake(aes(color.cake = color.cake,
                color.candle = color.candle,
                color.fire = color.cake,
                size = I(size),
                angle = angle)) + theme_void()
p3 + annotate("text", x = 0, y = 0, label = "Happy birthday,sweetheart",
              colour = "red", size = 9)
