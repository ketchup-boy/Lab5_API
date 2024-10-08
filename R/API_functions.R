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

#' Get Data from Kolada API
#'
#' This function fetches data from the Kolada API based on a specific endpoint and query.
#'
#' @param endpoint A string representing the API endpoint (e.g., "ou/municipality", "data").
#' @param query A list of query parameters to filter the API results (optional).
#'
#' @return A list containing the API response data.
#' @examples
#' \dontrun{
#' get_kolada_data("ou/municipality")
#' get_kolada_data("data")
#' }
#' @export
get_kolada_data <- function(endpoint, query = NULL) {
  # Base URL for the Kolada API
  base_url <- "https://api.kolada.se/v2/"
  
  # Full URL
  url <- paste0(base_url, endpoint)
  
  # Make the GET request
  if (is.null(query)) {
    response <- httr::GET(url)
  } else {
    response <- httr::GET(url, query = query)
  }
  
  
  # Check the full response details for debugging
  #print(httr::http_status(response)) # Print the HTTP status
  #print(httr::content(response, "text")) # Print the raw response content
  
  
  # Check for errors
  if (httr::http_status(response)$category != "Success") {
    stop("API request failed: ", httr::http_status(response)$message)
  }
  
  # Parse the JSON response content
  content <- httr::content(response, "text")
  parsed_content <- jsonlite::fromJSON(content)
  
  return(parsed_content)
}




