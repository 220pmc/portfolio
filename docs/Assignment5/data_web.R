# Invoke libraries
library("tidyverse")
library("rvest")

# Assign links to variables

france_top_100 <- "https://music.apple.com/us/playlist/top-100-france/pl.6e8cfd81d51042648fa36c9df5236b8d"
new_zealand_top_100 <- "https://music.apple.com/us/playlist/top-100-new-zealand/pl.d8742df90f43402ba5e708eefd6d949a"
brazil_top_100 <- "https://music.apple.com/us/playlist/top-100-brazil/pl.11ac7cc7d09741c5822e8c66e5c7edbb"
philippines_top_100 <- "https://music.apple.com/us/playlist/top-100-philippines/pl.b9eb00f9d195440e8b0bdf19b8db7f34"

links <- c(france_top_100, new_zealand_top_100, brazil_top_100, philippines_top_100)

# Create Data Frame
apple_data <- map_df(c(1:4), function(i){
  
  Sys.sleep(2)
  link <- links[i]
  
  page <- read_html(link)
  
  trackId <- page %>%
    html_elements(".songs-list") %>%
    html_elements("a") %>%
    html_attr("href") %>%
    .[str_detect(., "/song/")] %>%
    str_remove_all("https://music.apple.com/us/song/")
  
  rank <- page %>%
    html_elements(".songs-list") %>%
    html_elements(".songs-list-row__rank") %>%
    html_text2()

  country_name <- page %>%
    html_elements("h1") %>%
    html_text2() %>%
    str_remove_all("Top 100: ")
  
  return(tibble(country_name,
                trackId,
                rank))
  })

# Save data to RDS
saveRDS(apple_data, "apple_data.rds")

