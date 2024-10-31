# Un-enroll combine table
library('dplyr')

# Select and store data frames
dfs <- mget(ls(pattern = "leaving.survey"))

# Convert all column to be same type of data
dfs <- lapply(dfs, function(df) {
  df$learner_id <- as.character(df$learner_id)
  df$leaving_reason <- as.character(df$leaving_reason)
  df$left_at <- as.POSIXct(df$left_at, origin = "1970-01-01", tz = "UTC")
  df$last_completed_step_at <- as.POSIXct(df$left_at, origin = "1970-01-01", tz = "UTC")
  df$year <- as.integer(format(df$left_at, "%Y"))
  return(df)
})


all_leaving_survey <- bind_rows(dfs)

cache('all_leaving_survey')