library(shiny)
library(httr)
library(jsonlite)

# Your get_kolada_data function
get_kolada_data <- function(kpi, municipality, year) {
  stopifnot(is.character(kpi) & is.character(municipality) & is.character(year))
  
  # Base URL for the Kolada API
  base_url <- "http://api.kolada.se/v2/data/"
  
  # Full URL
  url <- paste(base_url, "kpi", kpi, "municipality", municipality, "year", year, sep = "/")
  
  # Make the GET request
  response <- httr::GET(url)
  
  # Check for errors
  if (httr::http_status(response)$category != "Success") {
    stop("API request failed: ", httr::http_status(response)$message)
  }
  
  # Parse the JSON response content
  content <- httr::content(response, "text")
  parsed_content <- jsonlite::fromJSON(content)
  
  return(parsed_content)
}

# Define the UI
ui <- fluidPage(
  titlePanel("Kolada API Data Viewer"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("kpi", "KPI:", value = "ExampleKPI"),
      textInput("municipality", "Municipality:", value = "0123"),
      textInput("year", "Year:", value = "2020"),
      actionButton("submit", "Get Data"),
      br(),
      p("Enter the KPI, Municipality, and Year to retrieve data from Kolada.")
    ),
    
    mainPanel(
      tableOutput("api_data"), # This will display the parsed API response
      verbatimTextOutput("error_message") # To display any error messages
    )
  )
)

# Define the server logic
server <- function(input, output, session) {
  # Reactive expression to get the data when the button is pressed
  data <- eventReactive(input$submit, {
    tryCatch({
      # Call the API function
      result <- get_kolada_data(input$kpi, input$municipality, input$year)
      result
    }, error = function(e) {
      # If there's an error, return NULL and display the error message
      output$error_message <- renderText({ as.character(e$message) })
      NULL
    })
  })
  
  # Display the data in a table
  output$api_data <- renderTable({
    # Only render if data is available and not NULL
    if (!is.null(data())) {
      data()
    }
  })
}

# Run the app
shinyApp(ui = ui, server = server)