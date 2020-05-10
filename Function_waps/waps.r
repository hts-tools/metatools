waps <- function (inputps = NULL, varweight = NULL, taxopt = NULL, ranktax = FALSE)
{
require(phyloseq)
require(data.table)
psg <- tax_glom(physeq=inputps, taxrank=taxopt, NArm=TRUE, bad_empty=c(NA, "", " ", "\t"))
psmor <- psmelt(psg)
psmordt <- as.data.table(psmor)
# remove rows with varweight = NA (and "Abundance" = NA)
psmdt <- na.omit(psmordt, cols=c(varweight, "Abundance"))
psm <- as.data.frame(psmdt)

# Occurrences, uk, abundance
gf1 <- as.factor(levels(psm[[taxopt]]))
ngen <- nlevels(gf1)
psm$Occurrences <- psm$Abundance
psm$Occurrences[psm$Occurrences > 0] <- 1
occurr <- numeric(ngen)
taxsum <- numeric(ngen)
x_Taxon <- character(ngen)
y_wa <- numeric(ngen)
i <- NULL
for (i in 1:ngen) {
  psm_s <- subset(psm, psm[[taxopt]] == gf1[i])
  y_wa[i] = weighted.mean(psm_s[[varweight]], psm_s$Abundance, na.rm = FALSE)
  x_Taxon[i] <- as.character(gf1[i])
  occurr[i] <- sum(psm_s$Occurrences)
  taxsum[i] <- sum(psm_s$Abundance)
  i <- i+1
 }
df1 <- data.frame(x_Taxon, occurr, taxsum, y_wa, stringsAsFactors=FALSE)
names(df1) <- c(taxopt, "Occurrences", "TotAbund", "uk")
psmm <- merge(psm, df1, by=taxopt)

# tk
psmm$fac <- (psmm[[varweight]] - psmm$uk)^2
x_Taxon <- character(ngen)
y_tk <- numeric(ngen)
i <- NULL
for (i in 1:ngen) {
  psmm_s <- subset(psmm, psmm[[taxopt]] == gf1[i])
  y_tk[i] = sqrt(weighted.mean(psmm_s$fac, psmm_s$Abundance, na.rm = FALSE))
  x_Taxon[i] <- as.character(gf1[i])
  i <- i+1
 }
df2 <- data.frame(x_Taxon, y_tk, stringsAsFactors=FALSE)
names(df2) <- c(taxopt, "tk")

# merge
optim_ps <- Reduce(function(x,y) merge(x = x, y = y, by = taxopt), list(df1, df2))
if (ranktax == TRUE) {
	taxdfm = as(tax_table(psg), "matrix")
	taxdf = as.data.frame(taxdfm)
	optim_ps_rt <- merge(optim_ps, taxdf, by = taxopt)
	return(optim_ps_rt)
	} else {
	return(optim_ps)
	}
}
