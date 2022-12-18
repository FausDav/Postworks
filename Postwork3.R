# Postwork Sesión 3

#### Objetivo

# - Realizar un análisis descriptivo de las variables de un dataframe

#### Requisitos

# 1. R, RStudio
# 2. Haber realizado el prework y seguir el curso de los ejemplos de la sesión
# 3. Curiosidad por investigar nuevos tópicos y funciones de R
library(dplyr)
library(DescTools)
library(ggplot2)
#### Desarrollo

# Utilizando el dataframe `boxp.csv` realiza el siguiente análisis descriptivo. No olvides excluir los missing values y transformar las variables a su tipo y escala correspondiente.
boxp <- read.csv('./Data/boxp.csv', header = TRUE)
head(boxp)
summary(boxp)

boxp <- boxp[complete.cases(boxp),]
boxp <- boxp %>% mutate(Categoria = factor(Categoria), Grupo = factor(Grupo))
summary(boxp)

# 1) Calcula e interpreta las medidas de tendencia central de la variable `Mediciones`
Mode(boxp$Mediciones)[1]  # 23.3
median(boxp$Mediciones)   # 49.3
mean(boxp$Mediciones)     # 62.88494
print('Con base en las medidas de tendencia central se puede interpretar que no se tiene una distribución simétrica y que la mayor parte de los datos se encuentra a la izquierda de los valores.')

# 2) Con base en tu resultado anteior, ¿qué se puede concluir respecto al sesgo de `Mediciones`?
print('La variable Mediciones está sesgada a la derecha ya que tenemos moda < media < promedio')

# 3) Calcula e interpreta la desviación estándar y los cuartiles de la distribución de `Mediciones`
sd(boxp$Mediciones) # 53.76972
# La dispersión promedio alrededor de la media es de 53.76972 para la variable Mediciones

Quantile(boxp$Mediciones, probs = seq(0,1,0.25))
# 0%    25%    50%    75%   100% 
# 2.80  23.45  49.30  82.85 290.60
cat('El 25% de las Mediciones es menor o igual a 23.45\nEl 50 % de las Mediciones es menor o igual a 49.30\nEl 75% de las Mediciones es menor o igual a 82.85')

# 4) Con ggplot, realiza un histograma separando la distribución de `Mediciones` por `Categoría` ¿Consideras que sólo una categoría está generando el sesgo?
g <- ggplot(data = boxp, aes(x = Mediciones, fill = Categoria)) +
  geom_histogram(bins = 10, alpha = 0.6) +
  labs(title = 'Histograma por Categoría', x = 'Mediciones', y = 'Conteo') +
  theme_minimal()
g
print('Se observa que las 3 categorías están causando el sesgo en los datos.')

# 5) Con ggplot, realiza un boxplot separando la distribución de `Mediciones` por `Categoría` y por `Grupo` dentro de cada categoría. ¿Consideras que hay diferencias entre categorías? ¿Los grupos al interior de cada categoría podrían estar generando el sesgo?

g <- ggplot(data = boxp, aes(x = Categoria, y = Mediciones, col = Grupo)) +
  geom_boxplot() +
  labs(title = 'Boxplot por Categoría/Grupos', x = 'Categorías', y = 'Mediciones') +
  theme_minimal()
g
cat('Entre categorías se observa que hay variación en la distribución de los cuartiles, sin embargo las 3 se encuentran sesgadas a la derecha.\nEn cuanto a los grupos, otro tanto de lo mismo, el grupo 0 tiene valores más altos en las categorías C2 y C3, pero no lo suficientes para evitar el sesgo a la derecha.')
