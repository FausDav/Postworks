
# Postwork Sesión 5

### OBJETIVO

# - Realizar inferencia estadística para extraer información de la muestra que sea contrastable con la población

#### REQUISITOS

# - Haber desarrollado los postworks anteriores
# - Cubrir los temas del prework
# - Replicar los ejemplos de la sesión

#### DESARROLLO
summary(iris)
# El data frame iris contiene información recolectada por Anderson sobre 50 flores de 3 especies distintas (setosa, versicolor y virginca), incluyendo medidas en centímetros del largo y ancho del sépalo así como de los pétalos.
iris.setosa <- iris[iris$Species=='setosa',]
iris.versicolor <- iris[iris$Species=='versicolor',]
iris.virginica <- iris[iris$Species=='virginica',]

# Utilizando pruebas de inferencia estadística, concluye si existe evidencia suficiente para concluir que los datos recolectados por Anderson están en línea con los nuevos estudios. 

# Utiliza 99% de confianza para toda las pruebas, en cada caso realiza el planteamiento de hipótesis adecuado y concluye.

# Estudios recientes sobre las mismas especies muestran que:
# - 1) En promedio, el largo del sépalo de la especie setosa (Sepal.Length) es igual a 5.7cm
# Ho: Sepal.Length = 5.7cm
# Ha: Sepal.Length != 5.7cm
t.test(iris.setosa[,'Sepal.Length'], alternative = 'two.sided', mu = 5.7)

# - 2) En promedio, el ancho del pétalo de la especie virginica (Petal.Width) es menor a 2.1cm
# Ho: Petal.Width >= 2.1cm
# Ha: Petal.Width < 2.1cm
t.test(iris.virginica[,'Petal.Width'], alternative = 'less', mu = 2.1)

# - 3) En promedio, el largo del pétalo de la especie virgínica es 1.1cm más grande que el promedio del largo del pétalo de la especie versicolor.
# Ho: Petal.length(virgínica) <= Petal.length(versicolor) + 1.1
# Ha: Petal.length(virgínica) > Petal.length(versicolor) + 1.1
var.test(iris.virginica[,"Petal.Length"], 
         iris.versicolor[,"Petal.Length"], 
         ratio = 1, alternative = "two.sided")

t.test(iris.virginica[,"Petal.Length"],
       iris.versicolor[,"Petal.Length"],
       alternative = "greater", mu = 1.1, var.equal = TRUE)

# - 4) En promedio, no existe diferencia en el ancho del sépalo entre las 3 especies.
# Ho: Sepal.Width(versicolor) = Sepal.Width(virgínica) = Sepal.Width(setosa)
# Ha: Al menos el promedio de una es distinto
boxplot(Sepal.Width ~ Species, data = iris)
anova <- aov(Sepal.Width ~ Species,
             data = iris)
summary(anova)


boxplot(Petal.Length ~ Species, data = iris)
