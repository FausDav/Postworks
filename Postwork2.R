# Postwork Sesión 2.

#### Objetivo

# - Conocer algunas de las bases de datos disponibles en `R`
# - Observar algunas características y manipular los DataFrames con `dplyr`
# - Realizar visualizaciones con `ggplot`
#### Requisitos

# 1. Tener instalado R y RStudio
# 2. Haber realizado el prework y estudiado los ejemplos de la sesión.
library(dplyr)
library(ggplot2)
#### Desarrollo

# 1) Inspecciona el DataSet iris_meaniris` disponible directamente en R. Identifica las variables que contiene y su tipo, asegúrate de que no hayan datos faltantes y que los datos se encuentran listos para usarse.
str(iris)
summary(iris)
dim(iris)
View(iris)
head(iris)
names(iris)

sum(complete.cases(iris))

# 2) Crea una gráfica de puntos que contenga `Sepal.Lenght` en el eje horizontal, `Sepal.Width` en el eje vertical, que identifique `Species` por color y que el tamaño de la figura está representado por `Petal.Width`. Asegúrate de que la geometría contenga `shape = 10` y `alpha = 0.5`.
g <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species, size = Petal.Width)) +
  geom_point(shape = 10, alpha = 0.5) +
  theme_minimal()
g
  

# 3) Crea una tabla llamada `iris_mean` que contenga el promedio de todas las variables agrupadas por `Species`.
iris_mean <- group_by(iris, Species) %>%
  summarise(mean(Sepal.Length),mean(Sepal.Width),mean(Petal.Length),mean(Petal.Width))
iris_mean <- setNames(iris_mean, c('Species','Sepal.Length','Sepal.Width','Petal.Length','Petal.Width'))

# 4) Con esta tabla, agrega a tu gráfica anterior otra geometría de puntos para agregar los promedios en la visualización. Asegúrate que el primer argumento de la geometría sea el nombre de tu tabla y que los parámetros sean `shape = 23`, `size = 4`, `fill = "black"` y `stroke = 2`. También agrega etiquetas, temas y los cambios necesarios para mejorar tu visualización.
g <- g + geom_point(data = iris_mean, shape = 23, size = 4, fill = 'black', stroke = 2) + labs(title = 'Iris Data')
g
