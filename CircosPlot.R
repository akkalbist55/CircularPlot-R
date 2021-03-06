library(ggbio)
library(grid)
library(gridExtra)
library(plyr)
library(GenomicRanges)
library(qgraph)

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL)
{
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) 
  {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) 
  {
    print(plots[[1]])
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots)
    {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

makeGr <- function()
{
  data("hg19Ideogram", package = "biovizBase")
  chr.sub <- paste("chr", 1:22, sep = "")
  new.names <- as.character(1:22)
  names(new.names) <- paste("chr", new.names, sep = "")
  hg19Ideo <- hg19Ideogram
  hg19Ideo <- keepSeqlevels(hg19Ideogram, chr.sub)
  hg19Ideo <- renameSeqlevels(hg19Ideo, new.names)
  head(hg19Ideo)
  gr <- GRanges(
    seqnames = (1:22),
    ranges = hg19Ideo@ranges
  )
  seqlengths(gr) <- seqlengths(hg19Ideo)
  return(gr)
}


makeLinks <- function(x, gr)
{
  links1 <- GRanges(
    seqnames = x$chr1,
    IRanges(start = x$position1, width=1),
    seqinfo = seqinfo(gr)
  )
  links2 <- GRanges(
    seqnames = x$chr2,
    IRanges(start = x$position2, width=1),
    seqinfo = seqinfo(gr)
  )
  values(links1)$links2 <- links2
  values(links1)$col <- x$rep
  return(links1)
}


makeDot <- function(x, gr)
{
  ran <- c(1, seqlengths(gr)[x$probechr[1]])
  names(ran) <- NULL
  dot <- GRanges(
    seqnames = x$probechr[1],
    IRanges(start = round(mean(ran)), width=1)
  )
  dot <- c(gr, dot)
  dot <- dot[-c(1:22)]
  values(dot)$score <- 0
  values(dot)$gene <- x$probegene[1]
  return(dot)
}


plotCircos <- function(gr, links, dot)
{
  a <- ggplot() + 
    layout_circle(gr, geom = "ideo", radius = 7, trackWidth = 2, colour="white", fill="white") +
    layout_circle(gr, geom = "ideo", radius = 6, trackWidth = 1) +
    layout_circle(links, geom = "link", linked.to = "links2", radius = 3.5, trackwidth = 1, aes(colour=col)) +
    layout_circle(dot, geom = "point", radius = 4, trackwidth = 0, colour="red", size=2, aes(y = score)) +
    layout_circle(dot, geom = "text", radius = 7.2, trackWidth = 1, colour = "black", size=3, aes(label = gene)) +
    scale_colour_manual(values=c("light grey", "blue", "red"), drop = FALSE) +
    theme(legend.position="false")
  
  return(a)
}


linkColour <- function(sig)
{
  sig$rep <- 0
  sig$rep[sig$pnest_meta > sig$upper] <- 1
  sig$rep[sig$pnest_meta > -log10(0.05/nrow(sig))] <- 2
  sig$rep <- as.factor(sig$rep)
  return(sig)
}


multipleSnps <- function(sig)
{
  a <- subset(sig, select=c(snp1, snp2))
  b <- data.frame(t(apply(a, 1, sort)))
  names(b) <- c("snpa", "snpb")
  sig <- cbind(sig, b)
  sig$code2 <- with(sig, paste(snpa, snpb))
  tab <- table(sig$code2)
  nom <- names(tab)[tab>1]
  s <- subset(sig, code2 %in% nom)
  s <- s[order(s$code2), ]
}


#=================================================================================================#
#=================================================================================================#


# Load data 

load("~/repo/eQTL-2D/analysis/interaction_list_meta_analysis.RData")
sig <- subset(meta, filter != 3)
sig <- linkColour(sig)

# Circles 

gr <- makeGr()
index <- table(sig$probename)
sig_mult <- subset(sig, probename %in% names(index)[index > 3])

a <- dlply(subset(sig_mult), .(probename), .progress="text", function(x)
{
  x <- mutate(x)
  links <- makeLinks(x, gr)
  dot <- makeDot(x, gr)
  a <- plotCircos(gr, links, dot)
  return(a)
})

pdf(file="~/repo/eQTL-2D/analysis/images/circles_replication2.pdf", width=10, height=8)
multiplot(plotlist=a, cols=5)
dev.off()

