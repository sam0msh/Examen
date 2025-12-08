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
      plotly::plotlyOutput(outputId = "DiamantPlot"),
      DT::DTOutput(outputId = "tableau")
    )
  )
)

# Define server logic
server <- function(input, output) {
  rv <- reactiveValues(df = NULL)
  
  observeEvent(input$visu, {
    rv$couleur_points <- input$couleur_points
    rv$couleur_filter <- input$couleur_filter
    rv$prix <- input$prix
    
    rv$df <- diamonds %>%
      filter(color == rv$couleur_filter,
             price <= rv$prix)
  })
  
  # Texte des filtres
  output$filtres <- renderText({
    req(input$visu)   # n'affiche rien avant la première visualisation 
    paste0("Prix : ", rv$prix,
           "  &  Couleur : ", rv$couleur_filter)
  })
  
  # Graphique
  output$DiamantPlot <- renderPlotly({
    req(rv$df)
    
    couleur_pts <- ifelse(rv$couleur_points == "oui", "pink", "black")
    
    mygraph <- ggplot(rv$df, aes(carat, price)) +
      geom_point(color = couleur_pts) +
      labs(x = "Carat", y = "Price")
    
    ggplotly(mygraph)
  })
  
  # Tableau
  output$tableau <- DT::renderDT({
    rv$df
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
