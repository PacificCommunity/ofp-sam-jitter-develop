## Jitter preparation

library(FLR4MFCL)
library(tools)  # file_path_sans_ext
source("../../function/05_claudio/jitter.R")

# Origin and destination
model <- "03_TB-3_MSE_LW_Francis"
jitter.dir <- file.path("../../parfiles", model)
sigma <- 0.100
njitter <- 2

# Read par file
cat("* Reading parfile ... ")
par <- read.MFCLPar(finalPar(jitter.dir))
cat("done\n\n")

# Crash here if jitter() doesn't run
test <- jitter(par, 0.1, 1)

# Write jittered par files into results dir
suffix <- formatC(seq_len(njitter), width=max(nchar(njitter), 2), flag="0")
suffix <- paste0("_", suffix, ".par")
outdir <- file.path("../../results", paste0(model, "_03_palau_may"))
dir.create(outdir, showWarnings=FALSE)
for(i in 1:njitter)
{
  cat("Creating jitter file", i, "\n")
  outfile <- paste0(file_path_sans_ext(finalPar(jitter.dir)), suffix[i])
  outfile <- file.path(outdir, basename(outfile))
  write(jitter(par, sigma, i), outfile)
}

# Copy input files into results dir
file.copy(finalPar(jitter.dir), outdir, overwrite=TRUE)
