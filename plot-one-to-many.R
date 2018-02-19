library(chorddiag)

students = data.frame(Math = c(1),
                      Art = c(1),
                      Science = c(1),
                      PE = c(1),
                      Math = c(1),
                      Art = c(1),
                      Science = c(1),
                      PE = c(1),
                      Math = c(1),
                      Art = c(1),
                      Science = c(1),
                      PE = c(1),
                      Math = c(1),
                      Art = c(1),
                      Science = c(1),
                      PE = c(1))

students = as.matrix(students)
row.names(students) = c("TU")

chorddiag(students, type = "bipartite", showTicks = F, groupnameFontsize = 14, groupnamePadding = 10, margin = 90)

