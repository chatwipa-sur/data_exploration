#  Select sentiment survey response
sentiment_dfs <- mget(ls(pattern = "weekly.sentiment.survey"))

# Remove empty data frames
sentiment_dfs <- Filter(function(df) {
  nrow(df) > 0 && "responded_at" %in% names(df)
}, sentiment_dfs)

# Convert columns to the same data type 
sentiment_dfs <- Map(function(df, name) {
  df$run_number <- as.integer(str_extract(name, "\\d+")) #add name column
  df$responded_at <- ymd_hms(df$responded_at, quiet = TRUE)
  return(df)
}, sentiment_dfs, names(sentiment_dfs))

# Combine all data frames
preprocessed_sentiment <- bind_rows(sentiment_dfs)

cache('preprocessed_sentiment')