#' Get Data from Kolada API
#'
#' This function fetches data from the Kolada API.
#'
#' @param endpoint A string representing the API endpoint (e.g., "municipality").
#' @param query A list of query parameters to filter the API results (optional).
#'
#' @return A list containing the API response data.
#' @examples
#' \dontrun{
#' get_kolada_data("municipality")
#' get_kolada_data("ou/municipality", list(name = "Stockholm"))
#' }
#' @export
get_kolada_data <- function(endpoint, query = list()) {
  # Base URL for the Kolada API
  base_url <- "https://api.kolada.se/v2/"
  
  # Full URL
  url <- paste0(base_url, endpoint)
  
  # Make the GET request
  response <- httr::GET(url, query = query)
  
  # Check for errors
  if (httr::http_status(response)$category != "Success") {
    stop("API request failed: ", httr::http_status(response)$message)
  }
  
  # Parse the JSON response content
  content <- httr::content(response, "text")
  parsed_content <- jsonlite::fromJSON(content)
  
  return(parsed_content)
}



municipalities <- get_kolada_data("municipalities")
print(municipalities)

