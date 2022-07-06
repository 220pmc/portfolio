library(magick)

forecast <- image_read("./images/forecast.png") %>%
  image_scale(480) %>%
  image_extent("500x500", color = "#da2a2a")

reality <- image_read("./images/reality.png") %>%
  image_scale(480) %>%
  image_extent("500x500", color = "#da2a2a")

watch_text <- image_blank(width = 500,
                          height = 500,
                          color = "#fff8ae") %>%
  image_annotate(text = "\n\nWhat I watched in\nthe weather forecast",
                 color = "#000000",
                 size = 50,
                 font = "Impact",
                 gravity = "north") %>%
  image_scale(480) %>%
  image_extent("500x500", color = "#da2a2a")

trust_text <- image_blank(width = 500,
                          height = 500,
                          color = "#fac510") %>%
  image_annotate(text = "\n\nWhen I trust it...",
                 color = "#000000",
                 size = 50,
                 font = "Impact",
                 gravity = "north") %>%
  image_scale(480) %>%
  image_extent("500x500", color = "#da2a2a")

meme_photo <- c(forecast, reality) %>%
  image_append(stack = TRUE)

meme_text <- c(watch_text, trust_text) %>%
  image_append(stack = TRUE)

meme <- c(meme_photo, meme_text) %>%
  image_append()

# add 1st inner frame in black colour
meme <- image_scale(meme, 980) %>%
  image_extent("1000x1000", color = "#000000")

# add 2nd inner frame in wood colour
meme <- image_scale(meme, 980) %>%
  image_extent("1000x1000", color = "#b76f20")

# add 3rd inner frame in darker wood colour
meme <- image_scale(meme, 900) %>%
  image_extent("1000x1000", color = "#5d2906")

# add outer frame in black colour
meme <- image_scale(meme, 980) %>%
  image_extent("1000x1000", color = "#000000")

image_write(meme, "./images/my_meme.png")