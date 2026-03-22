#-----------------------------------------------------------
# Exercise 2: VS domain - build vitals topics for SDTM/OAK
#-----------------------------------------------------------

library(dplyr)
library(haven)
library(sdtm.oak)

#-----------------------------------------------------------
# 0. Read raw vital signs data
#-----------------------------------------------------------

raw_vs <- pharmaverseraw::vs_raw
ct_sdtm <- read.csv("sdtm.oak/sdtm_ct.csv")



#-----------------------------------------------------------
# 1. Map SYSBP, DIABP, PULSE topics
# Keep only the three VSTESTCD values that flow into SDTM.
#-----------------------------------------------------------

vs_topics <- raw_vs %>%
  # Your code here (filter VSTESTCD and standardize VSTESTCD/VSTEST)
  select(STUDY, PATNUM,SYS_BP,DIA_BP,PULSE,SUBPOS,VTLD)

#generatingr_oak_id_vars\
topic_id <-vs_topics %>% 
  generate_oak_id_vars(
    pat_var = "PATNUM",
    raw_src = "VS_DOMAIN"
  )

#-----------------------------------------------------------
# 2. Create topic-specific subsets
# Use the filtered data to create separate datasets for SYSBP,
# DIABP, and PULSE before recombining.
#-----------------------------------------------------------

vs_sysbp <- 
  hardcode_ct(
    raw_dat = topic_id,
    raw_var = "SYS_BP",
    tgt_var = "VSTESTCD",
    tgt_val = "SYSBP",
    ct_spec = ct_sdtm,
    ct_clst = "C66741"
  ) %>%
  #filter for records where VSTESTCD is not empty.
  #only these records need qualifier mappings.
  dplyr::filter(!is.na(.data$VSTESTCD)) %>%
  #Map VSTEST using hardcode_ct algorithm
  hardcode_ct(
    raw_dat = topic_id,
    raw_var = "SYS_BP",
    tgt_var = "VSTEST",
    tgt_val = "Systolic Blood Pressure",
    ct_spec = ct_sdtm,
    ct_clst = "C67153",
    id_vars = oak_id_vars()
  ) %>%
  assign_no_ct(
    raw_dat = topic_id,
    raw_var = "SYS_BP",
    tgt_var = "VSORRES",
    id_vars = oak_id_vars()
  ) %>% 
  hardcode_ct(
    raw_dat = topic_id,
    raw_var = "SYS_BP",
    tgt_var = "VSORRESU",
    tgt_val = "mmHg",
    ct_spec = ct_sdtm,
    ct_clst = "C66770",
    id_vars = oak_id_vars()
  ) %>% 
  assign_ct(
    raw_dat = topic_id,
    raw_var = "SUBPOS",
    tgt_var = "VSPOS",
    ct_spec = ct_sdtm,
    ct_clst = "C71148",
    id_vars = oak_id_vars()
  )
  
#mapping target varaible(DIABP) with its qualifiers 
vs_diabp <- 
  # Your code here (process DIABP rows)
  hardcode_ct(
    raw_dat = topic_id,
    raw_var = "DIA_BP",
    tgt_var = "VSTESTCD",
    tgt_val = "DIABP",
    ct_spec = ct_sdtm,
    ct_clst = "C66741"
  ) %>% 
  dplyr::filter(!is.na(.data$VSTESTCD)) %>% 
  hardcode_ct(
    raw_dat = topic_id,
    raw_var = "DIA_BP",
    tgt_var = "VSTEST",
    tgt_val = "Diastolic Blood Pressure",
    ct_spec = ct_sdtm,
    ct_clst = "C67153",
    id_vars = oak_id_vars()
  ) %>% 
  assign_no_ct(
    raw_dat = topic_id,
    raw_var = "DIA_BP",
    tgt_var = "VSORRES",
    id_vars = oak_id_vars()
  ) %>% 
  hardcode_ct(
    raw_dat = topic_id,
    raw_var = "DIA_BP",
    tgt_var= "VSORRESU",
    tgt_val = "mmHg",
    ct_spec = ct_sdtm,
    ct_clst = "C66770",
    id_vars = oak_id_vars()
  ) %>% 
  assign_ct(
    raw_dat = topic_id,
    raw_var = "SUBPOS",
    tgt_var = "VSPOS",
    ct_spec = ct_sdtm,
    ct_clst = "C71148",
    id_vars = oak_id_vars()
  )

#mapping target varaible(PULSE) with its qualifiers 
vs_pulse <- 
  # Your code here (process PULSE rows)
     hardcode_ct(
       raw_dat = topic_id,
       raw_var = "PULSE",
       tgt_var = "VSTESTCD",
       tgt_val = "PULSE",
       ct_spec = ct_sdtm,
       ct_clst = "C66741"
     ) %>% 
  dplyr::filter(!is.na(.data$VSTESTCD)) %>% 
  hardcode_ct(
    raw_dat = topic_id,
    raw_var = "PULSE",
    tgt_var = "VSTEST",
    tgt_val = "Pulse Rate",
    ct_spec = ct_sdtm,
    ct_clst = "C67153",
    id_vars = oak_id_vars()
  ) %>% 
  assign_no_ct(
    raw_dat = topic_id,
    raw_var = "PULSE",
    tgt_var = "VSORRES",
    id_vars = oak_id_vars()
  ) %>% 
  hardcode_ct(
    raw_dat = topic_id,
    raw_var = "PULSE",
    tgt_var = "VSORRESU",
    tgt_val = "beats/min",
    ct_spec = ct_sdtm,
    ct_clst = "C66770",
    id_vars = oak_id_vars()
  ) %>% 
  assign_ct(
    raw_dat = topic_id,
    raw_var = "SUBPOS",
    tgt_var = "VSPOS",
    ct_spec = ct_sdtm,
    ct_clst = "C71148",
    id_vars = oak_id_vars()
  )
#-----------------------------------------------------------
# 3. Bind rows for a unified VS dataset
#-----------------------------------------------------------

vs_bound <- bind_rows(vs_sysbp, vs_diabp, vs_pulse)

#-----------------------------------------------------------
# 4. Add qualifiers and map timing
# Create qualifiers (e.g., POSITION, LOC, BLFL) and derive
# visit/time metadata (VISITNUM, VSTPT, VSDTC) before export.
#-----------------------------------------------------------

vs_final <- vs_bound %>%
  # Your code here (mutate qualifiers/timing variables)
  assign_datetime(
    raw_dat = topic_id, 
    raw_var = "VTLD",
    tgt_var = "VSDTC",
    raw_fmt = c("d-m-y"),
    id_vars = oak_id_vars()
  ) %>% 
  dplyr::mutate(
    STUDYID = "test_study",
    DOMAIN= "VS",
    VSCAT = "VITAL SIGNS",
    USUBJID = paste0("test_study","-",.data$patient_number)
  ) %>% 
  dplyr::select("STUDYID", "DOMAIN", "USUBJID", "VSTESTCD", "VSTEST", "VSPOS", "VSORRES", "VSORRESU", "VSDTC")
#-----------------------------------------------------------
# 5. Export to XPT
#-----------------------------------------------------------

# Your code here (write vs_final to XPT)
write_xpt(vs_final,"sdtm.oak/vs_ex2_output.xpt")
#-----------------------------------------------------------
# End of Exercise 2
#-----------------------------------------------------------
