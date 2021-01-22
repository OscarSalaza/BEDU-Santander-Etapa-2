
#Ejercicio postwork de la sesión 05


#Se define directorio de trabajo en donde están los csv con la información de las tres temporadas

setwd("C:\\Users\\Oscar Salazar\\OneDrive\\Documents\\Data Analyst\\2_R y Py\\Postwork\\postwork2")

#Se leen todos los documentos dentro del directorio
SmallData <- lapply(dir(), read.csv)

library("dplyr")

#Filtrado de columnas con la función select de dplyr
SmallData <- lapply(SmallData, select, Date, HomeTeam:FTAG)

#Formación de un solo data frame
SmallData <- do.call(rbind, SmallData)

View(SmallData)

str(SmallData)

#Formato de fecha para la columna "date"
SmallData <- mutate(SmallData, Date = as.Date(Date, format="%d/%m/%y"))

#Se renombran las columnas para utilizar el paquete fbranks
SmallData <- rename(SmallData, date=Date, home.team=HomeTeam,
                    away.team=AwayTeam, home.score=FTHG, away.score=FTAG)

#Creación del csv "soccer" para utilizarlo en fbranks
write.csv(SmallData, "soccer.csv", row.names = FALSE)

library("fbRanks")

#Se desarrolla una lista con distintos dataframes con la función create.fb...
listasoccer <- create.fbRanks.dataframes("soccer.csv")

#Asignación de dataframes a variables anotaciones y equipos
anotaciones <- listasoccer$scores
equipos <- listasoccer$teams

#Lista de fechas (sin repetidos)
fecha <- unique(SmallData$date)

n <- length(fecha)

#se ordenan las fechas en orden cronológico
fecha <- sort(fecha)

#obtención de fecha inicial y penúltima fecha
f.inicial <- fecha[1] 
f.penultima <- fecha[length(fecha)-1]

#Utilización de función "rank.teams" para calificar a cada equipo
#se definieron fecha inicial y final
ranking <- rank.teams(anotaciones, equipos,
                      max.date = f.penultima,
                      min.date = f.inicial)

#se obtienen los índices de las filas que contienen la última fecha
partidos.uf <- which(anotaciones$date == fecha[length(fecha)])

#Extracción de los partidos realizados en la última fecha
f.ultima <- anotaciones[partidos.uf[1]:partidos.uf[length(partidos.uf)],]

#Predicción de los resultados de los partidos de la última fecha
Predicción <- predict.fbRanks(ranking, newdata = f.ultima)

#Los resultados generales(gana, pierde, empata) se acertaron en 66%
#En cuanto a los resultados particulares (goles), se acercan las predicciones a los resultados reales.