#' Get Data from Kolada API
#'
#' This function fetches data from the Kolada API.
#'
#' @param kpi A string of the desired kpi statistic.
#' @param municipality a string of the desired municipality that user wants kpi statistic about.
#' @param year a string for the year the users want statistics about
#'
#' @return A list containing the API response data.
#' @examples
#' \dontrun{
#' get_kolada_data(kpi = "N00945", municipality = "1080", year = "2023")
#' @export

get_kolada_data <- function(kpi, municipality, year) {
  if (!is.character(kpi)) {
    stop("The 'kpi' argument must be a character string.")
  }
  if (!is.character(municipality)) {
    stop("The 'municipality' argument must be a character string.")
  }
  if (!is.character(year)) {
    stop("The 'year' argument must be a character string.")
  }

  # Base URL for the Kolada API
  base_url <- "http://api.kolada.se/v2/data/"
  
  # Full URL
  url <- paste(base_url, "kpi", kpi, "municipality", municipality, "year", year, sep = "/")
  
  #url <- paste(base_url, endpoint, sep ="/")
  
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


