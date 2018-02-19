library(chorddiag)

students = data.frame(Dhorpatan = c(0, 1, 1, 1, 1),
                      Bardia = c(1, 0, 1, 1, 1),
                      Chitwan = c(1, 1, 0, 1, 1),
                      Suklaphata = c(1, 1, 1, 0, 1),
                      Khaptad = c(1, 1, 1, 1, 0))

students = as.matrix(students)
row.names(students) = c("Dhorpatan", "Bardia", "Chitwan", "Suklaphata", "Khaptad")

chorddiag(students, type = "bipartite", showTicks = F, groupnameFontsize = 14, groupnamePadding = 10, margin = 90)

