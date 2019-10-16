#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("State to live"),
  fluidRow(
      column(3,
           wellPanel(
               h4("Apply Filters"),
               h6("This is the simple app that allow you to chose US States to live based on useres prefference in cold weather. Please go and select the range of days that will be acceptable for you to freeze, select how many states you would like to choose from, push the 'Apply' button and explore selected States on map, also you will find some information related to the selected States in the table below. Have fun!"),
               sliderInput("frost", "Mean number of days with minimum temperature below freezing (1931-1960)", min = 0, max = 188, value = c(0, 188), step = 1, round = TRUE),
               numericInput("n", "Number of Top warmest states (1-50)", 50),
               actionButton("Apply", "Update View")

           )),
      column(9,
             plotlyOutput("map")
             
                 )
             ),
  fluidRow(
      column(12,
             wellPanel(
                 span("States information",
                      tableOutput("selected_states")))
      )
  )
  
))
