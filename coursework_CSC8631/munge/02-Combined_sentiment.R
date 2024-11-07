library(dplyr)
library(stringr)
library(lubridate)

# ---------------- Select sentiment survey response ---------------- #
# Get all data frames matching the "sentiment" pattern
sentiment_dfs <- mget(ls(pattern = "sentiment"))

# Remove empty data frames or those without required columns
sentiment_dfs <- Filter(function(df) {
  nrow(df) > 0 && "responded_at" %in% names(df)
}, sentiment_dfs)

# Add run_number to each data frame based on the file name
sentiment_dfs <- Map(function(df, name) {
  df$run_number <- as.integer(str_extract(name, "\\d+"))
  df$responded_at <- ymd_hms(df$responded_at, quiet = TRUE)
  return(df)
}, sentiment_dfs, names(sentiment_dfs))

preprocessed_sentiment <- bind_rows(sentiment_dfs)

