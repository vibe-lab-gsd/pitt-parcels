library(shiny)

# Define UI
ui <- fluidPage(

    # Application title
    titlePanel("Sample Shiny Application"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput("select", label = h3("Select a layer"), 
                      choices = list("Choice 1" = 1, 
                                     "Choice 2" = 2, 
                                     "Choice 3" = 3), 
                      selected = 1)
        ),

        # Show a plot of the generated distribution
        mainPanel(
          mapdeckOutput(outputId = "map", width = "100%", height = "800px")
        )
    )
)

# Define server logic
server <- function(input, output) {
  output$map <- renderMapdeck({
    mapdeck(style = 'mapbox://styles/carole-voulgaris/ckwwo8o9r1pwy14p2luoyuzfn') %>%
      add_geojson(
        data = "parcel_point.geojson",
        fill_colour = input$layers,
        stroke_colour = input$layers,
        palette = "spectral",
        legend = TRUE
      ) 
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
