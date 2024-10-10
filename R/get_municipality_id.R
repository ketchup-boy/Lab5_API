#' Get ID for municipality
#'
#' This function accepts a string for a municipality and returns the kolada ID for the given municipality
#'
#' @param municipality_name String for the desired municipality to get id for
#'
#' @return The id for the input municipality
#' @examples
#' \dontrun{
#' get_municipality("Stockholm")
#' @export

get_municipality_id <- function(municipality_name) {
  # Fetch the data for all municipalities
  base_url <- "https://api.kolada.se/v2/"
  endpoint <- "municipality"
  url <- paste0(base_url, endpoint)
  
  # Make the GET request to fetch all municipalities
  response <- httr::GET(url)
  
  # Check for errors in the API request
  if (httr::http_status(response)$category != "Success") {
    stop("API request failed: ", httr::http_status(response)$message)
  }
  
  # Parse the JSON response content
  content <- httr::content(response, "text")
  municipalities_data <- jsonlite::fromJSON(content)
  
  # Ensure that the 'values' field exists and is a data.frame
  if (!"values" %in% names(municipalities_data)) {
    stop("No 'values' field found in the API response.")
  }
  
  if (!is.data.frame(municipalities_data$values)) {
    stop("'values' is not a data.frame. Please check the API response structure.")
  }
  
  # Search for the municipality by name
  match <- municipalities_data$values[municipalities_data$values$title == municipality_name, ]
  
  # Check if a match is found
  if (nrow(match) == 0) {
    stop("Municipality not found: ", municipality_name)
  }
  
  # Return the municipality ID
  return(match$id[1])
}

# Example usage:
municipality_name <- "Lund"
municipality_id <- get_municipality_id(municipality_name)
print(paste("The municipality ID for", municipality_name, "is", municipality_id))

