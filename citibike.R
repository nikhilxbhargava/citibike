library(tidyverse)
library(shiny)

# source("R/distance_convert.R")
#load data
trips = as_tibble(read.csv("data/citibike-trips.csv"))

#remove trips over 12 hrs long
#remove stations that only have a few trips originating from them
#add distance metric
#and change duration from sec to min
#add mph
trips = {
  trips %>%
    mutate(appearances = n(), .by = "start_station_name") %>%
    filter(appearances>=100) %>% 
    mutate(distance = distance_conversion(start_station_latitude,
                                          start_station_longitude,
                                          end_station_latitude,
                                          end_station_longitude)) %>%
    filter(distance>0) %>% 
    mutate(tripduration = tripduration/60) %>% 
    filter(tripduration <= 720) %>% 
    mutate(speed = (distance*0.000621371*60)/tripduration) %>% 
    filter(speed<45) %>% 
    select(tripduration, 
           starttime, 
           start_station_name, 
           end_station_name,
           distance, 
           speed) %>% 
    arrange(-speed)
}


ui <- fluidPage(
  titlePanel("Citibike Data"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "station", 
                  label = "Origin Station",
                  choices = sort(unique(trips$start_station_name)),
                  selected = "72"),
      selectInput(inputId = "mspeed",
                  label = "Minimum Speed (mph)",
                  choices = 0:45,
                  selected = 0),
      dateInput(inputId = "start",
                label = "Start Date: ",
                value = "2013-07-01 00:02:24"),
      dateInput(inputId = "end",
                label = "End Date: ",
                value = "2017-12-31 22:12:46")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Graphical", plotOutput("trip_data")),
        tabPanel("Table", dataTableOutput("trip_speed")),
        tabPanel("About", includeMarkdown("about.Rmd"))
      )
    )
  )
)

server <- function(input, output, session) {
  chosen_ss = reactive({
    trips %>%
      filter(start_station_name == input$station) %>% 
      filter(starttime >= input$start) %>% 
      filter(starttime <= input$end) %>% 
      filter(speed > input$mspeed)
  })
  output$trip_data = renderPlot({
    ggplot(data = chosen_ss(), aes(x = tripduration, y = distance)) + 
      geom_point()
  })
  output$trip_speed = renderDataTable(chosen_ss())
}

shinyApp(ui, server)