
# Postwork sesión 8. Análisis de la Inseguridad Alimentaria en México

## OBJETIVO

- Realizar un análisis estadístico completo de un caso 
- Publicar en un repositorio de Github el análisis y el código empleado 

## DESARROLLO

1. Plantea el problema del caso

Un centro de salud nutricional está interesado en analizar estadísticamente y probabilísticamente los patrones de gasto en alimentos saludables y no saludables en los hogares mexicanos con base en su nivel socioeconómico, en si el hogar tiene recursos financieros extrar al ingreso y en si presenta o no inseguridad alimentaria. Además, está interesado en un modelo que le permita identificar los determinantes socioeconómicos de la inseguridad alimentaria.

La base de datos es un extracto de la Encuesta Nacional de Salud y Nutrición (2012) levantada por el Instituto Nacional de Salud Pública en México. La mayoría de las personas afirman que los hogares con menor nivel socioeconómico tienden a gastar más en productos no saludables que las personas con mayores niveles socioeconómicos y que esto, entre otros determinantes, lleva a que un hogar presente cierta inseguridad alimentaria.

En el presente trabajo la tarea será analizar las variables: gasto de alimento saludable, gasto de alimento no saludable, nivel socioeconómico, ingresos extras, e inseguridad alimentaria. Además, de identificar las variables relacionadas con la inseguridad alimentaria y crear un modelo predictivo de la IA.

2. Realiza un análisis descriptivo de la información

- Para el análisis descriptivo se revisa la estructura del dataframe obtenido al importar el archivo "inseguridad_alimentaria_bedu.csv".
- Se revisaron los tipos de variable de cada campo para identificar si son variables cuantitativas o cualitativas.
- Se procedió a realizar la limpieza de datos para trabajar únicamente con los registros que tenían toda su información disponible.
- Se graficaron las variables según su tipo en hsitogramas y gráficas de barras.
- Para las variables cuantitativas se calculó el promedio, la mediana, la moda, la desviación estándar y los cuartiles.
- Para las variables cuantitativas también se verificó su sesgo y su kurtosis
- Se realizaron gráficas de caja para ver el comportamiento del gasto en comida saludable y comida no saludable respecto a los niveles socieconómicos y a si presentan Inseguridad Alimentaria o no.

3. Calcula probabilidades que nos permitan entender el problema en México

Se realizó el cálculo de las siguientes probabilidades tomando en cuenta únicamente los datos de la muestra:

- Probabilidad de Presentar IA
- Probabilidad de Tener Recursos financieros distintos al ingreso laboral
- Probabilidades de presenta IA según el nivel socioeconómico respecto al total de la población
- Probabilidades de presenta IA según el nivel socioeconómico respecto al nivel socioeconómico

4. Plantea hipótesis estadísticas y concluye sobre ellas para entender el problema en México

La mayoría de las personas afirman que los hogares con menor nivel socioeconómico tienden a gastar más en productos no saludables que las personas con mayores niveles socioeconómicos y que esto, entre otros determinantes, lleva a que un hogar presente cierta inseguridad alimentaria.

### Hipótesis 1

- Ho: promedio de gasto de productos no saludable del nivel socio economico bajo y medio bajo <= promedio de gasto no saludable del nivel medio, medio alto y alto
- Ha: promedio de gasto de productos no saludable del nivel socio economico bajo y medio bajo > promedio de gasto no saludable del nivel medio, medio alto y alto

Primero hay que checar las varianzas de los grupos de nivel socio economico bajo(bajo y medio bajo) y alto(medio, medio alto y alto) si son iguales o diferentes
- Ho: Las varianzas son iguales
- Ha: las varianzas son diferentes

Con un p-value=2.2e-16 < 0.05, se concluye que se rechaz Ho. Entonces, las varianzas son diferentes.

Se comprueba con un t.test las hipótesis iniciales:
Con un p-value = 1 > 0.05, no hay evidencia estadística para rechazar Ho. Entonces, el gasto promedio de productos no saludables del nivel socioeconómico bajo(bajo y medio bajo) es menor o igual que los del nivel socioeconómico alto(medio, medio alto, y alto).

### Hipótesis 2

- Ho: Promedio de la inseguridad alimentaria del nivel socioeconómico bajo <= Promedio de la inseguridad alimentaria del nivel socioeconómico alto
- Ha: Promedio de la inseguridad alimentaria del nivel socioeconómico bajo > Promedio de la inseguridad alimentaria del nivel socioeconómico alto

Primero hay que checar las varianzas de los grupos de nivel socio economico bajo(bajo y medio bajo) y alto(medio, medio alto y alto) si son iguales o diferentes
- Ho: Las varianzas son iguales
- Ha: las varianzas son diferentes

Con un p-value=2.2e-16 < 0.05, se concluye que se rechaza Ho. Entonces, las varianzas son diferentes.

Se comprueba con un t.test las hipótesis iniciales:
Con un p-value=2.2e-16 < 0.05, se rechaza Ho. Entonces la inseguridad alimentaria en el nivel socioeconómico bajo es mayor que el nivel socioeconómico alto

En conclusión, se determina que el nivel socioeconómico bajo si tiene un promedio mayor de inseguridad alimentaria que el nivel alto

5. Estima un modelo de regresión, lineal o logístico, para identificiar los determinantes de la inseguridad alimentaria en México

Se calcula un primer modelo logístico para la Inseguridad Alimentaria tomando en cuenta las variables: Gasto en alimentos saludables, gasto en alimentos no saludables, nivel socioeconómico y recursos financieros distintos al ingreso laboral.

```
Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)  2.55446    0.15313  16.682  < 2e-16 ***
ln_als       0.03711    0.02648   1.402    0.161    
ln_alns     -0.12844    0.01652  -7.776 7.51e-15 ***
nse5f       -0.43142    0.01331 -32.425  < 2e-16 ***
refin        0.39759    0.04398   9.040  < 2e-16 ***
```

Del análisis de los p-values se determina que la variable de Gasto en alimentos saludables no es significativamente relevante para el modelo por lo que se procede a calcular un segundo modelo sin dicha variable:

```
Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)  2.74363    0.07281  37.679  < 2e-16 ***
ln_alns     -0.12272    0.01601  -7.666 1.78e-14 ***
nse5f       -0.42614    0.01275 -33.431  < 2e-16 ***
refin        0.40101    0.04391   9.133  < 2e-16 ***
```

Se calcula el pseudo r<sup>2</sup> para el modelo 2, obteniendo un valor de 0.07053231

Se calcula un 3er modelo logístico tomando en cuenta las variables: Gasto en alimentos no saludables + Nivel socioeconómico + Recursos financieros distintos al ingreso laboral + Área + Número de miembros + Edad Jefe + Sexo Jefe + Años de educación del jefe. del cual se obtiene un pseudo r<sup>2</sup> de: 0.07045129

Finalmente se calcula un 4to modelo con las variables: Gasto en alimentos no saludables + Nivel socioeconómico + Recursos financieros distintos al ingreso laboral + Número de miembros + Edad Jefe + Sexo Jefe + Años de educación del jefe. del cual se obtiene un pseudo r<sup>2</sup> de: 0.07045129

Ya que el valor del pseudo r<sup>2</sup> para el segundo modelo logístico es el mayor de todos, será dicho modelo con el que quedan definidos los determinantes de la inseguridad alimenticia, siendo estos: Gasto en comida no saludablo, Nivel socieconómico y si la familia cuenta con un ingreso distinto al laboral o no.