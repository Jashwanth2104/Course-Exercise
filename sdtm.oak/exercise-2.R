#-----------------------------------------------------------
# Exercise 2: VS domain - build vitals topics for SDTM/OAK
#-----------------------------------------------------------

library(dplyr)
library(haven)

#-----------------------------------------------------------
# 0. Read raw vital signs data
#-----------------------------------------------------------

raw_vs <- read.csv("raw_vitals.csv", stringsAsFactors = FALSE)

#-----------------------------------------------------------
# 1. Map SYSBP, DIABP, PULSE topics
# Keep only the three VSTESTCD values that flow into SDTM.
#-----------------------------------------------------------

vs_topics <- raw_vs %>%
  # Your code here (filter VSTESTCD and standardize VSTESTCD/VSTEST)


#-----------------------------------------------------------
# 2. Create topic-specific subsets
# Use the filtered data to create separate datasets for SYSBP,
# DIABP, and PULSE before recombining.
#-----------------------------------------------------------

vs_sysbp <- 
  # Your code here (process SYSBP rows)

vs_diabp <- 
  # Your code here (process DIABP rows)

vs_pulse <- 
  # Your code here (process PULSE rows)

#-----------------------------------------------------------
# 3. Bind rows for a unified VS dataset
#-----------------------------------------------------------

vs_bound <- bind_rows(vs_sysbp, vs_diabp, vs_pulse)

#-----------------------------------------------------------
# 4. Add qualifiers and map timing
# Create qualifiers (e.g., POSITION, LOC, BLFL) and derive
# visit/time metadata (VISITNUM, VSTPT, VSDTC) before export.
#-----------------------------------------------------------

vs_final <- vs_bound %>%
  # Your code here (mutate qualifiers/timing variables)

#-----------------------------------------------------------
# 5. Export to XPT
#-----------------------------------------------------------

# Your code here (write vs_final to XPT)

#-----------------------------------------------------------
# End of Exercise 2
#-----------------------------------------------------------
