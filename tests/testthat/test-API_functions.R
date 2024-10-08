# Load the testthat package
library(testthat)

# Test suite for the get_kolada_data function
test_that("get_kolada_data handles valid input correctly", {
  
  # Valid inputs (replace with actual test values)
  kpi <- "N01822"  # Example indicator ID
  municipality <- "0180"  # Example municipality ID (Stockholm, for example)
  year <- "2023"
  
  # Mock the response or test with the actual API if available
  # Here we assume the API is available; in a real scenario, you can mock the HTTP response.
  result <- get_kolada_data(kpi, municipality, year)
  
  # Test that the result is a list
  expect_type(result, "list")
  
  # Test that the result has some expected keys/fields
  expect_true("values" %in% names(result))
  
  # Test that the result has some values (adjust based on your API response structure)
  expect_true(length(result$values) > 0)
})

test_that("get_kolada_data handles invalid input types", {
  
  expect_error(get_kolada_data(123, "0123", "2020"), "The 'kpi' argument must be a character string.")
  
  expect_error(get_kolada_data("kpi", 123, "2020"), "The 'municipality' argument must be a character string.")
  
  expect_error(get_kolada_data("kpi", "0123", 2020), "The 'year' argument must be a character string.")
})

test_that("get_kolada_data handles missing parameters", {
  
  # Missing year
  expect_error(get_kolada_data("N71006", "0123", NULL))
  
  # Missing kpi
  expect_error(get_kolada_data(NULL, "0123", "2020"))
  
  # Missing municipality
  expect_error(get_kolada_data("N71006", NULL, "2020"))
})


