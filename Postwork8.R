
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

dim(df)
dim(df.complete.cases)

plot(df.complete.cases$nse5f)
plot(df.complete.cases$area)

hist(df.complete.cases$numpeho)
mean(df.complete.cases$numpeho)
Mode(df.complete.cases$numpeho)[1]
median(df.complete.cases$numpeho)

plot(df.complete.cases$refin)

hist(df.complete.cases$edadjef)
mean(df.complete.cases$edadjef)
median(df.complete.cases$edadjef)
Mode(df.complete.cases$edadjef)[1]

plot(df.complete.cases$sexojef)

hist(df.complete.cases$añosedu)
mean(df.complete.cases$añosedu)
median(df.complete.cases$añosedu)
Mode(df.complete.cases$añosedu)[1]

hist(df.complete.cases$ln_als)
hist(df.complete.cases$ln_alns)
plot(df.complete.cases$IA)

# 3) Calcula probabilidades que nos permitan entender el problema en México
# 4) Plantea hipótesis estadísticas y concluye sobre ellas para entender el problema en México
# 5) Estima un modelo de regresión, lineal o logístico, para identificiar los determinanres de la inseguridad alimentaria en México
attach(df.complete.cases)
round(cor(df.complete.cases),4)

pairs(~ IA + nse5f + area + numpeho + refin + edadjef + sexojef + añosedu + ln_als + ln_alns, 
      data = df.complete.cases, gap = 0.4, cex.labels = 1.5)
# 6) Escribe tu análisis en un archivo README.MD y tu código en un script de R y publica ambos en un repositorio de Github.

# NOTA: Todo tu planteamiento deberá estár correctamente desarrollado y deberás analizar e interpretar todos tus resultados para poder dar una conclusión final al problema planteado.
