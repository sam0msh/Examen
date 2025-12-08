library(shiny)
library(ggplot2)
library(plotly)
library(DT)
library(bslib)

# Define UI for application
ui <- fluidPage(
  titlePanel("Exploration des Diamants"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "couleur_points",
        label = "Colorier les points en rose ?",
        choices = c("Oui" = "oui", "Non" = "non"),
      )
      ),
      
      
    mainPanel(
      plotly::plotlyOutput(outputId = "DiamantPlot")
  )
 )
)

# Define server logic
server <- function(input, output) {

}

# Run the application 
shinyApp(ui = ui, server = server)
