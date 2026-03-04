#-----------------------------------------------------------
# Exercise 1: Multi-Domain Join
#-----------------------------------------------------------

# You have:
# ADSL → USUBJID, SAFFL, TRT01A
# VS   → USUBJID, VSTESTCD, VSSTRESN, VISITNUM

# Load library
library(dplyr)
library(tidyr)
library(haven)
setwd("D:\\R\\UpdatedCDISCPilotData\\UpdatedCDISCPilotData")
#-----------------------------------------------------------
# 0. Read ADSL and VS datasets
#-----------------------------------------------------------

adsl <-read_xpt("ADAM/adsl.xpt")
vs   <-read_xpt("SDTM/vs.xpt")

#-----------------------------------------------------------
# 1. Check Row Counts Before Join
# Check number of rows in ADSL and VS
# before performing the join.
#-----------------------------------------------------------

# Your code here
nrow(adsl)
nrow(vs)

#-----------------------------------------------------------
# 2. Join ADSL Population Flags onto VS
# Join SAFFL and TRT01A from ADSL to VS
# using USUBJID.
#-----------------------------------------------------------

vs_joined <- vs %>%
   left_join(
     adsl %>% select(USUBJID,SAFFL,TRT01A),
     by="USUBJID"
   )
  
  
  #-----------------------------------------------------------
# 3. Filter to Safety Population Only
# Keep records where SAFFL == "Y".
#-----------------------------------------------------------

vs_safety <- vs_joined %>%
    filter(SAFFL == "Y")
  
  
  #-----------------------------------------------------------
# 4. Keep Only Required Parameters
# Keep only:
# SYSBP (Systolic Blood Pressure)
# DIABP (Diastolic Blood Pressure)
# using VSTESTCD.
#-----------------------------------------------------------

vs_bp <- vs_safety %>%
   filter(VSTESTCD %in% c("SYSBP","DIABP"))
  
  
  #-----------------------------------------------------------
# 5. Check Row Counts After Join & Filtering
# Check number of rows after:
# - Join
# - Safety filter
# - Parameter filter
#-----------------------------------------------------------
nrow(vs_bp)
nrow(vs_joined)
nrow(vs_safety)
# Your code here


#-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
