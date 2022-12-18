# Postwork Sesión 4

#### Objetivo

# - Realizar un análisis probabilístico del total de cargos internacionales de una compañía de telecomunicaciones

#### Requisitos

# - R, RStudio
# - Haber trabajado con el prework y el work
library(dplyr)
library(DescTools)
# library(ggplot2)
#### Desarrollo

# Utilizando la variable `total_intl_charge` de la base de datos `telecom_service.csv` de la sesión 3, realiza un análisis probabilístico. Para ello, debes determinar la función de distribución de probabilidad que más se acerque el comportamiento de los datos.
# Hint: Puedes apoyarte de medidas descriptivas o técnicas de visualización.
df <- read.csv("./Data/telecom_service.csv", header = TRUE)
df <- df %>% select(total_intl_charge)

(mean = mean(df$total_intl_charge))
median(df$total_intl_charge)
Mode(df$total_intl_charge)[1]

hist(df$total_intl_charge, main = 'Histograma Total de Cargos Internacionales', xlab = 'Cargos', ylab = 'Ocurrencias')

print('Ya que los valores del promedio, la mediana y la moda se encuentran muy cercanos se ocupará una distribución normal, esto se apoya en la graficación del histograma en la cual se confirma que tenemos una distribución simétrica cercana a la distribución normal')

# Una vez que hayas seleccionado el modelo, realiza lo siguiente:
  
# 1) Grafica la distribución teórica de la variable aleatoria `total_intl_charge`
(sd = sd(df$total_intl_charge))
curve(dnorm(x, mean = mean, sd = sd), 
      from = -1, 
      to = 6,
      xlab = 'x',
      ylab = 'f(x)',
      main = 'Distribución teórica')

# 2) ¿Cuál es la probabilidad de que el total de cargos internacionales sea menor a 1.85 usd?
pnorm(1.85,mean = mean, sd = sd)

# 3) ¿Cuál es la probabilidad de que el total de cargos internacionales sea mayor a 3 usd?
pnorm(3,mean = mean, sd = sd, lower.tail = FALSE)
# 0.1125002

# 4) ¿Cuál es la probabilidad de que el total de cargos internacionales esté entre 2.35usd y 4.85 usd?
pnorm(4.85,mean = mean, sd = sd)-pnorm(2.35,mean = mean, sd = sd)
# 0.7060114

# 5) Con una probabilidad de 0.48, ¿cuál es el total de cargos internacionales más alto que podría esperar?
qnorm(0.48, mean = mean, sd = sd)
# 2.726777

# 6) ¿Cuáles son los valores del total de cargos internacionales que dejan exactamente al centro el 80% de probabilidad?
qnorm(0.1, mean = mean, sd = sd) # 1.798583
qnorm(0.9, mean = mean, sd = sd) # 3.73058

