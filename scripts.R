fence_start <- function(highlights = NULL) {
  highlight_str <- if (!is.null(highlights)) {
    # If the input contains a hyphen, it's a range
    if (grepl("-", highlights)) {
      # Split on hyphen and expand the range
      range_nums <- as.numeric(strsplit(highlights, "-")[[1]])
      paste(range_nums[1]:range_nums[2], collapse = ",")
    } else {
      # Either single value or comma-separated values - pass through
      highlights
    }
  } else {
    NULL
  }

  if (!is.null(highlight_str)) {
    sprintf("````{.r code-line-numbers='%s'}\n", highlight_str)
  } else {
    "````{.r}\n"
  }
}

surveycode <- function(highlights = NULL) {
  survey_text <- '---
format: html
echo: false
warning: false
---

```{r}
library(surveydown)
```

::: {#welcome .sd-page}

# Welcome to `surveydown`!

```{r}
sd_question(
  type  = "mc",
  id    = "has_fav_hero",
  label = "Do you have a favorite super hero?",
  option = c(
    "Yes" = "yes",
    "No"  = "no"
  )
)

sd_next()
```

:::'

  cat(fence_start(highlights))
  cat(survey_text)
  cat("\n````")
}

appcode_short <- function(highlights = NULL) {
  app_text <- 'library(surveydown)

ui <- sd_ui()
  
server <- function(input, output, session) { 

  sd_server()

} 

shiny::shinyApp(ui = ui, server = server)'

  cat(fence_start(highlights))
  cat(app_text)
  cat('\n````')
}

appcode_long <- function(highlights = NULL) {
  app_text <- 'library(surveydown)

# sd_db_config()
db <- sd_db_connect()

ui <- sd_ui()
  
server <- function(input, output, session) { 

  sd_server(db)

} 

shiny::shinyApp(ui = ui, server = server)'

  cat(fence_start(highlights))
  cat(app_text)
  cat('\n````')
}

question_text <- function(highlights = NULL) {
  text_text <- 'sd_question(
  type  = "text",
  id    = "fav_hero_name",
  label = "Who is your favorite super hero?"
)'

  cat(fence_start(highlights))
  cat(text_text)
  cat('\n````')
}

question_mc <- function(highlights = NULL) {
  mc_text <- 'sd_question(
  type  = "mc",
  id    = "hero_universe",
  label = "Which superhero universe do you prefer?",
  option = c(
    "Marvel"                  = "marvel",
    "DC Comics"               = "dc",
    "Independent/Other"       = "other",
    "I like them all equally" = "all"
  )
)'

  cat(fence_start(highlights))
  cat(mc_text)
  cat('\n````')
}

question_mc_buttons <- function(highlights = NULL) {
  mc_buttons_text <- 'sd_question(
  type  = "mc_buttons",
  id    = "dream_power",
  label = "If you could have ONE superpower?",
  option = c(
    "🕸️ Web-slinging"   = "webslinging",
    "🛡️ Super Strength" = "strength",
    "✈️ Flight"         = "flight",
    "🧠 Telepathy"      = "telepathy",
    "⚡️ Super Speed"    = "speed"
  ),
  direction = "vertical"
)'

  cat(fence_start(highlights))
  cat(mc_buttons_text)
  cat('\n````')
}

question_slider_numeric <- function(highlights = NULL) {
  slider_numeric_text <- 'sd_question(
  type  = "slider_numeric",
  id    = "responsibility_scale",
  label = "How much do you agree with
           \"With great power comes 
           great responsibility\"?",
  option = 0:10
)'

  cat(fence_start(highlights))
  cat(slider_numeric_text)
  cat('\n````')
}

show_if_survey <- function(highlights = NULL) {
  survey_text <- '# Conditional Question
sd_question(
  type  = "mc",
  id    = "has_fav_hero",
  label = "Do you have a favorite hero?",
  option = c("Yes" = "yes", "No" = "no")
)

# Target Question
sd_question(
  type  = "text",
  id    = "fav_hero",
  label = "Who is your favorite super hero?"
)'

  cat(fence_start(highlights))
  cat(survey_text)
  cat('\n````')
}

show_if_app <- function(highlights = NULL) {
  app_text <- '# Inside server
sd_show_if(
  input$has_fav_hero == "yes" ~ "fav_hero"
)'

  cat(fence_start(highlights))
  cat(app_text)
  cat('\n````')
}

quarto_r_html <- function(highlights = NULL) {
  quarto_text <- '---
format: html
title: "HTML Page with R Code"
---

# Hello, World!

This is a simple **HTML** page with *R* code.

```{r}
library(ggplot2)

df <- data.frame(x = rnorm(100))
ggplot(df, aes(x = x)) +
  geom_histogram()
```'

  cat(fence_start(highlights))
  cat(quarto_text)
  cat('\n````')
}

quarto_python_pdf <- function(highlights = NULL) {
  quarto_text <- '---
format: pdf
title: "PDF File with Python Code"
---

# Hello, World!

This is a simple **PDF** file with *Python* code.

```{python}
import matplotlib.pyplot as plt
import numpy as np

data = np.random.normal(0, 1, 100)
plt.hist(data)
plt.show()
```'

  cat(fence_start(highlights))
  cat(quarto_text)
  cat('\n````')
}
