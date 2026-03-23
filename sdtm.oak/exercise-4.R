#-----------------------------------------------------------
# Exercise 4: AE domain - stretch goal for Events
#-----------------------------------------------------------

library(dplyr)
library(haven)
library(sdtm.oak)

#-----------------------------------------------------------
# 0. Read raw adverse events data
#-----------------------------------------------------------

raw_ae <- pharmaverseraw::ae_raw
ct_sdtm <- read.csv("sdtm.oak/sdtm_ct.csv")

#-----------------------------------------------------------
# 1. Map AE core variables
# Keep AE term, severity, relationship, and standardized event IDs.
#-----------------------------------------------------------
ae_tab <-raw_ae %>% 
  generate_oak_id_vars(
  pat_var = "PATNUM",
  raw_src = "AE_DOMAIN"
)



ae_core <- 
  assign_no_ct(
    raw_dat = ae_tab,
    raw_var = "IT.AETERM",
    tgt_var = "AETERM"
  )%>%
  dplyr::filter(!is.na(.data$AETERM)) %>% 
  assign_ct(
    raw_dat = ae_tab,
    raw_var = "IT.AESEV",
    tgt_var = "AESEV",
    ct_spec = ct_sdtm,
    ct_clst = "C66769",
    id_vars = oak_id_vars()
  ) %>% 
  assign_ct(
    raw_dat = ae_tab,
    raw_var = "IT.AESER",
    tgt_var = "AESER",
    ct_spec = ct_sdtm,
    ct_clst = "C66742",
    id_vars = oak_id_vars()
  ) %>% 
  assign_no_ct(
    raw_dat = ae_tab,
    raw_var = "IT.AEREL",
    tgt_var = "AEREL",
    id_vars = oak_id_vars()
  )
  
  # Your code here (select/rename AETERM, AESEV, AESER, etc.)

#-----------------------------------------------------------
# 2. Derive AE modifiers and outcomes
# Use conditional logic to populate AESCONG, AEMODIFY, etc.
#-----------------------------------------------------------

  # Your code here (derive outcomes, seriousness flags)

#-----------------------------------------------------------
# 3. Map timing and exposure details
# Standardize AESTDTC, AEENDTC, and link to treatment epochs.
#-----------------------------------------------------------

ae_final <- ae_core %>% 
  assign_datetime(
    raw_dat = ae_tab,
    raw_var = "AEDTCOL",
    tgt_var = "AEDTC",
    raw_fmt = c("d/m/y"),
    id_vars = oak_id_vars()
  ) %>% 
  assign_datetime(
    raw_dat = ae_tab,
    raw_var = "IT.AESTDAT",
    tgt_var = "AESTDATC",
    raw_fmt = c("d/m/y"),
    id_vars = oak_id_vars()
  ) %>% 
  assign_datetime(
    raw_dat = ae_tab,
    raw_var = "IT.AEENDAT",
    tgt_var = "AEENDATC",
    raw_fmt = c("d/m/y"),
    id_vars = oak_id_vars()
  ) %>% 
  dplyr::mutate(
    STUDYID = "test_study",
    DOMAIN= "AE",
    VSCAT = "ADVERSE EVENTS",
    USUBJID = paste0("test_study","-",.data$patient_number)
  ) %>%
  derive_seq(
    tgt_var = "AESEQ",
    rec_vars = c("USUBJID","AETERM")
  ) %>% 
  dplyr::select("USUBJID","DOMAIN","STUDYID","AETERM","AESEV","AESER","AEREL","AEDTC","AESTDATC","AEENDATC","AESEQ")
    
  
  # Your code here (mutate date columns, derive AESEQ/VISIT)

#-----------------------------------------------------------
# 4. Export to XPT
#-----------------------------------------------------------

# Your code here (write ae_timing to XPT)
write_xpt(ae_final,"sdtm.oak/ae_ex4_output.xpt")

#-----------------------------------------------------------
# End of Exercise 4
#-----------------------------------------------------------
