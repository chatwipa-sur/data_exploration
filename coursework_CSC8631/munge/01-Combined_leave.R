library(dplyr)
library(stringr)
library(lubridate)

# ---------------- Select leaving survey response ---------------- #
leave_dfs <- mget(ls(pattern = "leaving.survey.response"))

# Convert columns to the same data type and store all data frame in one list
leave_dfs <- Map(function(df, name) {
  df$run_number <- as.integer(str_extract(name, "\\d+"))
  df$learner_id <- as.character(df$learner_id)
  df$leaving_reason <- as.character(df$leaving_reason)
  
  # Time stamp handling
  df$left_at <- ymd_hms(df$left_at, quiet = TRUE)
  df$last_completed_step_at <- ymd_hms(df$last_completed_step_at, quiet = TRUE)
  return(df)
}, leave_dfs, names(leave_dfs))

# Combine all data frames into one
leave_survey_all <- bind_rows(leave_dfs)
leave_survey_all$leaving_reason <- gsub("’", "'", leave_survey_all$leaving_reason)

# ---------------- Select enrollment ---------------- #
enroll_dfs <- mget(ls(pattern = "enrolments"))

# Convert columns to the same data type and store all data frame in one list
enroll_dfs <- Map(function(df, name) {
  df$run_number <- as.integer(str_extract(name, "\\d+"))
  df$learner_id <- as.character(df$learner_id)

  # Time stamp handling
  df$enrolled_at <- ymd_hms(df$enrolled_at, quiet = TRUE)
  df$unenrolled_at <- ymd_hms(df$unenrolled_at, quiet = TRUE)
  df$fully_participated_at <- ymd_hms(df$fully_participated_at, quiet = TRUE)
  df$purchased_statement_at <- ymd_hms(df$purchased_statement_at, quiet = TRUE)
  return(df)
}, enroll_dfs, names(enroll_dfs))

# Combine all data frames into one
enroll_survey_all <- bind_rows(enroll_dfs)

preprocessed_leave <- full_join(enroll_survey_all, leave_survey_all, by = c("learner_id", "run_number"))

# Cache the combined data frame
cache('preprocessed_leave')
