
## Postwork 6.

# Supongamos que nuestro trabajo consiste en aconsejar a un cliente sobre 
# como mejorar las ventas de un producto particular, y el conjunto de datos 
# con el que disponemos son datos de publicidad que consisten en las ventas 
# de aquel producto en 200 diferentes mercados, junto con presupuestos de 
# publicidad para el producto en cada uno de aquellos mercados para tres 
# medios de comunicación diferentes: TV, radio, y periódico. No es posible 
# para nuestro cliente incrementar directamente las ventas del producto. Por 
# otro lado, ellos pueden controlar el gasto en publicidad para cada uno de 
# los tres medios de comunicación. Por lo tanto, si determinamos que hay una 
# asociación entre publicidad y ventas, entonces podemos instruir a nuestro 
# cliente para que ajuste los presupuestos de publicidad, y así 
# indirectamente incrementar las ventas. 
# 
# En otras palabras, nuestro objetivo 
# es desarrollar un modelo preciso que pueda ser usado para predecir las 
# ventas sobre la base de los tres presupuestos de medios de comunicación. Ajuste 
# modelos de regresión lineal múltiple a los datos advertisement.csv y elija el 
# modelo más adecuado siguiendo los procedimientos vistos
# 
# Considera:
#   
# - Y: Sales (Ventas de un producto)
# - X1: TV (Presupuesto de publicidad en TV para el producto)
# - X2: Radio (Presupuesto de publicidad en Radio para el producto)
# - X3: Newspaper (Presupuesto de publicidad en Periódico para el producto)

library(dplyr)
library(ggplot2)

adv <- read.csv("./Data/advertising.csv", header = T)

summary(adv)
head(adv, n = 10)

round(cor(adv),4)
#           TV     Radio     Newspaper  Sales
# TV        1.0000 0.0548    0.0566     0.9012
# Radio     0.0548 1.0000    0.3541     0.3496
# Newspaper 0.0566 0.3541    1.0000     0.1580
# Sales     0.9012 0.3496    0.1580     1.0000

pairs(~ Sales + TV + Radio + Newspaper, 
      data = adv, gap = 0.4, cex.labels = 1.5)

attach(adv)

m1 <- lm(Sales ~ TV + Radio + Newspaper)
summary(m1)
print('Se observa que la variable Newpaper no es significativa debido al valor obtenido en su P-value por lo que se procede a recalcular el modelo sin dicha variable')

m2 <- lm(Sales ~ TV + Radio)
summary(m2)

# Revisaremos los SUPUESTOS DEL MODELO DE REGRESIÓN LINEAL

StanRes2 <- rstandard(m2)

par(mfrow = c(2, 2))

# 1) Eltérmino de error no tiene correlación significativa con las variables explicativas.

plot(TV, StanRes2, ylab = "Residuales Estandarizados")
plot(Radio, StanRes2, ylab = "Residuales Estandarizados")

# 2) El término de error sigue una distribución normal"
qqnorm(StanRes2)
qqline(StanRes2)

dev.off()

shapiro.test(StanRes2)
# Ho: La variable distribuye como una normal
# Ha: La variable no distribuye como una normal

# Ya que el P-Value es menor a 0.01 rechazamos la Ho y procedemos a buscar otro modelo para ajustar la regresión lineal

# Consideraremos el término de intereacción TV:Radio
mfull <- lm(Sales ~ TV + Radio + TV:Radio)
summary(mfull)

# Validamos los supuestos del modelo de regresión lineal
StanResFull <- rstandard(mfull)

par(mfrow = c(1, 3))

# 1) Eltérmino de error no tiene correlación significativa con las variables explicativas.
plot(TV, StanResFull, ylab = "Residuales Estandarizados")
plot(Radio, StanResFull, ylab = "Residuales Estandarizados")


# 2) El término de error sigue una distribución normal"
qqnorm(StanResFull)
qqline(StanResFull)

dev.off()

shapiro.test(StanResFull)
# Ho: La variable distribuye como una normal
# Ha: La variable no distribuye como una normal

# Ya que el P-Value es mayor a 0.01 aceptamos la Ho por lo que  ya tenemos un modelo para usar en las predicciones

# Una vez validados estos supuestos, podemos realizar utilizar nuestro modelo estimado para realizar predicciones y obtener su intervalo de confianza
# Se prueban varias predicciones para ver qué tipo de combinaciones convienen más
data <- data.frame(
  TV = c(10, 50, 100, 200, 300),
  Radio = c(20, 20, 20, 20, 20)
)

predict(mfull, newdata = data, interval = "confidence", level = 0.99)

data <- data.frame(
  TV = c(20, 20, 20, 20, 20),
  Radio = c(10, 50, 100, 200, 300)
)

predict(mfull, newdata = data, interval = "confidence", level = 0.99)

data <- data.frame(
  TV = c(10, 50, 100, 200, 300),
  Radio = c(10, 50, 100, 200, 300)
)

predict(mfull, newdata = data, interval = "confidence", level = 0.99)

data <- data.frame(
  TV = c(10, 50, 100, 200, 300),
  Radio = c(5, 25, 50, 100, 200)
)

predict(mfull, newdata = data, interval = "confidence", level = 0.99)
