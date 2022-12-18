
# Postwork sesión 8. Análisis de la Inseguridad Alimentaria en México

#### OBJETIVO

# - Realizar un análisis estadístico completo de un caso 
# - Publicar en un repositorio de Github el análisis y el código empleado 

#### REQUISITOS

# - Haber realizado los works y postworks previos 
# - Tener una cuenta en Github o en RStudioCloud
install.packages("dplyr")
install.packages("ggplot")
install.packages("DescTools")
install.packages("moments")

library(dplyr)
library(ggplot2)
library(DescTools)
library(moments)

#### DESARROLLO


# 1) Plantea el problema del caso

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

# 2) Realiza un análisis descriptivo de la información
df <- read.csv("./Data/inseguridad_alimentaria_bedu.csv")

str(df)

"En primera instancia se observa que los datos contienen varios campos categóricos, por lo que se empieza convirtiendo las variables 'area', 'refin','sexojef' e 'IA' en variables cualitativas y a la variable 'nse5f' en variable cualitativa ordinal."

df <- df %>% mutate(nse5f = factor(nse5f, levels = c(1,2,3,4,5),labels = c("Bajo","Medio bajo","Medio","Medio alto","Alto"),ordered = T),
                    area = factor(area,labels = c('Zona urbana','Zona rural')),
                    refin = factor(refin, labels = c('no','si')),
                    sexojef = factor(sexojef, labels = c('Hombre','Mujer')),
                    IA = factor(IA, labels = c('No presenta IA','Presenta IA')))
str(df)

df.clean <- na.omit(df)
attach(df.clean)

par(mfrow=c(2,3))

plot(nse5f, main = "Nivel socioeconómico") # <-

plot(refin, main = "Recursos financieros distintos al laboral") # <-

hist(ln_als, main = "Gasto en alimentos saludables") # <-
mean(ln_als)
median(ln_als)
Mode(ln_als)[1]
sd(ln_als)
Quantile(ln_als, probs = seq(0,1,0.25))
skewness(ln_als) #Sesgo a la izquierda
kurtosis(ln_als) #Leptocúrtica

hist(df.clean$ln_alns, main = "Gasto en alimentos no saludables") # <-
mean(df.clean$ln_alns)
median(df.clean$ln_alns)
Mode(df.clean$ln_alns)[1]
sd(df.clean$ln_alns)
Quantile(df.clean$ln_alns, probs = seq(0,1,0.25))
skewness(ln_alns) #Sesgo a la derecha
kurtosis(ln_alns) #Platocúrtica

plot(df.clean$IA, main = "Inseguridad alimentaria") # <-

dev.off()

g <- ggplot(data = df.clean, aes(x = nse5f, y = ln_als, col = IA)) +
  geom_boxplot() +
  labs(title = 'Boxplot por Gasto en alimentos saludables/IA', x = 'Nivel Socieconómico', y = 'Gasto(ln)') +
  theme_minimal()
g

g <- ggplot(data = df.clean, aes(x = nse5f, y = ln_alns, col = IA)) +
  geom_boxplot() +
  labs(title = 'Boxplot por Gasto en alimentos no saludables/IA', x = 'Nivel Socieconómico', y = 'Gasto(ln)') +
  theme_minimal()
g

# 3) Calcula probabilidades que nos permitan entender el problema en México
"Probabilidad de Presentar IA"
probabilidad.IA=nrow(df.clean[df.clean$IA == "Presenta IA",])/nrow(df.clean)
probabilidad.IA

"Probabilidad de Tener Recursos financieros distintos al ingreso laboral"
probabilidad.refin=nrow(df.clean[df.clean$refin == "si",])/nrow(df.clean)
probabilidad.refin

"Probabilidades de presenta IA según el nivel socieconómico contra el total de la muestra"
{
  probabilidad.IA.dado.nivelbajo=nrow(df.clean[df.clean$nse5f=="Bajo" & df.clean$IA == "Presenta IA",] )/nrow(df.clean);
  probabilidad.IA.dado.nivelmediobajo=nrow(df.clean[df.clean$nse5f=="Medio bajo" & df.clean$IA == "Presenta IA",] )/nrow(df.clean);
  probabilidad.IA.dado.nivelmedio=nrow(df.clean[df.clean$nse5f=="Medio" & df.clean$IA == "Presenta IA",] )/nrow(df.clean);
  probabilidad.IA.dado.nivelmedioalto=nrow(df.clean[df.clean$nse5f=="Medio alto" & df.clean$IA == "Presenta IA",] )/nrow(df.clean);
  probabilidad.IA.dado.nivelalto=nrow(df.clean[df.clean$nse5f=="Alto" & df.clean$IA == "Presenta IA",] )/nrow(df.clean);
}

"Probabilidades de presenta IA según el nivel socieconómico contra el total de la muestra"
probabilidad.IA.dado.nivelbajo;
probabilidad.IA.dado.nivelmediobajo;
probabilidad.IA.dado.nivelmedio;
probabilidad.IA.dado.nivelmedioalto;
probabilidad.IA.dado.nivelalto;

  
"Probabilidades de presenta IA según el nivel socieconómico contra el mismo NSE"
{
  probabilidad.IA.dado.nivelbajo=nrow(df.clean[df.clean$nse5f=="Bajo" & df.clean$IA == "Presenta IA",] )/nrow(df.clean[df.clean$nse5f=="Bajo",])
  probabilidad.IA.dado.nivelmediobajo=nrow(df.clean[df.clean$nse5f=="Medio bajo" & df.clean$IA == "Presenta IA",] )/nrow(df.clean[df.clean$nse5f=="Medio bajo",])
  probabilidad.IA.dado.nivelmedio=nrow(df.clean[df.clean$nse5f=="Medio" & df.clean$IA == "Presenta IA",] )/nrow(df.clean[df.clean$nse5f=="Medio",])
  probabilidad.IA.dado.nivelmedioalto=nrow(df.clean[df.clean$nse5f=="Medio alto" & df.clean$IA == "Presenta IA",] )/nrow(df.clean[df.clean$nse5f=="Medio alto",])
  probabilidad.IA.dado.nivelalto=nrow(df.clean[df.clean$nse5f=="Alto" & df.clean$IA == "Presenta IA",] )/nrow(df.clean[df.clean$nse5f=="Alto",])
}
"Probabilidades de presenta IA según el nivel socieconómico contra el mismo NSE"
probabilidad.IA.dado.nivelbajo
probabilidad.IA.dado.nivelmediobajo
probabilidad.IA.dado.nivelmedio
probabilidad.IA.dado.nivelmedioalto
probabilidad.IA.dado.nivelalto
  
# 4) Plantea hipótesis estadísticas y concluye sobre ellas para entender el problema en México

#########################################################
" La mayoría de las personas afirman que los hogares con menor nivel socioeconómico tienden 
a gastar más en productos no saludables que las personas con mayores niveles socioeconómicos 
y que esto, entre otros determinantes, lleva a que un hogar presente cierta inseguridad alimentaria."

"Ho: promedio de gasto de productos no saludable del nivel socio economico bajo y medio bajo <= promedio de gasto no saludable del nivel medio, medio alto y alto
Ha: promedio de gasto de productos no saludable del nivel socio economico bajo y medio bajo > promedio de gasto no saludable del nivel medio, medio alto y alto"

"Primero hay que checar las varianzas de los grupos de nivel socio economico bajo(bajo y medio bajo) y alto(medio, medio alto y alto) si son iguales o diferentes
Ho: varianzas son iguales
Ha: varianzas son diferentes"
df.clean
var.test(df.clean$ln_alns[df.clean$nse5f=="Bajo" | df.clean$nse5f == "Medio bajo" | df.clean$nse5f == "Medio"], 
         df.clean$ln_alns[df.clean$nse5f == "Medio alto" | df.clean$nse5f == "Alto"], 
         ratio = 1, alternative = "two.sided")
"Con un p-value=2.2e-16 < 0.05, se concluye que se rechaz Ho. Entonces, las varianzas son diferentes."

t.test(x = df.clean$ln_alns[df.clean$nse5f=="Bajo" | df.clean$nse5f == "Medio bajo" | df.clean$nse5f == "Medio"], y = df.clean$ln_alns[df.clean$nse5f == "Medio alto" | df.clean$nse5f == "Alto"],
       alternative = "greater",
       mu = 0, var.equal = FALSE)
"Con un p-value = 1 > 0.05, no hay evidencia estadistica para rechazas Ho. Entonces, el gasto promedio de productos no saludables del nivel socioeconomico bajo(bajo, medio bajo y medio) es menor o igual que los del nivel socioeconomico alto(medio alto, y alto)."

#Hipotesis 2
"
Ho: Inseguridad alimentaria nivel socioeconomico bajo <= Inseguridad alimentaria nivel socioeconomico alto
Ha: Inseguridad alimentaria nivel socioeconomico bajo > Inseguridad alimentaria nivel socioeconomico alto
"

#probabilidad.IA=length(df.clean$IA[df.clean$IA=="Presenta IA"])/count(df.clean)

{sampleBajo <- c()
  for (i in 1:30) {
    sample.test <- df[sample(1:dim(df)[1], size = 1000),c("IA","nse5f")]
    # sample40[i] <- nrow(sample.test[sample.test$nse5f=="Bajo",])/nrow(sample.test)
    sampleBajo[i] <- nrow(sample.test[sample.test$IA=="Presenta IA" & 
                                        (sample.test$nse5f=="Bajo" |
                                           sample.test$nse5f=="Medio bajo" |
                                           sample.test$nse5f=="Medio"),])/nrow(sample.test)
  }
  hist(sampleBajo, main = "Muestra Bajo", xlab = "")
}

{sampleAlto <- c()
  for (i in 1:30) {
    sample.test <- df[sample(1:dim(df)[1], size = 1000),c("IA","nse5f")]
    # sample40[i] <- nrow(sample.test[sample.test$nse5f=="Bajo",])/nrow(sample.test)
    sampleAlto[i] <- nrow(sample.test[sample.test$IA=="Presenta IA" & 
                                        (sample.test$nse5f=="Medio alto" |
                                        sample.test$nse5f=="Alto")
                                      ,])/nrow(sample.test)
  }
  hist(sampleAlto, main = "Muestra Alto", xlab = "")
}

var.test(sampleBajo,
         sampleAlto,
         ratio = 1, alternative = "two.sided")
"Con un p-value=0.3874 > 0.05, se concluye que no se rechaza Ho. Entonces, las varianzas son iguales."

t.test(x = sampleBajo, y = sampleAlto,
       alternative = "greater",
       mu = 0, var.equal = TRUE)

"Con un p-value=2.2e-16 < 0.05, se rechaza Ho. Entonces la inseguridad alimentaria en el nivel socioeconomico bajo es mayor que el nivel socioeconomico alto"

"En conclusion, se concluye que el nivel socioeconomico bajo si tiene un promedio mayor de inseguridad alimentaria que el nivel alto"



# 5) Estima un modelo de regresión, lineal o logístico, para identificiar los determinanres de la inseguridad alimentaria en México
logistic.1 <- glm(IA ~ ln_als + ln_alns + nse5f + refin, 
                  data = df.clean, family = binomial)
summary(logistic.1)

#la variable del gasto de productos saludables no es relevante para el modelo logistico.

logistic.2 <- glm(IA ~ ln_alns + nse5f + refin, 
                  data = df.clean, family = binomial)
summary(logistic.2)

# Probamos agregando el resto de variables
logistic.3 <- glm(IA ~ ln_alns + nse5f + refin + area + numpeho + edadjef + sexojef + añosedu , 
                  data = df.clean, family = binomial)
summary(logistic.3)

# Quitamos las variables Área y Edad del jefe de familia por ser menos significativas
logistic.4 <- glm(IA ~ ln_alns + nse5f + refin + area  + numpeho + sexojef + añosedu , 
                  data = df.clean, family = binomial)
summary(logistic.4)


pseudo_r2.1 <- (logistic.1$null.deviance - logistic.1$deviance)/logistic.1$null.deviance
pseudo_r2.2 <- (logistic.2$null.deviance - logistic.2$deviance)/logistic.2$null.deviance
pseudo_r2.3 <- (logistic.3$null.deviance - logistic.3$deviance)/logistic.3$null.deviance
pseudo_r2.4 <- (logistic.4$null.deviance - logistic.4$deviance)/logistic.4$null.deviance

"Se evelúan los valores pseudo R2"
pseudo_r2.1
pseudo_r2.2
pseudo_r2.3
pseudo_r2.4

"Se evaluán los Criterio de información de Akaike"
AIC(logistic.1)
AIC(logistic.2)
AIC(logistic.3)
AIC(logistic.4)

#El logistic.3 tiene todas las variables significativas para el modelo (ln_alns, nse5f, refin, numpeho, sexojef y añosedu)
# Sin embargo decidimos tomar el modelo logistic.4 ya que explica prácticamente con la misma precisión y tiene menos variables.

# 6) Escribe tu análisis en un archivo README.MD y tu código en un script de R y publica ambos en un repositorio de Github.

# NOTA: Todo tu planteamiento deberá estár correctamente desarrollado y deberás analizar e interpretar todos tus resultados para poder dar una conclusión final al problema planteado.

