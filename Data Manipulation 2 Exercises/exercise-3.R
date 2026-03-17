#-----------------------------------------------------------
# Exercise 3: Write a Helper Function
#-----------------------------------------------------------

# Goal:
# Create a function called derive_baseline_flag()

# Function Requirements:
# - Takes a dataframe as input
# - Takes a baseline visit value as input
# - Creates BASEFL = "Y" when AVISIT matches baseline visit
# - Returns modified dataframe

#-----------------------------------------------------------
# 0. Load Library
#-----------------------------------------------------------

library(dplyr)
library(haven)

#-----------------------------------------------------------
# 1. Create Helper Function
# Function name: derive_baseline_flag()
# Inputs:
#   - dataframe
#   - baseline visit value
# Output:
#   - dataframe with BASEFL variable
#-----------------------------------------------------------

derive_baseline_flag <- function(df, baseline_visit){
  df %>% 
    mutate(BASEFL = if_else(VISIT==baseline_visit,"Y",NA_character_))
}
  
  # Your code here
  


#-----------------------------------------------------------
# 2. Read Sample VS Data
#-----------------------------------------------------------

vs <- pharmaversesdtm::vs

#-----------------------------------------------------------
# 3. Test the Function
# Apply function on VS dataset
# using baseline visit = "SCREENING".
#-----------------------------------------------------------

vs_with_basefl <-vs %>% 
  derive_baseline_flag("BASELINE")
  # Your code here
  
  
  #-----------------------------------------------------------
# 4. Verify Output
# Check whether BASEFL is correctly derived.
#-----------------------------------------------------------

# Your code here
check <- vs_with_basefl %>% 
  filter(BASEFL!=VSBLFL)

#-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
