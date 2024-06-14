remotes::install_github("PacificCommunity/ofp-sam-flr4mfcl@master")
remotes::install_github("PacificCommunity/ofp-sam-flr4mfcl@spa_2024_hacks")

library(FLR4MFCL)

# Download zipfile
zipfile <- "TB-3_MSE_LW_Francis.zip"
if(!file.exists(zipfile))
  download.file("https://github.com/PacificCommunity/ofp-sam-jitter-develop/releases/download/TB-3_MSE_LW_Francis/TB-3_MSE_LW_Francis.zip", zipfile)

# Unzip, set executable bit, copy Bash scripts
folder <- "TB-3_MSE_LW_Francis"
if(!dir.exists(folder))
  unzip(zipfile)
Sys.chmod(file.path(folder, "mfclo64"))
file.copy("do_07.sh", folder)
file.copy("do_07_flr.sh", folder)

# Read 07 and write out as 07_flr
par <- read.MFCLPar(file.path(folder, "07.par"))
write(par, file.path(folder, "07_flr.par"))

# Run 07
if(dir.exists(folder))
{
  setwd(folder)
  system("do_07.sh")
  setwd("..")
}

# Run 07_flr
if(dir.exists(folder))
{
  setwd(folder)
  system("do_07_flr.sh")
  setwd("..")
}

# Compare 07 input files (lines of text)
t07 <- readLines(file.path(folder, "07.par"))
t07.flr <- readLines(file.path(folder, "07_flr.par"))
c(length(t07), length(t07.flr))
identical(t07, t07.flr)

# Compare 07 input files (values)
v07 <- scan(file.path(folder, "07.par"), comment="#")
v07.flr <- scan(file.path(folder, "07_flr.par"), comment="#")
c(length(v07), length(v07.flr))
identical(v07, v07.flr)

# Compare 07 input files (FLR objects)
p07 <- read.MFCLPar(file.path(folder, "07.par"))
p07.flr <- read.MFCLPar(file.path(folder, "07_flr.par"))
identical(p07, p07.flr)

# Compare 08 output files (lines of text)
t08 <- readLines(file.path(folder, "08.par"))
t08.flr <- readLines(file.path(folder, "08_flr.par"))
c(length(t08), length(t08.flr))
identical(t08, t08.flr)
data.frame(t08, t08.flr)[t08!=t08.flr,]

# Compare 08 output files (values)
v08 <- scan(file.path(folder, "08.par"), comment="#")
v08.flr <- scan(file.path(folder, "08_flr.par"), comment="#")
c(length(v08), length(v08.flr))
identical(v08, v08.flr)
data.frame(v08, v08.flr)[v08!=v08.flr,]

# Compare 08 output files (FLR objects)
p08 <- read.MFCLPar(file.path(folder, "08.par"))
p08.flr <- read.MFCLPar(file.path(folder, "08_flr.par"))
identical(p08, p08.flr)
