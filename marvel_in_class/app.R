library(shiny)
library(shinythemes)
library(tidyverse)
library(RColorBrewer)

# Read in data

marvel <- read_csv("marvel-wikia-data.csv")

marvel$SEX[is.na(marvel$SEX)] <- "Not Specified"

# Create user interface (ui)

ui <- fluidPage(
  
  theme = shinytheme("slate"),
  titlePanel("Marvel Characters"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("side", 
                   "Choose a side",
                   c("Good Characters",
                     "Bad Characters",
                     "Neutral Characters"))
    ), 
    mainPanel(
      plot(outputId = "marvelplot")
    )
  )
)


server <- function(input, outputs) {
  
  output$marvelplot <- renderPlot({
    ggplot(filter(marvel, ALIGN == input$side), aes(x = Year)) +
      geom_bar(aes(fill = SEX), position = "fill") +
      theme_dark()
  })
  
}


# Run the application 
shinyApp(ui = ui, server = server)

