#-----------------------------------------------------------
# Exercise 4: Loop Over Parameters
#-----------------------------------------------------------

# Parameters to process:
# SYSBP, DIABP, PULSE, TEMP

# Goal:
# 1. Filter ADVS to each parameter
# 2. Calculate N, Mean, SD by Treatment and Visit
# 3. Combine all results into one summary table
# Hint: Use map() + bind_rows()

#-----------------------------------------------------------
# 0. Load Libraries
#-----------------------------------------------------------

library(dplyr)

#-----------------------------------------------------------
# 1. Read ADVS Dataset
#-----------------------------------------------------------

advs <- pharmaverseadam::advs

#-----------------------------------------------------------
# 2. Create Parameter List
# Store vital signs parameters in a vector.
#-----------------------------------------------------------

params <- c("SYSBP", "DIABP", "PULSE", "TEMP")
  # Your code here

#-----------------------------------------------------------
# 3. Loop Over Parameters Using map()
# For each parameter:
#   - Filter dataset
#   - Group by TRT01A and AVISIT
#   - Calculate:
#       N
#       Mean of AVAL
#       SD of AVAL
#-----------------------------------------------------------

summary_list <- map(params,function(param) {
    advs %>% 
    filter(PARAMCD==param) %>% 
    group_by(TRT01A,AVISIT) %>% 
    summarise(
      N=n(),
      Mean = mean(AVAL,na.rm=TRUE),
      SD = sd(AVAL,na.rm = TRUE),
      .groups="drop"
    ) %>% 
    mutate(PARAMCD=param)
  }
)

#-----------------------------------------------------------
# 4. Combine Results
# Combine all parameter summaries
# into one final table
# using bind_rows().
#-----------------------------------------------------------

final_summary <- bind_rows(summary_list)
   
  
  
  #-----------------------------------------------------------
# 5. Review Final Output
#-----------------------------------------------------------

# Your code here


#-----------------------------------------------------------
# End of Exercise
#-----------------------------------------------------------
