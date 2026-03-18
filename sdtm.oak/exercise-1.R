#-----------------------------------------------------------
# Exercise 1: DM domain - derive oak ID variables
#-----------------------------------------------------------

# Load libraries
library(dplyr)
library(haven)

#-----------------------------------------------------------
# 0. Read raw demographics
#-----------------------------------------------------------

raw_dm <- read.csv("raw_demographics.csv", stringsAsFactors = FALSE)

#-----------------------------------------------------------
# 1. Generate oak_id_vars
# Keep the canonical STUDYID/USUBJID pair plus any other ID
# components (SITEID, SUBJLOC, etc.) that the pipeline expects.
#-----------------------------------------------------------

dm <- raw_dm %>%
  # Your code here (select/rename the required ID columns)


#-----------------------------------------------------------
# 2. Map DM variables
# Keep STUDYID, USUBJID, AGE, SEX, RACE and any required flags.
# Rename them to match the target SDTM names and create derivations
# such as AGEU, SEX, RACECD if needed.
#-----------------------------------------------------------

  # Your code here (join raw_dm back, select and rename variables)


#-----------------------------------------------------------
# 3. Export to XPT
# Use haven::write_xpt to write dm_oak to tree-ordered XPT.
#-----------------------------------------------------------

# Your code here (write dm_oak to XPT)

#-----------------------------------------------------------
# End of Exercise 1
#-----------------------------------------------------------
