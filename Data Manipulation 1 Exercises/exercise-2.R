#-----------------------------------------------------------
# Exercise 2: Create Summary Statistics for TFL
# Using ADLB Dataset
#-----------------------------------------------------------

# Load library
library(dplyr)
library(haven)
setwd("D:\\R\\UpdatedCDISCPilotData\\UpdatedCDISCPilotData\\ADAM")

#-----------------------------------------------------------
# 0. Read ADLB dataset
#-----------------------------------------------------------

adlbc <- read_xpt("adlbc.xpt")

#-----------------------------------------------------------
# 01. Filter Visits
# Filter to post-baseline visits only
# (AVISITN > 0).
#-----------------------------------------------------------

tfl_step1 <- adlbc %>%
  # Your code here
  filter(AVISITN > 0)
  
  
  #-----------------------------------------------------------
# 02. Filter Tests
# Filter to liver function tests:
# PARAMCD %in% c("ALT", "AST", "BILI").
#-----------------------------------------------------------

tfl_step2 <- tfl_step1 %>%
  # Your code here
  filter( PARAMCD %in% c("ALT", "AST", "BILI"))
  
  #-----------------------------------------------------------
# 03. Group Data
# Group by:
# Treatment group (TRTGRP),
# Parameter (PARAMCD),
# Visit (AVISITN).
#-----------------------------------------------------------

tfl_step3 <- tfl_step2 %>%
  # Your code here
  group_by(TRTP,PARAMCD,AVISITN)

  
  
  #-----------------------------------------------------------
# 04. Calculate Statistics
# Calculate the following:
# N (number of subjects)
# Mean of AVAL
# Standard Deviation of AVAL
# Median of AVAL
# Min of AVAL
# Max of AVAL
# Mean of CHG (change from baseline)
#-----------------------------------------------------------

tfl_step4 <- tfl_step3 %>%
  # Your code here
  summarise(N=n(),
  Mean=mean(AVAL,na.arm=TRUE),
  Median=median(AVAL,na.arm=TRUE),
  SD=sd(AVAL),
  Min=min(AVAL,na.arm=TRUE),
  Max=max(AVAL,na.arm=TRUE),
  Mean_of_CHG=mean(CHG,na.arm=TRUE),.groups = "drop"
  )
  
  #-----------------------------------------------------------
# 05. Handle Missing Values
# Ensure proper handling of missing values
# (e.g., using na.rm = TRUE).
#-----------------------------------------------------------

tfl_step5 <- tfl_step4 %>%
  # Your code here
  
  
  #-----------------------------------------------------------
# 06. Drop Grouping
# Remove grouping structure after summarization
# (using .groups = "drop").
#-----------------------------------------------------------

tfl_final <- tfl_step4 %>%
  # Your code here

  
  
  #-----------------------------------------------------------
# End of Exercise
#--------------------------------------------------------------
