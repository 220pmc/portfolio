# Invoke library
library(tidyverse)
library(ggplot2)

song_data <- readRDS("song_data.rds")

song_data_duration_rank <- mutate(song_data,
                                  duration_min = trackTimeMillis * 10^-3 / 60,
                                  rank_numberic = as.numeric(rank),
                                  top_50 = ifelse(rank_numberic <= 50,
                                                  "Top 50 songs",
                                                  "Bottom 50 songs"))

country_median_duration = summarise(group_by(song_data_duration_rank, country_name),
                                    median_duration = median(duration_min, na.rm = TRUE))

# Create Visualisation
plot1 <- ggplot() +
  
  geom_boxplot(data = song_data_duration_rank,
               aes(x = duration_min,
                   y = reorder(country_name, duration_min),
                   color = top_50,
                   fill = top_50),
               lwd = 0.5,
               position = "dodge2") +
  
  geom_point(data = country_median_duration,
             aes(x = median_duration,
                 y = country_name),
             color = "brown",
             shape = 17,
             size = 4) +
  
  labs(title = "Song Duration from 4 different Apple Music's Top 100 Daily Playlists",
       x = "Duration (min)",
       y = "Playlist Region",
       caption = "Source: Apple Music\nRetrieved on 29/5/2022") +
  
  scale_x_continuous(breaks = seq(0, 10, 1)) +

  scale_colour_manual(values = c("#ff2b0e", "#5a99ff")) +
  
  scale_fill_manual(values = c("#ff9b8e", "#a6c8ff")) +
  
  theme(panel.background = element_rect(fill = "#e3eee9",
                                        colour = "#00a83e"))
  
ggsave("song_vis.png", plot = plot1, width = 8, height = 5, units = "in")

saveRDS(country_median_duration, "data_country_median_duration.RDS")