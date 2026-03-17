#-----------------------------------------------------------
# Exercise 5: Date Derivations
#-----------------------------------------------------------

# Given:
# TRTSDT  = "2024-01-15"
# AESTDTC = "2024-01-20"

# Goals:
# 1. Convert both to Date objects
# 2. Derive Study Day (ASTDY) following CDISC rules (no Day 0)
# 3. Calculate duration in days
# 4. Verify what ASTDY should be

#-----------------------------------------------------------
# 0. Create Input Data
#-----------------------------------------------------------
library(dplyr)
library(lubridate)
library(admiral)
trtsdt_char  <- "2024-01-15"
aestdtc_char <- "2024-01-20"

#-----------------------------------------------------------
# 1. Convert to Date Objects
# Convert TRTSDT and AESTDTC
# from character to Date format.
#-----------------------------------------------------------

trtsdt <- as.Date(trtsdt_char)
  # Your code here
  
  aestdtc <-as.Date(aestdtc_char) 
  # Your code here

  adae= pharmaverseadam::adae
  #-----------------------------------------------------------
# 2. Derive Study Day (ASTDY)
# Follow CDISC rules:
# - No Day 0
# - If event date ≥ treatment start → positive day
# - If event date < treatment start → negative day
#-----------------------------------------------------------

ASTDY<-adae %>% 
    mutate(ASTDY = ifelse(as.Date(AESTDTC) >= as.Date(TRTSDT),
                          "positive",
                          "negative"
                          )
    )
                      
  # Your code here
  
  
  #-----------------------------------------------------------
# 3. Calculate Duration
# Calculate difference in days
# between AESTDTC and TRTSDT.
#-----------------------------------------------------------

duration_days <-ASTDY %>% 
    mutate(
  DURATION = as.integer(as.Date(AESTDTC) - as.Date(TRTSDT) + 1)
)
  # Your code here
  
  
  #-----------------------------------------------------------
# 4. Verify ASTDY
# Print or check ASTDY value.
#-----------------------------------------------------------

# Your code here


#-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
