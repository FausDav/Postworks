# Postwork Sesión 1.

#### Objetivo

# El Postwork tiene como objetivo que practiques los comandos básicos aprendidos durante la sesión, de tal modo que sirvan para reafirmar el conocimiento. Recuerda que la programación es como un deporte en el que se debe practicar, habrá caídas, pero lo importante es levantarse y seguir adelante. Éxito

#### Requisitos
# - Concluir los retos
# - Haber estudiado los ejemplos durante la sesión

#### Desarrollo

# El siguiente postwork, te servirá para ir desarrollando habilidades como si se tratara de un proyecto que evidencie el progreso del aprendizaje durante el módulo, sesión a sesión se irá desarrollando.

# A continuación aparecen una serie de objetivos que deberás cumplir, es un ejemplo real de aplicación y tiene que ver con datos referentes a equipos de la liga española de fútbol (recuerda que los datos provienen siempre de diversas naturalezas), en este caso se cuenta con muchos datos que se pueden aprovechar, explotarlos y generar análisis interesantes que se pueden aplicar a otras áreas. Siendo así damos paso a las instrucciones: 
  
# 1. Del siguiente enlace, descarga los datos de soccer de la temporada 2019/2020 de la primera división de la liga española: https://www.football-data.co.uk/spainm.php

# 2. Importa los datos a R como un Dataframe

df <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv", header = TRUE)


# 3. Del dataframe que resulta de importar los datos a `R`, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG); guárdalos en vectores separados

FTHG <- df[,'FTHG']
FTAG <- df[,'FTAG']

# 4. Consulta cómo funciona la función `table` en `R`. Para ello, puedes ingresar los comandos `help("table")` o `?table` para leer la documentación.
?table
goals.count <- table(FTHG, FTAG)

goals.count

#     FTAG
# FTHG     0 1  2  3  4  5
#       0 33 28 15  8  2  2
#       1 43 49 32  5  3  0
#       2 39 35 20  3  2  0
#       3 14 14  7  2  1  0
#       4  4  5  4  0  1  0
#       5  2  3  3  0  0  0
#       6  1  0  0  0  0  0

# 5. Responde a las siguientes preguntas:
#   a) ¿Cuántos goles tuvo el partido con mayor empate?
print("8, 4 de cada equipo")
#   b) ¿En cuántos partidos ambos equipos empataron 0 a 0?
print("33 partidos")
#   c) ¿En cuántos partidos el equipo local (HG) tuvo la mayor goleada sin dejar que el equipo visitante (AG) metiera un solo gol?
print("1, con marcador 6-0")  

#   __Notas para los datos de soccer:__ https://www.football-data.co.uk/notes.txt

