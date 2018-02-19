suppressMessages(library(tidyverse))
df = data_frame(`Company A` = c(800, 200, 100, 50, 140, 200, 140),
                `Company B` = c(100, 2000, 300, 400, 50, 0, 290),
                `Company C` = c(200, 500, 4000, 80, 120, 320, 600),
                `Company D` = c(500, 200, 300, 5000, 250, 140, 450),
                `Company E` = c(600, 300, 150, 600, 6000, 30, 0),
                `Company F` = c(500, 400, 100, 300, 250, 4500, 140),
                `Company G` = c(300, 50, 0, 150, 600, 250, 7000))
df = as.matrix(df)
row.names(df) = c(colnames(df))
df

chorddiag(df, type = "directional", showTicks = F, groupnameFontsize = 14, groupnamePadding = 10, margin = 90)

