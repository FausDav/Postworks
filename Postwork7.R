
## Postwork 7. Predicciones de la temperatura global

### OBJETIVO

# - Estimar modelos ARIMA y realizar predicciones

#### DESARROLLO
# Utilizando el siguiente vector numérico, realiza lo que se indica:
url = "./Data/global.txt"
Global <- scan(url, sep="")

summary(Global)

# 1) Crea una objeto de serie de tiempo con los datos de Global. La serie debe ser mensual comenzado en Enero de 1856
ts.global = ts(Global, start = c(1856,1),end = c(2004,12), frequency = 12)
ts.global

# 2) Realiza una gráfica de la serie de tiempo anterior de 2005")
plot(ts.global, 
     main = "Temperatura Global", 
     xlab = "Tiempo",
     ylab = paste("\U0394","Temperatura"),
     sub = "Enero de 1856 - Diciembre de 2004")

# 3) Ahora realiza una gráfica de la serie de tiempo anterior, transformando a la primera diferencia:
plot(diff(ts.global), 
     main = "Temperatura Global", 
     xlab = "Tiempo",
     ylab = paste("\U0394","Temperatura"),
     sub = "Enero de 1856 - Diciembre de 2004")

# 4) ¿Consideras que la serie es estacionaria en niveles o en primera diferencia?
"Se vuelve estacionaria en la primera diferencia"

# 5) Con base en tu respuesta anterior, obten las funciones de autocorrelación y autocorrelación parcial?
par(mfrow=c(1,2))
acf(diff(ts.global))
pacf(diff(ts.global))

# 6) De acuerdo con lo observado en las gráficas anteriores, se sugiere un modelo ARIMA
# con AR(1), I(1) y MA desde 1 a 4 rezagos Estima los diferentes modelos ARIMA propuestos:"
arima(ts.global, order = c(1, 1, 1))
arima(ts.global, order = c(1, 1, 2))
arima(ts.global, order = c(1, 1, 3))
arima(ts.global, order = c(1, 1, 4))


# 7) Con base en el criterio de Akaike, estima el mejor modelo ARIMA y realiza una 
# predicción de 12 periodos (meses)"
"El modelo AR(1), I(1), MA(4) es el que tiene el menor valor aic, por lo que es el que será usado para la predicción"
fit <- arima(ts.global, order = c(1, 1, 4))
pr <- predict(fit, 12)$pred
pr
#       Jan       Feb       Mar       Apr       May       Jun
# 2005  0.4261515 0.4255704 0.4320013 0.4303828 0.4289712 0.4277401
#       Jul       Aug       Sep       Oct       Nov       Dec
# 2005  0.4266664 0.4257300 0.4249134 0.4242012 0.4235800 0.4230383
