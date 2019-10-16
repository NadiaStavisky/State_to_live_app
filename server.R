#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

#set up dtat set
State <- state.abb
state_data <- as.data.frame(cbind(state.abb,state.x77))
num_col <- c("Population", "Income", "Illiteracy", "Life Exp", "Murder", "HS Grad", "Frost", "Area")
state_data[num_col] <- sapply(sapply(state_data[num_col],as.character), as.numeric)

# Define server logic required for the app
function(input, output){
    #Filter the states
    states_selected <- eventReactive(input$Apply, {
        #make temp variables for input values
        minfrost <- input$frost[1]
        maxfrost <- input$frost[2]
        topn <- isolate(input$n)
        #Apply filters
        st <- state_data %>%
            filter(
                Frost >= minfrost &
                Frost <= maxfrost
            ) %>%
            arrange(Frost)
        st <- head(as.data.frame(st), n = topn)
    })
    output$map <- renderPlotly({
        borders <- list(color = toRGB("red"))
        #Set up some mapping options
        map_options <- list(
            scope = 'usa',
            projection = list(type = 'albers usa'),
            showlakes = TRUE,
            lakecolor = toRGB("white")
        )
        map_data <- states_selected()
        p <-plot_ly(data = map_data, z = map_data$Frost, locations = map_data$state.abb,
                type = 'choropleth', locationmode = 'USA-states',
                color = map_data$Frost, colors = 'Spectral', marker = list(line = borders)) %>%
            layout(geo = map_options)
        print(p)
    })
    output$selected_states <- renderTable({ states_selected() })
}
