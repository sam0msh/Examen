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
      ),
      actionButton(
        inputId = "visu",
        label = "Visualiser le graph",
        class = "btn-primary"
      )
    ),
    mainPanel(
      textOutput(outputId = "filtres"),
      plotly::plotlyOutput(outputId = "DiamantPlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Texte des filtres
  output$filtres <- renderText({
    paste0("Prix : ", input$prix,
           "  &  Couleur : ", input$couleur_filter)
  })
  # Graphique
  output$DiamantPlot <- renderPlotly({
    df <- diamonds %>%
      filter(color == input$couleur_filter, price <= input$prix)
    
    couleur_pts <- ifelse(input$couleur_points == "oui", "pink", "black")
    
    mygraph <- ggplot(df, aes(carat, price)) +
      geom_point(color = couleur_pts) +
      labs(x = "Carat", y = "Prix")
    
    ggplotly(mygraph )
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
