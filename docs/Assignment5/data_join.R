# Invoke library
library(tidyverse)

# Create data frame
apple_data <- readRDS("apple_data.rds")
apple_data <- mutate(apple_data, trackId = as.numeric(trackId))

itunes_data <- readRDS("itunes_data.rds")

song_data <- left_join(apple_data, itunes_data, by = "trackId")

# Inspect name of columns
names(song_data)

# Save data
saveRDS(song_data, "song_data.rds")
