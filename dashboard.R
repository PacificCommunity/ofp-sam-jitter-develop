library(FLR4MFCL)  # 'spa_2024_hacks' branch

p1 <- read.MFCLPar("results/03_TB-3_MSE_LW_Francis_03_palau_may/07.par")
p2 <- read.MFCLPar("results/03_TB-3_MSE_LW_Francis_03_palau_may/regurgitated_original.par")

v1 <- scan("results/03_TB-3_MSE_LW_Francis_03_palau_may/07.par", comment="#")
v2 <- scan("results/03_TB-3_MSE_LW_Francis_03_palau_may/regurgitated_original.par", comment="#")
