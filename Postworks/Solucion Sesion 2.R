# Postwork Sesion 2
# Programación y manipulación de datos en R

URLs <- c('https://www.football-data.co.uk/mmz4281/1718/D1.csv',
          'https://www.football-data.co.uk/mmz4281/1819/D1.csv',
          'https://www.football-data.co.uk/mmz4281/1920/D1.csv')

names <- c('2017.csv', '2018.csv', '2019.csv')

for(i in 1:3) {
  download.file(url = URLs[i], destfile = names[i], mode = "wb")
}

dir()

list <- lapply(dir()[1:3], read.csv)

str(list[[1]])
head(list[[1]])
View(list[[1]])
summary(list[[1]])
dim(list[[1]])

list <- lapply(list, select, Date, HomeTeam:FTR)

list <- lapply(list, mutate, Date=as.Date(Date, format='%d/%m/%y'))

data <- do.call(rbind, list)

head(data)
tail(data)
