#-----------------------------------------------------------
# Exercise 6: String Parsing
#-----------------------------------------------------------

# Given variable:
# USUBJID format → "STUDY001-USA-101-0001"

# Goals:
# 1. Extract Study ID
#    (first part before first dash)
# 2. Extract Country Code
#    (second part)
# 3. Create SUBJID_SHORT
#    (last two parts combined)
# 4. Check if any subjects are from "USA" sites

# Use stringr functions:
# str_split(), word(), or str_sub()

#-----------------------------------------------------------
# 0. Load Library
#-----------------------------------------------------------

library(dplyr)
library(stringr)

#-----------------------------------------------------------
# 1. Create Sample Data
#-----------------------------------------------------------

df <- data.frame(
  USUBJID = c(
    "STUDY001-USA-101-0001",
    "STUDY001-IND-102-0002",
    "STUDY001-USA-103-0003"
  ),
  stringsAsFactors = FALSE
)

#-----------------------------------------------------------
# 2. Extract Study ID
# Extract first part before first dash.
#-----------------------------------------------------------

df_step1 <- df %>%
  mutate(STUDYID=word(USUBJID,1,sep = "-"))
  # Your code here
  
  
  #-----------------------------------------------------------
# 3. Extract Country Code
# Extract second part of USUBJID.
#-----------------------------------------------------------

df_step2 <- df_step1 %>%
  mutate(COUNTRYCODE=word(USUBJID,2,sep = "-"))
  # Your code here
  
  
  #-----------------------------------------------------------
# 4. Create SUBJID_SHORT
# Combine last two parts:
# Example → "101-0001"
#-----------------------------------------------------------

df_step3 <- df_step2 %>%
  mutate(SUBJID_SHORT=word(USUBJID,3,4,sep="-"))
  # Your code here
  
  
  #-----------------------------------------------------------
# 5. Check USA Subjects
# Identify if any subjects
# are from "USA" sites.
#-----------------------------------------------------------

usa_check <- df_step3 %>% 
  filter(COUNTRYCODE %in% "USA")
  # Your code here
  
  
  #-----------------------------------------------------------
# 6. Review Output
#-----------------------------------------------------------

# Your code here
usa_check

#-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
