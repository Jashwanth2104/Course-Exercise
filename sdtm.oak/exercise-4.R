#-----------------------------------------------------------
# Exercise 4: AE domain - stretch goal for Events
#-----------------------------------------------------------

library(dplyr)
library(haven)

#-----------------------------------------------------------
# 0. Read raw adverse events data
#-----------------------------------------------------------

raw_ae <- read.csv("raw_ae.csv", stringsAsFactors = FALSE)

#-----------------------------------------------------------
# 1. Map AE core variables
# Keep AE term, severity, relationship, and standardized event IDs.
#-----------------------------------------------------------

ae_core <- raw_ae %>%
  # Your code here (select/rename AETERM, AESEV, AESER, etc.)

#-----------------------------------------------------------
# 2. Derive AE modifiers and outcomes
# Use conditional logic to populate AESCONG, AEMODIFY, etc.
#-----------------------------------------------------------

ae_modifiers <- ae_core %>%
  # Your code here (derive outcomes, seriousness flags)

#-----------------------------------------------------------
# 3. Map timing and exposure details
# Standardize AESTDTC, AEENDTC, and link to treatment epochs.
#-----------------------------------------------------------

ae_timing <- ae_modifiers %>%
  # Your code here (mutate date columns, derive AESEQ/VISIT)

#-----------------------------------------------------------
# 4. Export to XPT
#-----------------------------------------------------------

# Your code here (write ae_timing to XPT)

#-----------------------------------------------------------
# End of Exercise 4
#-----------------------------------------------------------
