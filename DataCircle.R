library(chorddiag)
students = data.frame(BSc.CSIT = c(50, 0, 0, 0),
                      BIT = c(0, 55, 55, 20),
                      BSc = c(45,12,29, 20),
                      BE = c(55,35,27,27))

students = as.matrix(students)
row.names(students) = c("TU", "KU", "PU1", "PU2")

chorddiag(students, type = "bipartite", showTicks = F, groupnameFontsize = 14, groupnamePadding = 10, margin = 90)

