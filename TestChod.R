library(chorddiag)

students = data.frame("/user/akkal/RProject/AkkalData.csv")
students

students = as.matrix(students)
row.names(students) = c("Dhorpatan", "Bardia", "Chitwan", "Suklaphata", "Khaptad")

chorddiag(students, type = "bipartite", showTicks = F, groupnameFontsize = 14, groupnamePadding = 10, margin = 90)

