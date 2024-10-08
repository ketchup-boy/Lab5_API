# Load the testthat package
library(testthat)

# Test suite for the get_kolada_data function
test_that("get_kolada_data handles valid input correctly", {
  
  # Valid inputs (replace with actual test values)
  kpi <- "N71006"  # Example indicator ID
  municipality <- "0123"  # Example municipality ID (Stockholm, for example)
  year <- "2020"
  
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
  
  # Invalid kpi
  expect_error(get_kolada_data(123, "0123", "2020"), "is.character(kpi)")
  
  # Invalid municipality
  expect_error(get_kolada_data("N71006", 456, "2020"), "is.character(municipality)")
  
  # Invalid year
  expect_error(get_kolada_data("N71006", "0123", 2020), "is.character(year)")
})

test_that("get_kolada_data handles missing parameters", {
  
  # Missing year
  expect_error(get_kolada_data("N71006", "0123", NULL))
  
  # Missing kpi
  expect_error(get_kolada_data(NULL, "0123", "2020"))
  
  # Missing municipality
  expect_error(get_kolada_data("N71006", NULL, "2020"))
})

test_that("get_kolada_data handles API request failures", {
  # Mock the response to simulate an API failure (using the mockr or httptest package)
  # Here we simulate a failed API request by mocking the HTTP status response
  httr::with_mock(
    `httr::http_status` = function(...) list(category = "error"),
    {
      expect_error(get_kolada_data("N71006", "0123", "2020"), "API request failed")
    }
  )
})

test_that("get_kolada_data handles empty API responses", {
  # Mock the API to return an empty response
  httr::with_mock(
    `httr::content` = function(...) list(values = list()),
    {
      result <- get_kolada_data("N71006", "0123", "2020")
      expect_equal(length(result$values), 0)  # Expect empty values
    }
  )
})
