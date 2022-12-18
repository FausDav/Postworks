
# Postwork sesión 8. Análisis de la Inseguridad Alimentaria en México

#### OBJETIVO

# - Realizar un análisis estadístico completo de un caso 
# - Publicar en un repositorio de Github el análisis y el código empleado 

#### REQUISITOS

# - Haber realizado los works y postworks previos 
# - Tener una cuenta en Github o en RStudioCloud
library(dplyr)
library(ggplot2)
library(DescTools)
library(moments)
#### DESARROLLO

# Un centro de salud nutricional está interesado en analizar estadísticamente y probabilísticamente los patrones de gasto en alimentos saludables y no saludables en los hogares mexicanos con base en su nivel socioeconómico, en si el hogar tiene recursos financieros extrar al ingreso y en si presenta o no inseguridad alimentaria. Además, está interesado en un modelo que le permita identificar los determinantes socioeconómicos de la inseguridad alimentaria.

# La base de datos es un extracto de la Encuesta Nacional de Salud y Nutrición (2012) levantada por el Instituto Nacional de Salud Pública en México. La mayoría de las personas afirman que los hogares con menor nivel socioeconómico tienden a gastar más en productos no saludables que las personas con mayores niveles socioeconómicos y que esto, entre otros determinantes, lleva a que un hogar presente cierta inseguridad alimentaria.

# La base de datos contiene las siguientes variables:
# - nse5f (Nivel socieconómico del hogar): 1 "Bajo", 2 "Medio bajo", 3 "Medio", 4 "Medio alto", 5 "Alto"
# - area (Zona geográfica): 0 "Zona urbana", 1 "Zona rural"
# - numpeho (Número de persona en el hogar)
# - refin (Recursos financieros distintos al ingreso laboral): 0 "no", 1 "sí"
# - edadjef (Edad del jefe/a de familia)
# - sexoje (Sexo del jefe/a de familia): 0 "Hombre", 1 "Mujer"
# - añosedu (Años de educación del jefe de familia)
# - ln_als (Logarítmo natural del gasto en alimentos saludables)
# - ln_alns (Logarítmo natural del gasto en alimentos no saludables)
# - IA (Inseguridad alimentaria en el hogar): 0 "No presenta IA", 1 "Presenta IA"

df <- read.csv("./Data/inseguridad_alimentaria_bedu.csv")


# 1) Plantea el problema del caso
"Inserte plateamiento aquí"

# 2) Realiza un análisis descriptivo de la información
str(df)
"En primera instancia se observa que los datos contienen varios campos categóricos, por lo que se empieza convirtiendo las variables 'area', 'refin','sexojef' e 'IA' en variables cualitativas y a la variable 'nse5f' en variable cualitativa ordinal."

df <- df %>% mutate(nse5f = factor(nse5f, levels = c(1,2,3,4,5),labels = c("Bajo","Medio bajo","Medio","Medio alto","Alto"),ordered = T),
                    area = factor(area,labels = c('Zona urbana','Zona rural')),
                    refin = factor(refin, labels = c('no','si')),
                    sexojef = factor(sexojef, labels = c('Hombre','Mujer')),
                    IA = factor(IA, labels = c('No presenta IA','Presenta IA')))
str(df)

df.complete.cases <- na.omit(df)
df.clean <- na.omit(df)
attach(df.complete.cases)

dim(df)
dim(df.complete.cases)

par(mfrow=c(2,3))

plot(df.complete.cases$nse5f) # <-

plot(df.complete.cases$refin) # <-

hist(df.complete.cases$ln_als) # <-
mean(df.complete.cases$ln_als)
median(df.complete.cases$ln_als)
Mode(df.complete.cases$ln_als)[1]
sd(df.complete.cases$ln_als)
Quantile(df.complete.cases$ln_als, probs = seq(0,1,0.25))

hist(df.complete.cases$ln_alns) # <-
mean(df.complete.cases$ln_alns)
median(df.complete.cases$ln_alns)
Mode(df.complete.cases$ln_alns)[1]
sd(df.complete.cases$ln_alns)
Quantile(df.complete.cases$ln_alns, probs = seq(0,1,0.25))

plot(df.complete.cases$IA) # <-

skewness(ln_als) #Sesgo a la izquierda
kurtosis(ln_als) #Leptocúrtica
skewness(ln_alns) #Sesgo a la derecha
kurtosis(ln_alns) #Platocúrtica


g <- ggplot(data = df.complete.cases, aes(x = nse5f, y = ln_als, col = IA)) +
  geom_boxplot() +
  labs(title = 'Boxplot por Gasto/IA', x = 'Nivel Socieconómico', y = '') +
  theme_minimal()
g

g <- ggplot(data = df.complete.cases, aes(x = nse5f, y = ln_alns, col = IA)) +
  geom_boxplot() +
  labs(title = 'Boxplot por Gasto/IA', x = 'Nivel Socieconómico', y = '') +
  theme_minimal()
g

# 3) Calcula probabilidades que nos permitan entender el problema en México
"Probabilidad de Presentar IA"
probabilidad.IA=sum(df.clean$IA)/count(df.clean)
probabilidad.IA

"Probabilidad de Tener Recursos financieros distintos al ingreso laboral"
probabilidad.refin=sum(df.clean$refin)/count(df.clean)
probabilidad.refin

"Probabilidades de presenta IA según el nivel socieconómico"
probabilidad.IA.dado.nivelbajo=sum(df.clean$IA[df.clean$nse5f==1] )/count(df.clean)
probabilidad.IA.dado.nivelbajo

probabilidad.IA.dado.nivelmediobajo=sum(df.clean$IA[df.clean$nse5f==2] )/count(df.clean)
probabilidad.IA.dado.nivelmediobajo

probabilidad.IA.dado.nivelmedio=sum(df.clean$IA[df.clean$nse5f==3] )/count(df.clean)
probabilidad.IA.dado.nivelmedio

probabilidad.IA.dado.nivelmedioalto=sum(df.clean$IA[df.clean$nse5f==4] )/count(df.clean)
probabilidad.IA.dado.nivelmedioalto

probabilidad.IA.dado.nivelalto=sum(df.clean$IA[df.clean$nse5f==5] )/count(df.clean)
probabilidad.IA.dado.nivelalto

"Probabilidades de presenta IA según el nivel socieconómico"
probabilidad.IA.dado.nivelbajo=sum(df.clean$IA[df.clean$nse5f==1] )/count(df.clean[df.clean$nse5f==1,])
probabilidad.IA.dado.nivelbajo

probabilidad.IA.dado.nivelmediobajo=sum(df.clean$IA[df.clean$nse5f==2] )/count(df.clean[df.clean$nse5f==2,])
probabilidad.IA.dado.nivelmediobajo

probabilidad.IA.dado.nivelmedio=sum(df.clean$IA[df.clean$nse5f==3] )/count(df.clean[df.clean$nse5f==3,])
probabilidad.IA.dado.nivelmedio

probabilidad.IA.dado.nivelmedioalto=sum(df.clean$IA[df.clean$nse5f==4] )/count(df.clean[df.clean$nse5f==4,])
probabilidad.IA.dado.nivelmedioalto

probabilidad.IA.dado.nivelalto=sum(df.clean$IA[df.clean$nse5f==5] )/count(df.clean[df.clean$nse5f==5,])
probabilidad.IA.dado.nivelalto
# 4) Plantea hipótesis estadísticas y concluye sobre ellas para entender el problema en México

#########################################################
"Plantea hipótesis estadísticas y concluye sobre ellas para entender el problema en México"
" La mayoría de las personas afirman que los hogares con menor nivel socioeconómico tienden 
a gastar más en productos no saludables que las personas con mayores niveles socioeconómicos 
y que esto, entre otros determinantes, lleva a que un hogar presente cierta inseguridad alimentaria."

"Ho: promedio de gasto de productos no saludable del nivel socio economico bajo y medio bajo <= promedio de gasto no saludable del nivel medio, medio alto y alto
Ha: promedio de gasto de productos no saludable del nivel socio economico bajo y medio bajo > promedio de gasto no saludable del nivel medio, medio alto y alto"

"Primero hay que checar las varianzas de los grupos de nivel socio economico bajo(bajo y medio bajo) y alto(medio, medio alto y alto) si son iguales o diferentes
Ho: varianzas"
var.test(df.clean$ln_alns[df.clean$nse5f=="Bajo" | df.clean$nse5f == "Medio bajo"], 
         df.clean$ln_alns[df.clean$nse5f=="Medio" | df.clean$nse5f == "Medio alto" | df.clean$nse5f == "Alto"], 
         ratio = 1, alternative = "two.sided")
"Con un p-value=2.2e-16 < 0.05, se concluye que se rechaz Ho. Entonces, las varianzas son diferentes."

t.test(x = df.clean$ln_alns[df.clean$nse5f=="Bajo" | df.clean$nse5f == "Medio bajo"], y = df.clean$ln_alns[df.clean$nse5f=="Medio" | df.clean$nse5f == "Medio alto" | df.clean$nse5f == "Alto"],
       alternative = "greater",
       mu = 0, var.equal = FALSE)
"Con un p-value = 1 > 0.05, no hay evidencia estadistica para rechazas Ho. Entonces, el gasto promedio de productos no saludables del nivel socioeconomico bajo(bajo y medio bajo) es menor o igual que los del nivel socioeconomico alto(medio, medio alto, y alto)."

#Hipotesis 2
"
Ho: Inseguridad alimentaria nivel socioeconomico bajo <= Inseguridad alimentaria nivel socioeconomico alto
Ha: Inseguridad alimentaria nivel socioeconomico bajo > Inseguridad alimentaria nivel socioeconomico alto
"

var.test(df.clean$IA[df.clean$nse5f==1 | df.clean$nse5f == 2], 
         df.clean$IA[df.clean$nse5f== 3| df.clean$nse5f == 4 | df.clean$nse5f == 5], 
         ratio = 1, alternative = "two.sided")
"Con un p-value=2.2e-16 < 0.05, se concluye que se rechaz Ho. Entonces, las varianzas son diferentes."

t.test(x = df.clean$IA[df.clean$nse5f==1 | df.clean$nse5f == 2], y = df.clean$IA[df.clean$nse5f== 3| df.clean$nse5f == 4 | df.clean$nse5f == 5],
       alternative = "greater",
       mu = 0, var.equal = FALSE)

# var.test(df.clean$IA[df.clean$nse5f=="Bajo" | df.clean$nse5f == "Medio bajo"], 
#          df.clean$IA[df.clean$nse5f== "Medio"| df.clean$nse5f == "Medio alto" | df.clean$nse5f == "Alto"], 
#          ratio = 1, alternative = "two.sided")
# "Con un p-value=2.2e-16 < 0.05, se concluye que se rechaz Ho. Entonces, las varianzas son diferentes."
# 
# t.test(x = df.clean$IA[df.clean$nse5f=="Bajo" | df.clean$nse5f == "Medio bajo"], y = df.clean$IA[df.clean$nse5f=="Medio" | df.clean$nse5f == "Medio alto" | df.clean$nse5f == "Alto"],
#        alternative = "greater",
#        mu = 0, var.equal = FALSE)

"Con un p-value=2.2e-16 < 0.05, se rechaza Ho. Entonces la inseguridad alimentaria en el nivel socioeconomico bajo es mayor que el nivel socioeconomico alto"

"En conclusion, se concluye que el nivel socioeconomico bajo si tiene un promedio mayor de inseguridad alimentaria que el nivel alto"



# 5) Estima un modelo de regresión, lineal o logístico, para identificiar los determinanres de la inseguridad alimentaria en México
logistic.1 <- glm(IA ~ ln_als + ln_alns + nse5f + refin, 
                  data = df.clean, family = binomial)
summary(logistic.1)

logistic.2 <- glm(IA ~ ln_alns + nse5f + refin, 
                  data = df.clean, family = binomial)
summary(logistic.2)

pseudo_r2.1 <- (logistic.1$null.deviance - logistic.1$deviance)/logistic.1$null.deviance
pseudo_r2.1
#la variable del gasto de productos saludables no es relevante para el modelo logistico.
logistic.2 <- glm(IA ~ ln_alns + nse5f + refin, 
                  data = df.clean, family = binomial)
summary(logistic.2)
pseudo_r2.2 <- (logistic.2$null.deviance - logistic.2$deviance)/logistic.2$null.deviance
pseudo_r2.2

logistic.3 <- glm(IA ~ ln_alns + nse5f + refin + area + numpeho + edadjef + sexojef + añosedu , 
                  data = df.clean, family = binomial)
summary(logistic.3)
pseudo_r2.3 <- (logistic.3$null.deviance - logistic.2$deviance)/logistic.2$null.deviance
pseudo_r2.3

logistic.4 <- glm(IA ~ ln_alns + nse5f + refin  + numpeho + sexojef + añosedu , 
                  data = df.clean, family = binomial)
summary(logistic.4)
pseudo_r2.4 <- (logistic.4$null.deviance - logistic.2$deviance)/logistic.2$null.deviance
pseudo_r2.4
#El logistic.4 tiene todas las variables significativas para el modelo (ln_alns, nse5f, refin, numpeho, sexojef y añosedu)

"Ya que el valor del pseudo r2 para el modelo logístico logistic.2 es el mayor de todos, será dicho modelo con el que quedan definidos los determinantes de la inseguridad alimenticia, siendo estos: Gasto en comida no saludablo, Nivel socieconómico y si la familia cuenta con un ingreso distinto al laboral o no."

# 6) Escribe tu análisis en un archivo README.MD y tu código en un script de R y publica ambos en un repositorio de Github.

# NOTA: Todo tu planteamiento deberá estár correctamente desarrollado y deberás analizar e interpretar todos tus resultados para poder dar una conclusión final al problema planteado.

