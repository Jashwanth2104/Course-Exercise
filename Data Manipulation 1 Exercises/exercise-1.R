#-----------------------------------------------------------
# Exercise 1: Derive ADLB from SDTM LB
#-----------------------------------------------------------

# Load libraries
library(dplyr)
library(haven)
setwd("D:\\R\\UpdatedCDISCPilotData\\UpdatedCDISCPilotData")

#-----------------------------------------------------------
# 0. Read SDTM LB and ADSL datasets
#-----------------------------------------------------------

lb   <- read_xpt("SDTM/lb.xpt")
adsl <- read_xpt("ADAM/adsl.xpt")

#-----------------------------------------------------------
# 01. Select Variables
# Select only essential variables:
# STUDYID, USUBJID, LBTEST, LBSTRESN,
# LBSTRESU, LBDTC, VISITNUM.
#-----------------------------------------------------------

adlb_step1 <- lb %>%
        select(STUDYID,USUBJID,LBTEST,LBSTRESN,LBSTRESU,LBDTC,VISITNUM)
adlb_step1
  
  
  #-----------------------------------------------------------
# 02. Filter Data
# Filter to Safety Population (SAFFL == "Y")
# and non-missing results.
#-----------------------------------------------------------

adlb_step2 <- adlb_step1 %>%
  # Your code here
  inner_join(filter(select(adsl,STUDYID,USUBJID,SAFFL),SAFFL == "Y"),by=c("STUDYID","USUBJID"))

 #filter(if_any(adlb_step1,SAFFL == "Y", !is.na(AVAL)))
  
  
  #-----------------------------------------------------------
# 03. Create PARAMCD
# Create PARAMCD from LBTEST:
# "Alanine Aminotransferase" → "ALT"
# "Aspartate Aminotransferase" → "AST"
# "Bilirubin" → "BILI"
#-----------------------------------------------------------

adlb_step3 <- adlb_step2 %>%
  # Your code here
  mutate(
    PARAMCD=case_when(
       LBTEST == "Alanine Aminotransferase" ~ "ALT",
       LBTEST == "Aspartate Aminotransferase" ~ "AST",
       LBTEST == "Bilirubin" ~ "BILI",
       TRUE ~ NA_character_
    )
  )
  
  
  #-----------------------------------------------------------
# 04. Create AVAL
# Create AVAL from LBSTRESN
# (numeric analysis value).
#-----------------------------------------------------------

adlb_step4 <- adlb_step3 %>%
  # Your code here
mutate(AVAL=LBSTRESN)
  
  
  #-----------------------------------------------------------
# 05. Create AVISITN
# Create AVISITN from VISITNUM.
#-----------------------------------------------------------

adlb_step5 <- adlb_step4 %>%
  # Your code here
  mutate(AVISITN=VISITNUM)
  
  #-----------------------------------------------------------
# 06. Derive ABLFL
# Derive baseline flag (ABLFL)
# where VISITNUM == 0.
#-----------------------------------------------------------

adlb_step6 <- adlb_step5 %>%
  # Your code here
  mutate(AVAL=LBSTRESN,
         ABLFL=if_else(VISITNUM == 0,"Y",NA_character_)
         )
  
  
  #-----------------------------------------------------------
# 07. Calculate BASE
# Calculate baseline value (BASE)
# for each USUBJID and PARAMCD.
#-----------------------------------------------------------

baseline <- adlb_step6 %>%
  # Your code here
  filter(ABLFL == "Y") %>%
  select(USUBJID,PARAMCD,BASE=AVAL)
  
  adlb_step7 <- adlb_step6 %>%
  # Your code here
  left_join(baseline,by=c("USUBJID","PARAMCD"))
  
  #-----------------------------------------------------------
# 08. Calculate CHG
# Calculate change from baseline
# (CHG = AVAL - BASE).
#-----------------------------------------------------------

adlb_final <- adlb_step7 %>%
  # Your code here
    mutate(CHG = AVAL - BASE)
  
  
  #-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
