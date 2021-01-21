# Postwork Sesion 1
# Introducción a R y Software

# Descripción de los datos: https://www.football-data.co.uk/notes.txt

df <- read.csv('https://www.football-data.co.uk/mmz4281/1920/SP1.csv')

FTHG <- df$FTHG
FTAG <- df$FTAG

rows <- dim(df)[1]

FTHG_MarginalProbability <- table(FTHG) / rows
FTAG_MarginalProbability <- table(FTAG) / rows
JointProbability <- table(FTHG, FTAG) / rows
