# Invoke library
library(tidyverse)
library(ggplot2)

song_data <- readRDS("song_data.rds")

nz_song_id <- filter(song_data, country_name == "New Zealand")$trackId

song_data <- mutate(song_data,
                   similarity = trackId %in% nz_song_id,
                   rank_numberic = as.numeric(rank),
                   top_50 = ifelse(rank_numberic <= 50, "Top 50 songs", "Bottom 50 songs"))

common_song_nz_ref <- summarise(group_by(song_data, country_name, top_50),
                                similarity = sum(similarity)) %>%
  filter(country_name != "New Zealand")

# Create Visualisation
plot2 <- ggplot(data = common_song_nz_ref) +
  
  geom_col(aes(x = reorder(country_name, -similarity),
                   y = similarity,
                   color = top_50,
                   fill = top_50),
               lwd = 0.5,
           position = "dodge") +
  
  labs(title = "Similarity Rate of Apple Music's Top 100 Daily Playlists\nbetween New Zealand and Other Countries",
       x = "country",
       y = "Similarity Rate (%)",
       caption = "Source: Apple Music\nRetrieved on 29/5/2022") +
  
  scale_y_continuous(limit = c(0, 20), breaks = seq(0, 20, 5)) +

  scale_colour_manual(values = c("#ff2b0e", "#5a99ff")) +
  
  scale_fill_manual(values = c("#ff9b8e", "#a6c8ff")) +
  
  theme(panel.background = element_rect(fill = "#e3eee9",
                                        colour = "#00a83e"))
  
ggsave("song_creation.png", plot = plot2, width = 8, height = 5, units = "in")

saveRDS(common_song_nz_ref, "data_common_song_nz_ref.RDS")