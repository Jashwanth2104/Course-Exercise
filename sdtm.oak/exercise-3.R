#-----------------------------------------------------------
# Exercise 3: CM domain - derive concomitant medications
#-----------------------------------------------------------

library(dplyr)
library(haven)

#-----------------------------------------------------------
# 0. Read raw concomitant medication data
#-----------------------------------------------------------

raw_cm <- read.csv("raw_conmeds.csv", stringsAsFactors = FALSE)

#-----------------------------------------------------------
# 1. Map treatment names and grouping
# Map CMTRT and CMGRPID from the raw labels.
#-----------------------------------------------------------

cm_topics <- raw_cm %>%
  # Your code here (clean CMTRT, derive CMGRPID)

#-----------------------------------------------------------
# 2. Add conditional mappings
# Derive CMSTRTPT and CMMODIFY using conditional logic
# (e.g., when CMSTPT is missing or instructions flag modifications).
#-----------------------------------------------------------

cm_conditional <- cm_topics %>%
  # Your code here (case_when for flags and modifiers)

#-----------------------------------------------------------
# 3. Map date variables
# Standardize CMSTDTC, CMENDTC, and other relevant dates.
#-----------------------------------------------------------

cm_final <- cm_conditional %>%
  # Your code here (mutate date strings/datetimes before export)

#-----------------------------------------------------------
# 4. Export to XPT
#-----------------------------------------------------------

# Your code here (write cm_final to XPT)

#-----------------------------------------------------------
# End of Exercise 3
#-----------------------------------------------------------
