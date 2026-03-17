#-----------------------------------------------------------
# Exercise 2: Transpose for Table
#-----------------------------------------------------------

# Starting dataset: ADVS (long format)

# Goal:
# Rows    → Treatment groups (TRT01A)
# Columns → Visit (AVISIT)
# Values  → Mean AVAL for SYSBP
# Use group_by() + summarise() + pivot_wider()

# Load libraries
library(dplyr)
library(tidyr)
library(haven)

#-----------------------------------------------------------
# 0. Read ADVS dataset
#-----------------------------------------------------------
 advs <- pharmaverseadam::advs

#-----------------------------------------------------------
# 1. Filter Parameter
# Keep only SYSBP records
# using PARAMCD or VSTESTCD (as applicable).
#-----------------------------------------------------------

step1 <- advs %>%
  # Your code here
  filter(VSTESTCD %in% c("SYSBP"))
  
  #-----------------------------------------------------------
# 2. Group Data
# Group by:
# Treatment group (TRT01A)
# Visit (AVISIT)
#-----------------------------------------------------------

step2 <- step1 %>%
  # Your code here
  group_by(TRT01A,AVISIT)
  
  
  #-----------------------------------------------------------
# 3. Calculate Mean AVAL
# Calculate mean of AVAL
# for each TRT01A + AVISIT group.
#-----------------------------------------------------------

step3 <- step2 %>%
  summarise(
    Mean=mean(AVAL),.groups = "drop"
  )
  # Your code here
  
  
  #-----------------------------------------------------------
# 4. Transpose to Wide Format
# Create wide table:
# Rows    → TRT01A
# Columns → AVISIT
# Values  → Mean AVAL
# Use pivot_wider().
#-----------------------------------------------------------

tfl_table <- step3 %>%
  # Your code here
  pivot_wider(
    id_cols = c(AVISIT),
    names_from = TRT01A,
    values_from = Mean
  )
  
  
  #-----------------------------------------------------------
# 5. Final Table Output
# Review the transposed table.
#-----------------------------------------------------------

# Your code here


#-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
