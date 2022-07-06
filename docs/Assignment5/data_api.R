# Invoke Libraries
library(tidyverse)
library(jsonlite)

# Create apple_data data frame
apple_data <- readRDS("apple_data.rds")

trackIds <- apple_data$trackId %>%
  unique() %>%
  na.omit()

# Get data from iTunes API
itunes_data <- map_df(c(1:length(trackIds)), function(i){
  
  Sys.sleep(2)
  song_id <- trackIds[i]
  url <- paste0("https://itunes.apple.com/lookup?id=", song_id)
  response <- fromJSON(url)
  itunes_data <- response$results
  })
  
saveRDS(itunes_data, "itunes_data.rds")
