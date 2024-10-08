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

get_kolada_data <- function(kpi, municipality, year) {
  stopifnot(is.character(kpi) & is.character(municipality) & is.character(year))

  # Base URL for the Kolada API
  base_url <- "http://api.kolada.se/v2/data/"
  
  # Full URL
  url <- paste(base_url, "kpi", kpi, "municipality", municipality, "year", year, sep = "/")
  
  #url <- paste(base_url, endpoint, sep ="/")
  
  # Make the GET request
  
  # Check for errors
  if (httr::http_status(response)$category != "Success") {
    stop("API request failed: ", httr::http_status(response)$message)
  }
  
  # Parse the JSON response content
  content <- httr::content(response, "text")
  parsed_content <- jsonlite::fromJSON(content)
  
  return(parsed_content)
}


municipalities <- get_kolada_data(kpi = "N00945", municipality = "1080", year = "2023")
print(municipalities)

