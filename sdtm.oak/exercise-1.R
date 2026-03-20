#-----------------------------------------------------------
# Exercise 1: DM domain - derive oak ID variables
#-----------------------------------------------------------

# Load libraries
library(dplyr)
library(haven)
library(sdtm.oak)
#-----------------------------------------------------------
# 0. Read raw demographics
#-----------------------------------------------------------
raw_dm<- pharmaverseraw::dm_raw
ct_sdtm <- read.csv("sdtm.oak/sdtm_ct.csv")
#-----------------------------------------------------------
# 1. Generate oak_id_vars
# Keep the canonical STUDYID/USUBJID pair plus any other ID
# components (SITEID, SUBJLOC, etc.) that the pipeline expects.
#-----------------------------------------------------------

dm_new <- raw_dm %>%
  # Your code here (select/rename the required ID columns)
  generate_oak_id_vars(
    pat_var = "PATNUM",
    raw_src = "DM_DOMAIN"
  )

#-----------------------------------------------------------
# 2. Map DM variables
# Keep STUDYID, USUBJID, AGE, SEX, RACE and any required flags.
# Rename them to match the target SDTM names and create derivations
# such as AGEU, SEX, RACECD if needed.
#-----------------------------------------------------------

  # Your code here (join raw_dm back, select and rename variables)
#mapping target var(IT.AGE) to AGE in sdtm
dm <-  
  assign_no_ct(
    raw_dat = dm_new,
    raw_var = "IT.AGE",
    tgt_var = "AGE"
  ) %>% 
  assign_ct(
    raw_dat = dm_new,
    raw_var = "IT.SEX",
    tgt_var = "SEX",
    ct_spec = ct_sdtm,
    ct_clst = "C66731",
    id_vars = oak_id_vars()
  ) %>% 
  assign_ct(
    raw_dat = dm_new,
    raw_var = "IT.ETHNIC",
    tgt_var = "ETHNIC",
    ct_spec = ct_sdtm,
    ct_clst = "C66790",
    id_vars = oak_id_vars()
  ) %>% 
  assign_ct(
    raw_dat = dm_new,
    raw_var = "IT.RACE",
    tgt_var = "RACE",
    ct_spec = ct_sdtm,
    ct_clst = "C74457",
    id_vars = oak_id_vars()
  ) %>% 
  assign_no_ct(
    raw_dat = dm_new,
    raw_var = "COUNTRY",
    tgt_var = "COUNTRY",
    id_vars = oak_id_vars()
  )
   

#-----------------------------------------------------------
# 3. Export to XPT
# Use haven::write_xpt to write dm_oak to tree-ordered XPT.
#-----------------------------------------------------------
write_xpt(dm,"sdtm.oak/dm_ex1_output.xpt")
# Your code here (write dm_oak to XPT)

#-----------------------------------------------------------
# End of Exercise 1
#-----------------------------------------------------------
