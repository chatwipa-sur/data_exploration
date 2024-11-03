library(dplyr)
library(stringr)
library(lubridate)

# Select and store data frames
dfs <- mget(ls(pattern = "leaving.survey.response"))

# Convert columns to the same data type and store all data frame in one list
dfs <- Map(function(df, name) {
  df$run_number <- as.integer(str_extract(name, "\\d+"))
  df$learner_id <- as.character(df$learner_id)
  df$leaving_reason <- as.character(df$leaving_reason)
  
  # Time stamp handling
  df$left_at <- ymd_hms(df$left_at, quiet = TRUE)
  df$last_completed_step_at <- ymd_hms(df$last_completed_step_at, quiet = TRUE)
  return(df)
}, dfs, names(dfs))

# Combine all data frames into one
all_leaving_survey <- bind_rows(dfs)

# Cache the combined data frame
cache('all_leaving_survey')
