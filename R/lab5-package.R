#' lab5: Package for Interacting with the Kolada API
#' 
#' The lab5 package provides tools to interact with the Kolada API for retrieving performance data on Swedish municipalities. The key functions are getting municipality data according to KPI values.
#'
#' @section Functions:
#' - `get_municipality_id()`: Gives out the unique ID for inputed municipality name.
#' - `get_kolada_data()`: Retrieves id for a specified municipality and year.
#'
#' @section Vignettes:
#' For detailed usage examples, see the available vignettes:
#' - `browseVignettes("lab5")`
#'
#' @section Example Usage:
#' Fetch the municipality ID for Lund by writting Lund in the argument of the function.
#' 
#' \code{get_municipality_id("Lund")}
#'
#' Retrieve KPI data for a specific municipality:
#' 
#' \code{get_kolada_data("N02799", "0180", "2020")}
#'
#' @keywords internal
"_PACKAGE"

