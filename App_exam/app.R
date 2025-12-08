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
        choices = c("Oui" = "oui", "Non" = "non")
      ),
      selectInput(
        inputId = "couleur_filter",
        label = "Choisir une couleur à filtrer :",
        choices = c("D","E","F","G","H","I","J")
      ),
      sliderInput(
        inputId = "prix",
        label = "Prix maximum :",
        min = 300,
        max = 20000,
        value = 5000,
        step = 100
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
